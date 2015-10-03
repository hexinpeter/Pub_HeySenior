class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user

  def show
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

  def dashboard
  end

  private

    def set_user
      @user = current_user
    end

    def profile_params
      input = params.require(:profile).permit(:school, :phone, :photo, :city, :description)
      input['school'] = School.find_by_id(input['school'])
      input['city'] = City.find_by_id(input['city'])
      input
    end
end
