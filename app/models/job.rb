class Job < ActiveRecord::Base
  attr_accessible :subtotal,  :location, :budget, :description, :total, :labor_cost, :estimated_start_date, 
  								:estimated_finish_date, :status, :customer_id
  belongs_to :customer
  belongs_to :company

  has_many :job_expenses, dependent: :destroy
  has_many :invoices, dependent: :destroy
  
  validates :customer_id, presence: true
  validates :location, presence: true


	def add_labor_cost(pay_rate, hours)
			self.labor_cost += (pay_rate * hours)
			add_to_total(self.labor_cost)
	end	

	def subtract_labor_cost(pay_rate, hours)
			self.labor_cost -= (pay_rate * hours)
			subtract_from_total(self.labor_cost)
	end

	def add_to_total(amount)
			self.total += amount
			self.save
	end	

	def subtract_from_total(amount)
			self.total -= amount
			self.save
	end

	def remaining_budget
		amount = budget - self.total
	end 

	def check_timeframe_for_job
		if Time.now - estimated_finish_date < 1000
			"Ugent"
		else
			"On Schedule"
		end
	end

	def started?
		self.status ==  0 ? false : true 
	end

	def completed?
		self.status ==  4 ? true : false 
	end

	def overdue?
		self.status ==  3 ? true : false
	end

	def on_schedule?
		self.status ==  1 ? true : false
	end

	def status_in_words
		case self.status
			when 0
				"Not Started"
			when 1
				"In Progress"
		 	when 2
		 		"Nearing Completion"
		 	when 3
		 		"Project Overdue"
		 	when 4
		 		"Completed"
		 	else
		 		"An error has occured"
		 	end
	end
end
