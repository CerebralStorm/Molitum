class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
  end

  def show
    @user = User.find(params[:id])
    @time_clocks = @user.time_clocks
  end

  def sign_up2
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.save
      flash[:success] = "Profile Updated"
      redirect_to user_path(@user)
    else
      flash[:error] = "Update Error"
      redirect_to :back
    end
  end

  def create
  end

  def delete
  end
end
