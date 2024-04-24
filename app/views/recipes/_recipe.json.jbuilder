json.extract! recipe, :id, :name, :cook_time, :integer, :prep_time, :ratings, :cuisine, :category, :author, :image_url, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
