class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :customer_id
      t.integer :job_id
      t.integer :company_id
      t.date    :billing_start
      t.date    :billing_end
      t.float   :total_due, default: 0
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end