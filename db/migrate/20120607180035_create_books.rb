class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :ISBN
      t.string :titulo
      t.integer :genre_id
      t.boolean :has_ebook
      t.string :cover_url

      t.timestamps
    end
  end
end
