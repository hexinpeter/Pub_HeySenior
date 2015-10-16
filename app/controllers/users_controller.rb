class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def show
  end

  def visit
    if !User.find_by_id(params[:id])
      redirect_to root_path, alert: 'User does not exist.'
    end

    @user = User.find_by_id(params[:id])

    if @user == current_user
      render :show
    end

    if user_signed_in?
      @message = Message.new
      @message.sender = current_user
      @message.recipient = @user
    end
  end

  def edit
  end

  def update
    if @user.profile.update(profile_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  private

    def set_user
      @user = current_user
    end

    def profile_params
      input = params.require(:profile).permit(:school_id, :phone, :photo, :city_id, :description)
      input
    end
end
