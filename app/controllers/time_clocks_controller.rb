class TimeClocksController < ApplicationController	
	before_filter :authenticate_user!
	def create
		@time_clock = current_user.time_clocks.build(params[:time_clock])
		@job = @time_clock.job
		if @time_clock.save
			@time_clock.user.add_unpaid_hours(@time_clock.hours)
			@time_clock.user.add_total_hours(@time_clock.hours)
			@job.add_labor_cost(current_user.pay_rate, @time_clock.hours)
			flash[:success] = "Shift Added"
			redirect_to :back
		else
			flash[:error] = "Shift Failed"
			redirect_to :back
		end
	end

	def update
		@time_clock = TimeClock.find(params[:id])
		@company = @time_clock.job.company
		if @time_clock.paid
			redirect_to :back
		else
			@time_clock.paid = true
			@time_clock.save
			@time_clock.user.subtract_unpaid_hours(@time_clock.hours)
			@company.add_expense(current_user.pay_rate * @time_clock.hours)
			redirect_to :back
		end
	end

	def destroy
		@time_clock = TimeClock.find(params[:id])
		@time_clock.job.subtract_labor_cost(current_user.pay_rate, @time_clock.hours)
		@company = @time_clock.job.company
		@time_clock.job.subtract_from_total(current_user.pay_rate * @time_clock.hours)
		if @time_clock.paid
			@time_clock.user.subtract_total_hours(@time_clock.hours)
			@company.subtract_expense(current_user.pay_rate * @time_clock.hours)
			@time_clock.destroy
			flash[:success] = "Shift Removed"
			redirect_to :back
		else
			@time_clock.user.subtract_total_hours(@time_clock.hours)
			@time_clock.user.subtract_unpaid_hours(@time_clock.hours)
			@time_clock.destroy
			flash[:success] = "Shift Removed"
			redirect_to :back
		end
	end

end
