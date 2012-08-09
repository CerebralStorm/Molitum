class CompaniesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
    @title = 'My Company'
  end

  def create
    @company = current_user.build_company(params[:company])
    if @company.save
      flash[:success] = "Company Created"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Creation Failed"
      redirect_to user_path(current_user)
    end
  end

  def update
    @company = Company.find(params[:id])
    if @company.save
      flash[:success] = "Company Updated"
      redirect_to company_path(current_user.company)
    else
      flash[:error] = "Update Failed"
      redirect_to :back
    end
  end

  def destroy
    @company = Company.find(params[:id]).destroy
  end
end
