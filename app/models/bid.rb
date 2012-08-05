class Bid < ActiveRecord::Base
  attr_accessible :budget, :estimated_start_date, :estimated_finish_date, :location, :total, :customer_id, :accepted, :total_materials, 
  :scope_of_work, :detail_of_work, :total_hours, :discount, :down_payment, :discount_description, :subtotal, :hourly_rate
  
  belongs_to :customer
  belongs_to :company

  has_many :bid_items, dependent: :destroy

  validates :location,  presence: true
  validates :customer_id, presence: true
  validates :hourly_rate, numericality: true, presence: true

  CATEGORIES = ['Demolition', 'Framing', 'Tile', 'Finish Work', 'Plumbing', 'Electrical', 'Other']


  def add_to_subtotal(amount)
			self.subtotal += amount
	end

	def subtract_from_subtotal(amount)
			self.subtotal -= amount
	end

  def add_to_total_hours(amount)
      self.total_hours += amount
  end

  def subtract_from_total_hours(amount)
      self.total_hours -= amount
  end

  def add_to_total_materials(amount)
      self.total_materials += amount
  end

  def subtract_from_total_materials(amount)
      self.total_materials -= amount
  end
  
  def hours_cost
      amount = self.total_hours * self.hourly_rate
  end

	def compute_total
		amount = self.subtotal - self.discount - self.down_payment
	end

  def compute_subtotal
    self.subtotal = hours_cost + self.total_materials
  end

	def remaining_budget
		amount = budget - self.total
	end 
end
