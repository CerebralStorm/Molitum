class Invoice < ActiveRecord::Base
  attr_accessible :customer_id, :billing_start, :billing_end, :total_due, :paid
  
  has_many :invoice_items

  belongs_to :customer
  belongs_to :company

  CATEGORIES = ['Demolition', 'Framing', 'Tile', 'Finish Work', 'Plumbing', 'Electrical', 'Other']

  validates :customer_id, presence: true

  def add_to_total_due (amount)
    self.total_due += amount
    self.save
  end

  def subtract_from_total_due (amount)
    self.total_due -= amount
    self.save
  end
  
  def status
    if self.paid
      "Paid"
    else
      "Not Paid"
    end
  end
end
