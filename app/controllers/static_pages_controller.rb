class StaticPagesController < ApplicationController
  def home
  	@micropost = current_user.microposts.build if signed_in?
  	@shiftdate = current_user.shiftdates.build if signed_in?
  	if signed_in?
  		user = current_user
  		users = User.find_all_by_company(user.company)
  		@feed_items = current_user.feed(users).paginate(page: params[:page])
  	end
  end

  def help
  end

  def about
  end

  def contact
  end

end
