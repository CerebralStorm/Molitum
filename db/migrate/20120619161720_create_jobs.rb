class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
    	t.string   :category
    	t.string   :hours
    	t.string   :materials
      t.string   :location
      t.float    :budget
      t.string   :scope_of_work
      t.string   :detail_of_work
      t.datetime :start_date
      t.datetime :finish_date
      t.integer  :customer_id
      t.integer  :company_id
      t.float    :total_cost, default: 0.0
      t.float    :labor_cost, default: 0.0
      t.integer  :status, default: 0

      t.timestamps
    end
  end
end