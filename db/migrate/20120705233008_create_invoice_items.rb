class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.string :category
      t.string :description
      t.float :hours, default: 0
      t.float :materials, default: 0
      t.float :cost, default: 0

      t.timestamps
    end
  end
end

