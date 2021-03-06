class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :isbndb_person_id
      t.string :name
      t.string :first_name
      t.string :last_name
      t.date :birth
      t.integer :city_id
      t.integer :country_id
      t.string :picture_url

      t.timestamps
    end
  end
end
