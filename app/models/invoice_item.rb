class InvoiceItem < ActiveRecord::Base
  attr_accessible :category, :description, :cost

  belongs_to :invoice
end
