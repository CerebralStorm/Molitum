class InvoiceItemsController < ApplicationController
  include InvoicesHelper

  def create
    @invoice = Invoice.find(current_invoice)
    @invoice_item = @invoice.invoice_items.build(params[:invoice_item])
    if @invoice_item.save
      @invoice.add_to_total_due(@invoice_item.amount)
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def destroy
    @invoice = Invoice.find(current_invoice)
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice.subtract_from_total_due(@invoice_item.amount)
    @invoice_item.destroy
  end

end
