class JobExpensesController < ApplicationController
	before_filter :authenticate_user!
	def create
		@job = Job.find(params[:job_id])
		@company = @job.customer.company
		@job_expense = @job.job_expenses.build(params[:job_expense])
	    if @job_expense.save
	      @job.add_to_total(@job_expense.cost)
	      @company.add_expense(@job_expense.cost)
	      redirect_to :back
	    else
	      redirect_to :back
	    end
	end

	def destroy
		@job_expense = JobExpense.find(params[:id])
		@job_expense.job.subtract_from_total(@job_expense.cost)
	  @company = @job.company
	  @company.subtract_expense(@job_expense.cost)
		if @job_expense.destroy	
			redirect_to :back
		else
			redirect_to :back
		end
	end
end
