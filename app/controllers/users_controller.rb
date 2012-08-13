class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
    @users = User.order("name").page(params[:page]).per_page(10)
  end

  def show
    @user = User.find(params[:id])
    @time_clocks = @user.time_clocks.order("created_at").page(params[:page]).per_page(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated"
      redirect_to user_path(@user)
    else
      flash[:error] = "Update Error"
      redirect_to :back
    end
  end

  def create
    @user = User.create(params[:id])
    if @user.save
      flash[:success] = "Profile Created"
      redirect_to user_path(@user)
    else
      flash[:error] = "Creation Error"
      redirect_to :back
    end
  end

  def delete

    if @user = User.find(params[:id]).destroy
      flash[:success] = "Account Deleted"
      redirect_to root
    else
      flash[:error] = "Delete Error"
      redirect_to :back
    end
  end
end
