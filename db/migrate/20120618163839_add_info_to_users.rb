class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :name, :string
    add_column :users, :unpaid_hours, :float, default: 0
    add_column :users, :paid_hours, :float, default: 0
    add_column :users, :pay_rate, :float, default: 0
    add_column :users, :total_hours, :float, default: 0
    add_column :users, :company_id, :integer
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :integer
    add_column :users, :phone, :string
    add_column :users, :address, :string
  end
end

