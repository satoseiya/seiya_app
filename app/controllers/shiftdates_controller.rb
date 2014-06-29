class ShiftdatesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
  	@shiftdate = current_user.shiftdates.build(shiftdate_params)
    if @shiftdate.save
      flash[:success] = "Shift dates created!"
      redirect_to current_user
    else
      render 'static_pages/home'
    end
  end

  def destroy
  	@shiftdate.destroy
    redirect_to current_user
  end

  private

    def shiftdate_params
      params.require(:shiftdate).permit(:date)
    end

    def correct_user
      @shiftdate = current_user.shiftdates.find_by(id: params[:id])
      redirect_to root_url if @shiftdate.nil?
    end
end