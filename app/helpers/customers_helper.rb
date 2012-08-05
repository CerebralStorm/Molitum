module CustomersHelper

	def remember_customer(customer)
		session[:customer_token] = customer.id
	end

	def current_customer
		session[:customer_token]
	end

end
