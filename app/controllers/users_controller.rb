class UsersController < ApplicationController
	require 'rubygems'
	require 'active_support/all'

  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]#url直接うったときのため
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def index
  	user = current_user
  	@users = User.paginate(page: params[:page]).find_all_by_company(user.company)
  end

  def show
  	if current_user.admin?
  		d = Date.today
  		d_start = d.beginning_of_month
  		d_end = d.end_of_month
		@next_month_array = (d_start..d_end).to_a


  		user = current_user
  		@users = User.paginate(page: params[:page]).find_all_by_company(user.company)

  		@user = User.find(params[:id])
  		@shiftdates = @user.shiftdates.paginate(page: params[:page])
  		@shiftdate = current_user.shiftdates.build if signed_in?
  	else
  		@user = User.find(params[:id])
  		@shiftdates = @user.shiftdates.paginate(page: params[:page])
  		@shiftdate = current_user.shiftdates.build if signed_in?
  	end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
    	sign_in @user
    	flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(user_params)
  		flash[:success] = "Profile updated"
  		redirect_to @user
  	else
  		render 'edit'
  	end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:company, :name, :email, :password,
                                   :password_confirmation)
    end

    def correct_user
    	@user = User.find(params[:id])
    	redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end 
 end
