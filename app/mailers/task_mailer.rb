class TaskMailer < ApplicationMailer

  # successful task creation for task requester
  def create_email(task)
    @task = task
    mail to: @task.user.email, bcc: 'hexinpeter@gmail.com', subject: "Consultation request successfully created"
  end

  # new application notification for task requester
  def new_application_email(bid)
    @bid = bid
    @task = bid.task
    mail to: @task.user.email, subject: "New application"
  end

  # successful acceptance notification for task requester
  def accept_email(task)
    @task = task
    @bid = task.accepted_bid
    mail to: @task.user.email, subject: "Contact your senior to meet"
  end

  # successful acceptance notification for bidder
  def bid_accepted_email(bid)
    @bid = bid
    @task = bid.task
    mail to: @bid.user.email, subject: "Application accepted!"
  end
end
