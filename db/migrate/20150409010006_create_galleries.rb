class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.string :target_data

      t.timestamps null: false
    end
  end
end
