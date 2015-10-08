class Task < ActiveRecord::Base
  before_save :default_values

  belongs_to :user
  belongs_to :subject_area
  has_many :bids, dependent: :destroy

  validates :user, :subject_area, :subject, :upper_price, :lower_price, :location, :title, presence: true
  validates :status, inclusion: { in: %w(open closed accepted) },
                     allow_blank: true

  mount_uploaders :documents, FileUploader
  default_scope { order(status: :desc, created_at: :desc) }

  def default_values
    self.status ||= 'open'
  end

  def bid_already?(user)
    self.bids.find_by_user_id(user.id) ? true : false
  end

  def accepted_bid
    bids.find_by_status('accepted')
  end

  def accepted?
    status == 'accepted'
  end

  def open?
    status == 'open'
  end

  def closed?
    status == 'closed'
  end

  def accept
    update status: 'accepted'
  end

  def close
    update status: 'closed'
  end

end
