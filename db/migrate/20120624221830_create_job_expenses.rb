class CreateJobExpenses < ActiveRecord::Migration
  def change
    create_table :job_expenses do |t|
    	t.string   :category
      t.string   :description
    	t.float    :cost, default: 0
    	t.integer  :job_id 

      t.timestamps
    end
  end
end

