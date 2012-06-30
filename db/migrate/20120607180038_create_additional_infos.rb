class CreateAdditionalInfos < ActiveRecord::Migration
  def change
    create_table :additional_infos do |t|
      t.integer :book_id
      t.string :picture_url
      t.text :summary
      t.string :notes
      t.string :related_urls
      t.string :awards
      t.date :release_date, :default => Date.new(1900, 1, 1)

      t.timestamps
    end
  end
end
