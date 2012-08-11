class CustomersController < ApplicationController
	before_filter :authenticate_user!
	def index
		@title = 'Customers'
		@customers = Customer.order("name").page(params[:page]).per_page(10)
	end

	def new
		@title = 'Customers'
		@head = 'Add'
		@customer = Customer.new
	end

	def show
		@title = 'Customers'
		@customer = Customer.find(params[:id])
	end

	def edit
		@title = 'Customers'
		@head = 'Edit'
		@customer = Customer.find(params[:id])
	end

	def update
		@customer = Customer.find(params[:id])
		if @customer.update_attributes(params[:customer])
			flash[:success] = "Customer Updated"
			redirect_to customers_path
		else
			flash[:error] = "Update Failed"
			render 'edit'
		end
	end

	def create
		@company = current_user.company	
		@customer = @company.customers.create(params[:customer])
	    if @customer.save
	      flash[:success] = "Customer Created"
	      redirect_to customer_path(@customer)
	    else
	    	flash[:error] = "Customer Failed"
	      render 'new'
	    end
	end

	def destroy
		Customer.find(params[:id]).destroy
		flash[:success] = "Customer Deleted"
		redirect_to customers_path
	end
end
