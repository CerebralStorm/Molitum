class CreateBidItems < ActiveRecord::Migration
  def change
    create_table :bid_items do |t|
      t.string :category
      t.string :description
      t.float :hours, default: 0
      t.float :materials, default: 0
      t.float :cost, default: 0
      t.integer :bid_id

      t.timestamps
    end
  end
end