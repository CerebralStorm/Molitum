class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
  end

  def show
    @user = User.find(params[:id])
    @time_clocks = @user.time_clocks
  end

  def edit
  end

  def update
  end

  def create
  end

  def delete
  end
end
