class School < ActiveRecord::Base
  validates :name, uniqueness: true
end
