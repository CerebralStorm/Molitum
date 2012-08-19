prawn_document do |pdf|
  #title
  pdf.text "#{@company.name}", size: 20, style: :bold
  pdf.text "#{@company.email}", size: 10
  pdf.text "#{@company.address}", size: 10
  pdf.text "#{@company.phone}", size: 10
  pdf.text "#{@company.city}, #{@company.state}, #{@company.zip}", size: 10

  # Bid For
  data = []
  data << ["ESTIMATE FOR:"]
  data << [@bid.customer.name]
  data << [@bid.customer.email]
  data << [@bid.customer.phone]
  data << [@bid.customer.address]
  data << [(@bid.customer.city + ", " + @bid.customer.state + ", " + @bid.customer.zip.to_s)]
  
  pdf.bounding_box([0, 650], :width => 300) do  
    pdf.table(data) do
      cells.style :borders => [], :padding => 0
      row(0).style :font_style => :bold
      row(1..data.size).style size: 10
    end
  end

  #Bid Info
  data = []
  data << ["ESTIMATE NUMBER:", @bid.id]
  data << ["START:", @bid.start_date.to_s(:short)]
  data << ["FINISH:", @bid.finish_date.to_s(:short)]
  data << ["LOCATION", @bid.location]

  pdf.bounding_box([290, 650], :width => 300) do   
    table = pdf.table(data, :column_widths => [150, 125]) do
      cells.style :borders => [], :padding => [2, 8, 2, 8]
      column(0).style :align => :right
      row(0).style :font_style => :bold, :size => 12  # Bid NUMBER
      row(1..data.size).style size: 10
      column(1).style :borders => [:left]
    end
  end

  pdf.move_down(30)

  data = []
    data << ["CATEGORY", "DESCRIPTION", "AMOUNT"]

    category = ""

    @bid.bid_items.each do |bid_item|
      data << [
                  (category == bid_item.category ? "" : bid_item.category), 
                  bid_item.description, 
                  number_with_precision(bid_item.cost, :precision => 2)
              ]
      category = bid_item.category
    end
    
    data << ["", "SUBTOTAL", number_to_currency(@bid.subtotal)]
    data << ["", "DOWN PAYMENT", number_to_currency(@bid.down_payment)]
    data << ["", "#{@bid.discount_description.upcase} DISCOUNT", number_to_currency(@bid.discount)]
    data << ["", "", number_to_currency(@bid.compute_total)]
    data << ["", "", "TOTAL ESTIMATE PRICE"]
    
    pdf.table(data) do
      # Set borders to left and right by default
      cells.style :borders => [:left, :right]
      
      column(0).style :width => 100, :align => :left
      column(1).style :width => 340, :align => :left, size: 10
      column(2).style :width => 100, :align => :center

      # Headings
      headings = row(0)
      headings.style :font_style => :bold, :background_color => 'EEEEEE', :align => :center, :size => 7, :padding => 3
      headings.column(0).style :borders => [:top, :bottom, :left]
      headings.column(1).style :borders => [:top, :bottom]
      headings.column(2).style :borders => [:top, :bottom, :right]

      # Subtotal
      subtotal_row = row(data.size - 5)
      subtotal_row.style :align => :right, :padding => 5, :background_color => 'AAAAAA'
      subtotal_row.column(0).style :borders => [:top, :bottom, :left]
      subtotal_row.column(1).style :borders => [:top, :bottom, :right]
      subtotal_row.column(2).style :borders => [:top, :bottom, :right], :align => :center

      # Total
      total_row = row(data.size - 2)
      total_row.style :border_width => 0, :align => :right, :font_style => :bold, :padding => [5, 5, 0, 5]
      total_row.column(2).style :borders => [:top, :left, :right], :border_width => 2, :size => 13, :align => :center

      # Discount
      discount_row = row(data.size - 4)
      discount_row.style :align => :right
      discount_row.column(0).style :borders => [:top, :bottom, :left]
      discount_row.column(1).style :borders => [:top, :bottom, :right]
      discount_row.column(2).style :align => :center

      # Bottom
      bottom_row = row(data.size - 3)
      bottom_row.style :align => :right
      bottom_row.column(0).style :borders => [:top, :bottom, :left]
      bottom_row.column(1).style :borders => [:top, :bottom, :right]
      bottom_row.column(2).style :align => :center

      # Pay this amount
      pay_this_amount_row = row(data.size - 1)
      pay_this_amount_row.style :borders => [], :padding => [0, 5, 5, 5]
      pay_this_amount_row.column(2).style :border_width => 2, :borders => [:left, :bottom, :right], :size => 7, :align => :center
    end

    pdf.move_down(30)
    
    pdf.text "Estimate does not include:", style: :bold   
    pdf.text " - Rental of any equipment needed to complete projects."
    pdf.text " - Any additional price increase will be discussed with customer before work is to be done."
    pdf.text " - Any extras will be billed as 'Time and Materials'"
    pdf.text " - If the city/county needs to become involved during the project for any reason customer accepts all costs associated." 

    data = []
    data << ["Customer signature", "___________________________________________", "Date", "__________"]
    data << ["Contractor signature", "___________________________________________", "Date", "__________"]

    pdf.table(data) do
      cells.style :borders => [], :padding => [20, 0, 0, 0], :font_style => :bold
    end

    pdf.move_down(20)
    
    data = []
    data << ["DIRECT ALL INQUIRIES TO:", "MAKE ALL CHECKS PAYABLE TO:"]
    data << ["#{current_user.name}", "#{@company.name}"]
    data << ["#{@company.email}", "#{@company.address}"]
    data << ["#{@company.phone}", "#{@company.city}, #{@company.state}, #{@company.zip}"]

    pdf.table(data) do
      cells.style :borders => [], :padding => [0, 30, 0, 4]
      row(0).style :font_style => :bold, size: 10
      row(1..data.size).style size: 8
    end
    
end