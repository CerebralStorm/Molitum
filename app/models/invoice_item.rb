class InvoiceItem < ActiveRecord::Base
  attr_accessible :category, :description, :cost
end
