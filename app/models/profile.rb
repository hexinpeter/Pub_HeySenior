class Profile < ActiveRecord::Base
  belongs_to :school
  belongs_to :user
  belongs_to :city

  validates :user, presence: true
  validates :phone,
            format: { with: %r{\A((\+61)|0)\d{9}\Z}ix,
                      message: "Please provide a valid Australian number. No spaces." },
            allow_blank: true

  mount_uploader :photo, FileUploader
end
