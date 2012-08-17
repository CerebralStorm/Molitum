class CompaniesController < ApplicationController
  before_filter :authenticate_user!, :except => [:create]
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
  end

  def create
    @company = Company.create(params[:company])
    if @company.save
      flash[:success] = "Company Created"
      redirect_to :back
    else
      flash[:error] = "Creation Failed"
      redirect_to :back
    end
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      flash[:success] = "Company Updated"
      redirect_to company_path(current_user.company)
    else
      flash[:error] = "Update Failed"
      redirect_to :back
    end
  end

  def destroy
    
    if @company = Company.find(params[:id]).destroy
      flash[:success] = "Company Deleted"
      redirect_to :back
    else
      flash[:error] = "Delete Failed"
      redirect_to :back
    end
  end
end
