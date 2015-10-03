class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    if @user.profile.update(profile_params)
      render :show
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
      input = params.require(:profile).permit(:school, :phone, :photo)
      input['school'] = School.find_by_id(input['school'])
      input
    end
end
