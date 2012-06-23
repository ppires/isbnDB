class CreateAdditionalInfos < ActiveRecord::Migration
  def change
    create_table :additional_infos do |t|
      t.integer :book_id
      t.text :content
      t.string :picture_url

      t.timestamps
    end
  end
end
