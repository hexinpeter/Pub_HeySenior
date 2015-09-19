class InterestsController < ApplicationController

  def create
    @interest = Interest.create(interest_params)
    redirect_to root_path, notice: 'Thank you for your interests!'
  end

  private
    def interest_params
      params.require(:interest).permit(:email, :feedback)
    end
end