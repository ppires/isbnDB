class CreateAuthorships < ActiveRecord::Migration
  def change
    create_table :authorships do |t|
      t.integer :person_id
      t.integer :book_id
      t.string :role

      t.timestamps
    end
  end
end
