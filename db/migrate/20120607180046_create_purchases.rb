class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :book_id
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
