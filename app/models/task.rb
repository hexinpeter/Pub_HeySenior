class Task < ActiveRecord::Base
  before_save :default_values

  belongs_to :user
  belongs_to :subject_area

  validates :user, :subject_area, :subject, :upper_price, :lower_price, :location, :title, presence: true

  mount_uploaders :documents, FileUploader

  def default_values
    self.status ||= 'open'
  end
end
