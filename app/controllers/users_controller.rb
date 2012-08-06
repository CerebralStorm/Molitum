class UsersController < ApplicationController
	before_filter :authenticate_user!, except: [:new, :create]
	load_and_authorize_resource
	require 'will_paginate/array'
	
	def index
		@title = 'Employees'
		@users = @users.order("name").page(params[:page]).per_page(10)
	end

	def new
	end

	def show
		@user = User.find(params[:id])
		@company = @user.company
		@time_clocks = @user.time_clocks.order("created_at").page(params[:page]).per_page(10)
		if @user == current_user
			@title = 'My Account'
		else
			@title = 'Employees'
		end
	end

	def edit
		@title = 'Employees'
		@head = 'Edit'
		@user = User.find(params[:id])
	end


	def update
		if @user.update_attributes(params[:user])
			sign_in @user, :bypass => true
			flash[:success] = "Employee Updated"
			redirect_to user_path(@user)
		else
			flash[:error] = "Update Failed"
			render 'edit'
		end
	end

	def create	
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Employee Added"
      redirect_to users_path
    else
    	flash[:error] = "Employee Failed"
      render 'new'
    end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "Employee Deleted"
		redirect_to :back
	end
end
