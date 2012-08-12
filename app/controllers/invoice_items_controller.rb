class InvoiceItemsController < ApplicationController
  before_filter :authenticate_user!
  def create
    @invoice = Invoice.find(params[:invoice_id])
    @invoice_item = @invoice.invoice_items.build(params[:invoice_item])
    if @invoice_item.save
      @invoice.add_to_total_due(@invoice_item.cost)
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def destroy
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice.invoice.subtract_from_total_due(@invoice_item.amount)
    @invoice_item.destroy
  end

end
