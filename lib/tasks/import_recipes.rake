# lib/tasks/import_recipes.rake
namespace :db do
    desc "Import recipes from a JSON file"
    task import_recipes: :environment do
        file_path = Rails.root.join('lib', 'tasks', 'recipes-en.json')
        data = JSON.parse(File.read(file_path))

        data.each do |recipe_data|
            recipe = Recipe.create(
                name: recipe_data["title"],
                cook_time: recipe_data["cook_time"],
                prep_time: recipe_data["prep_time"],
                ratings: recipe_data["ratings"],
                cuisine: recipe_data["cuisine"],
                category: recipe_data["category"],
                author: recipe_data["author"],
                image_url: recipe_data["image"]
            )

            recipe_data["ingredients"].each do |ingredient_string|
                parsed = parse_ingredient(ingredient_string)
                next if parsed.nil?

                ingredient = Ingredient.find_or_create_by(name: parsed[:name])
                RecipeIngredient.create(
                    recipe: recipe,
                    ingredient: ingredient,
                    quantity: parsed[:quantity],
                    unit: parsed[:unit],
                    notes: parsed[:notes]
                )
            end
        end

        puts "Recipes have been imported successfully!"
    end

    def parse_ingredient(ingredient_string)
        # Updated regex handling special cases
        match = ingredient_string.match(/^(?<quantity>[\d\s\/½⅓⅔¼¾]+)?\s*(?<unit>(?!(?:eggs?|bananas?|ripe banana)\b)[a-z.]+)?\s*(?<name>[^,]+)(,\s*(?<notes>.+))?$/i)
        return nil unless match

        {
            quantity: match[:quantity]&.strip,
            unit: match[:unit]&.strip,
            name: "#{['egg', 'eggs', 'banana', 'bananas', 'ripe banana'].include?(match[:unit]) ? match[:unit] + ' ' : ''}#{match[:name]}".strip,
            notes: match[:notes]&.strip
        }
    end
end
