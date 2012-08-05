class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
    	t.integer  :customer_id
    	t.string   :time_estimate
      t.string   :materials_estimate
      t.datetime :start_date
      t.datetime :finish_date
      t.string   :location
      t.float    :subtotal, default: 0
      t.float    :total, default: 0
      t.boolean  :accepted, default: false
      t.integer  :company_id          
      t.string   :scope_of_work
      t.string   :detail_of_work
      t.float    :total_hours, default: 0
      t.float    :total_materials, default: 0
      t.float    :discount, default: 0
      t.string   :discount_description
      t.float    :down_payment, default: 0
      t.float    :hourly_rate, default: 0

      t.timestamps
    end
  end
end