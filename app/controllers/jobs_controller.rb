class JobsController < ApplicationController
	before_filter :authenticate_user!
	include JobsHelper

	def index
		@title = 'Jobs'
		@jobs = Job.order("created_at").page(params[:page]).per_page(10)
	end

	def new
		@title = 'Jobs'
		@head = 'Add'
		@job = Job.new
	end

	def show
		@title = 'Jobs'
		@job = Job.find(params[:id])
		remember_job(@job)
		@job_expenses = JobExpense.all
	end

	def edit
		@title = 'Jobs'
		@head = 'Edit'
		@job = Job.find(params[:id])
	end

	def update
		@job = Job.find(params[:id])
		if @job.update_attributes(params[:job])
			flash[:success] = "Job Updated"
			redirect_to job_path(@job)
		else
			flash[:error] = "Update Failed"
			render 'edit'
		end
	end

	def create	
			@job = Job.create(params[:job])
	    if @job.save
	      flash[:success] = "Job Created"
	      redirect_to job_path(@job)
	    else
	    	flash[:error] = "Job Failed"
	      render 'new'
	    end
	end

	def destroy
		Job.find(params[:id]).destroy
		flash[:success] = "Job Removed"
		redirect_to :back
	end
end
