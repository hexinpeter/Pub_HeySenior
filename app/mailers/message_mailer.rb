class MessageMailer < ApplicationMailer

  def send_email(message)
    @message = message

    mail to: @message.recipient.email, subject: "New Message from #{@message.sender.name.capitalize}"
  end
end
