class Task < ActiveRecord::Base
  before_save :default_values

  belongs_to :user
  belongs_to :subject_area

  def default_values
    self.status ||= 'open'
  end
end
