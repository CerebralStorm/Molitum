class InvoicesController < ApplicationController
  before_filter :authenticate_user!
  def index
    @invoices = current_user.company.invoices.order("created_at").page(params[:page]).per_page(10)
  end

  def new
    @invoice = Invoice.new
    @customers = Customer.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    @company = @invoice.customer.company
    @invoice_items = @invoice.invoice_items.all
  end

  def edit
    @title = 'Invoices'
    @head = 'Edit'
    @invoice = Invoice.find(params[:id])
  end


  def update
    @invoice = Invoice.find(params[:id])
    @company = @invoice.company
    if @invoice.update_attributes(params[:invoice])
      @company.add_income(@invoice.total_due)
      flash[:success] = "Invoice Updated"
      redirect_to invoice_path(@invoice)
    else
      flash[:error] = "Update Failed"
      render 'edit'
    end
  end

  def create 
    @invoice = Invoice.create(params[:invoice])
    if @invoice.save
      flash[:success] = "Invoice Created"
      redirect_to invoice_path(@invoice)
    else
      flash[:error] = "Invoice Failed"
      render 'new'
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @company = @invoice.customer.company
    @company.add_income(@invoice.total_due)
    if @invoice.destroy
      flash[:success] = "Invoice Deleted"
      redirect_to invoices_path
    else
      flash[:Error] = "Failed to Delete"
      redirect_to :back
    end
  end
end
