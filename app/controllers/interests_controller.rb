class InterestsController < ApplicationController

  def create
    @interest = Interest.create(interest_params)
    redirect_to root_path, notice: "Thank you for your interests! We'll definitely let you know when the site is ready :D "
  end

  private
    def interest_params
      params.require(:interest).permit(:email, :feedback)
    end
end