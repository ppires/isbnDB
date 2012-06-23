class CreateSells < ActiveRecord::Migration
  def change
    create_table :sells do |t|
      t.integer :book_id
      t.float :price

      t.timestamps
    end
  end
end
