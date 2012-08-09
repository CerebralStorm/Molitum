class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.float :income, default: 0
      t.float :expense, default: 0
      t.string :name
      t.string :email
      t.string :website
      t.string :address
      t.string :phone
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end