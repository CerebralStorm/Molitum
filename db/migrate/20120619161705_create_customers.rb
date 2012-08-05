class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :phone
      t.string :city
      t.string :state
      t.string :zip
      t.integer  :company_id

      t.timestamps
    end
  end
end
