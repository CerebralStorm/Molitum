prawn_document do |pdf|
  #title
  pdf.text "Hours for #{@user.full_name}", size: 20, style: :bold
  pdf.text "Created At: #{Time.now.to_s(:short)}"
  pdf.move_down(30)

  data = []
    data << ["DATE", "HOURS", "CUSTOMER"]
    @user.time_clocks.each do |clock|
      data << [clock.work_date, clock.hours, clock.job.customer.name]
    end
    
    data << ["", "UNPAID HOURS", @user.unpaid_hours]
    data << ["", "TOTAL", @user.total_hours]
    data << ["", "UNPAID DOLLAR AMOUNT", @user.unpaid_dollar_amount]

    pdf.table(data) do
      # Set borders to left and right by default
      cells.style :borders => [:left, :right]
      
      # DATE
      column(0).style :width => 150, :align => :center
      
      # HOURS
      column(1).style :width => 150, :align => :center

      column(2).style :width => 150, :align => :center

      # CUSTOMER
      headings = row(0)
      headings.style :font_style => :bold, :background_color => 'EEEEEE', :align => :center, :size => 7, :padding => 3
      headings.column(0).style :borders => [:top, :bottom, :left]
      headings.column(1).style :borders => [:top, :bottom]
      headings.column(2).style :borders => [:top, :bottom, :right]

      # total
      total_row = row((data.size-3)..(data.size-2))
      total_row.style :align => :center, :padding => 5, :background_color => 'EEEEEE'
      total_row.column(0).style :borders => [:top, :bottom, :left]
      total_row.column(1).style :borders => [:top, :bottom, :right]
      total_row.column(2).style :borders => [:top, :bottom, :left, :right]

      # total
      dollar_row = row(data.size - 1)
      dollar_row.style :align => :center, :padding => 5, :background_color => 'AAAAAA'
      dollar_row.column(0).style :borders => [:top, :bottom, :left]
      dollar_row.column(1).style :borders => [:top, :bottom, :right]
      dollar_row.column(2).style :borders => [:top, :bottom, :left, :right]
    end
    
end