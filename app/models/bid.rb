class Bid < ActiveRecord::Base
  before_save :default_values

  belongs_to :user
  belongs_to :task

  validates :user, :task, :price, presence: true

  def default_values
    self.status ||= 'open'
  end
end
