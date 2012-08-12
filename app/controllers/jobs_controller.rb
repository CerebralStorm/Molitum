class JobsController < ApplicationController
	before_filter :authenticate_user!
	def index
		@jobs = Job.order("created_at").page(params[:page]).per_page(10)
	end

	def new
		@job = Job.new
	end

	def show
		@job = Job.find(params[:id])
		@job_expenses = JobExpense.all
	end

	def edit
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
		flash[:success] = "Job Deleted"
		redirect_to :back
	end
end
