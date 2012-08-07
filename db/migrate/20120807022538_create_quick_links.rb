class CreateQuickLinks < ActiveRecord::Migration
  def change
    create_table :quick_links do |t|
      t.string :name
      t.string :link
      t.integer :user_id

      t.timestamps
    end
  end
end
