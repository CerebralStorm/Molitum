module ApplicationHelper

	def request_from_pdfkit?
    # when generating a PDF, PDFKit::Middleware will set this flag
    request.env["Rack-Middleware-PDFKit"] == "true"
  end
end
