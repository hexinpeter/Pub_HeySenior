class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = Message.new(message_params)

    if (@message.sender == current_user) and (@message.save)
      MessageMailer.send_email(@message).deliver_later
      redirect_to :back, notice: 'Message was successfully created.'
    else
      redirect_to :back, alert: 'Message failed to send.'
    end
  end

  private
    def message_params
      params.require(:message).permit(:sender_id, :recipient_id, :content)
    end
end
