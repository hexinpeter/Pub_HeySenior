class Bid < ActiveRecord::Base
  before_save :default_values

  belongs_to :user
  belongs_to :task

  validates :user, :task, :price, presence: true
  validates :status, inclusion: { in: %w(open closed rejected accepted) },
                     allow_blank: true

  def default_values
    self.status ||= 'open'
  end

  def accepted?
    status == 'accepted'
  end

  def open?
    status == 'open'
  end

  def rejected?
    status == 'rejected'
  end

  def closed?
    status == 'closed'
  end

  def close
    update status: 'closed'
  end

  def reject
    update status: 'rejected'
  end

  def accept
    update status: 'accepted'
  end
end
