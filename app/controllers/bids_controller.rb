class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bid, only: [:update, :destroy]
  before_action :check_permission, only: [:update, :destroy]


  def create
    @bid = Bid.new(bid_params)
    @bid.user = current_user

    if @bid.save
      TaskMailer.new_application_email(@bid).deliver_later
      redirect_to @bid.task, notice: 'Bid was successfully created.'
    else
      @task = @bid.task
      @current_user_identity = 'potential_bidder'
      @bidding_form_action = 'show'
      render 'tasks/show'
    end
  end

  def update
    if @bid.update(bid_params)
      redirect_to @bid.task, notice: 'Bid was successfully updated.'
    else
      @task = @bid.task
      @current_user_identity = 'bidder'
      @bidding_form_action = 'show'
      render 'tasks/show'
    end
  end

  def destroy
    task = @bid.task
    @bid.destroy
    redirect_to task, notice: 'Bid was successfully destroyed.'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    def check_permission
      if @bid.user != current_user or !@bid.task.open?
        redirect_to tasks_path, alert: 'Permission denied.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:user_id, :task_id, :description, :status, :price)
    end
end
