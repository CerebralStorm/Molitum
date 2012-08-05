prawn_document do |pdf|
  #title
  pdf.text "Grindstone Properties", size: 20, style: :bold
  pdf.text "1271 Westminster Ave.", size: 10
  pdf.text "801-347-4984", size: 10
  pdf.text "Salt Lake City, UT, 84105", size: 10

  # Invoice For
  data = []
  data << ["INVOICE FOR:"]
  data << [@invoice.customer.name]
  data << [@invoice.customer.email]
  data << [@invoice.customer.phone]
  data << [@invoice.customer.address]
  data << [(@invoice.customer.city + ", " + @invoice.customer.state + ", " + @invoice.customer.zip.to_s)]
  
  pdf.bounding_box([0, 650], :width => 300) do  
    pdf.table(data) do
      cells.style :borders => [], :padding => 0
      row(0).style :font_style => :bold
      row(1..data.size).style size: 10
    end
  end

  #Invoice Info
  data = []
  data << ["INVOICE NUMBER:", @invoice.id]
  data << ["BILLING START:", @invoice.billing_start.to_s(:short)]
  data << ["BILLING FINISH:", @invoice.billing_end.to_s(:short)]

  pdf.bounding_box([290, 650], :width => 300) do   
    table = pdf.table(data, :column_widths => [150, 125]) do
      cells.style :borders => [], :padding => [2, 8, 2, 8]
      column(0).style :align => :right
      row(0).style :font_style => :bold, :size => 12  # Invoice NUMBER
      row(1..data.size).style size: 10
      column(1).style :borders => [:left]
    end
  end

  pdf.move_down(30)

  data = []
    data << ["ACTIVITY", "DESCRIPTION", "AMOUNT"]
    @invoice.invoice_items.each do |invoice_item|
      data << [invoice_item.activity, invoice_item.description,  number_with_precision(invoice_item.amount, :precision => 2)]
    end
    
    data << ["", "TOTAL", number_to_currency(@invoice.total_due)]
    data << ["", "", number_to_currency(@invoice.total_due)]
    data << ["", "", "PAY THIS AMOUNT"]
    
    pdf.table(data) do
      # Set borders to left and right by default
      cells.style :borders => [:left, :right]
      
      # Quantity
      column(0).style :width => 80, :align => :center
      
      # Description
      column(1).style :width => 300, :align => :center
      
      # Amount
      column(2).style :width => 100, :align => :center

      # Headings
      headings = row(0)
      headings.style :font_style => :bold, :background_color => 'EEEEEE', :align => :center, :size => 7, :padding => 3
      headings.column(0).style :borders => [:top, :bottom, :left]
      headings.column(1).style :borders => [:top, :bottom, :right]
      headings.column(2).style :borders => [:top, :bottom, :right]

      # Subtotal
      subtotal_row = row(data.size - 3)
      subtotal_row.style :align => :center, :padding => 5
      subtotal_row.column(0).style :borders => [:top, :bottom, :left]
      subtotal_row.column(1).style :borders => [:top, :bottom, :left]
      subtotal_row.column(2).style :borders => [:top, :bottom, :left, :right]
      
      # Total
      total_row = row(data.size - 2)
      total_row.style :border_width => 0, :align => :right, :font_style => :bold, :padding => [5, 5, 0, 5]
      total_row.column(2).style :borders => [:top, :left, :right], :border_width => 2, :size => 13, :align => :center

      
      # Pay this amount
      pay_this_amount_row = row(data.size - 1)
      pay_this_amount_row.style :borders => [], :padding => [0, 5, 5, 5]
      pay_this_amount_row.column(2).style :border_width => 2, :borders => [:left, :bottom, :right], :size => 7, :align => :center
    end

    pdf.move_down(30)

    
    data = []
    data << ["DIRECT ALL INQUIRIES TO:", "MAKE ALL CHECKS PAYABLE TO:"]
    data << ["Brandon Petersen", "Grindstone Properties"]
    data << ["N/A", "1271 Westminster Ave."]
    data << ["801-347-4984", "Salt Lake City, UT 84105"]
    
    
    pdf.table(data) do
      cells.style :borders => [], :padding => [0, 30, 0, 4]
      row(0).style :font_style => :bold, size: 10
      row(1..data.size).style size: 8
    end
    
end