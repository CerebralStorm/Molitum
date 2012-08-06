class CompaniesController < ApplicationController
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
  end

  def update
    @company = Company.find(params[:id])
  end

  def destroy
    @company = Company.find(params[:id]).destroy
  end
end
