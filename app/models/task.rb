class Task < ActiveRecord::Base
  before_save :default_values

  belongs_to :user
  belongs_to :subject_area
  has_many :bids

  validates :user, :subject_area, :subject, :upper_price, :lower_price, :location, :title, presence: true

  mount_uploaders :documents, FileUploader

  def default_values
    self.status ||= 'open'
  end

  def bid_already?(user)
    self.bids.find_by_user_id(user.id) ? true : false
  end

end
