class ShiftdatesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  def create
  	@shiftdate = current_user.shiftdates.build(shiftdate_params)
    if @shiftdate.save
      flash[:success] = "Shift dates created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

    def shiftdate_params
      params.require(:shiftdate).permit(:date)
    end
end