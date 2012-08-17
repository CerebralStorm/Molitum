class Customer < ActiveRecord::Base
  attr_accessible :name, :address, :email, :city, :state, :zip, :phone
  
  has_many :jobs, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :invoices, dependent: :destroy
  belongs_to :company

  validates :name,  presence: true, length: { maximum: 50 }

  def add_labor_hours(hours)
  	self.time += hours
  end

  def full_address
    self.address + "  |  " + self.city + ", " + self.state + ", " + self.zip.to_s 
  end
end
