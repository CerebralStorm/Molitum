module InvoicesHelper

  def remember_invoice(invoice)
    session[:invoice_token] = invoice.id
  end

  def current_invoice
    session[:invoice_token]
  end
end
