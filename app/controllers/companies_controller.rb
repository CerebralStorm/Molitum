class CompaniesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = current_user.companies.build(params[:company])
    if @company.save
      flash[:success] = "Company Created"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Creation Failed"
      render 'new'
    end
  end

  def update
    @company = Company.find(params[:id])
  end

  def destroy
    @company = Company.find(params[:id]).destroy
  end
end
