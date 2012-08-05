class CreateTimeClock < ActiveRecord::Migration
  def change
    create_table :time_clocks do |t|
    	t.integer  :start_time
    	t.integer  :end_time
      t.integer  :hours
      t.date     :work_date
      t.boolean  :paid, default: false
      t.integer  :job_id
    	t.integer  :user_id

      t.timestamps
    end
  end
end