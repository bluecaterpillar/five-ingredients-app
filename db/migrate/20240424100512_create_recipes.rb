class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :cook_time
      t.string :integer
      t.integer :prep_time
      t.float :ratings
      t.string :cuisine
      t.string :category
      t.string :author
      t.string :image_url

      t.timestamps
    end
  end
end
