class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_create :create_credentials

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, dependent: :destroy
  has_many :tasks
  has_many :bids

  validates :name, :role, presence: true

  delegate :phone, :school, :photo, :city, :description, to: :profile

  private
    def create_credentials
      create_profile if profile.blank?
    end
end
