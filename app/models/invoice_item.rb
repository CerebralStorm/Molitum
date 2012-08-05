class InvoiceItem < ActiveRecord::Base
  attr_accessible :activity, :description, :amount
end
