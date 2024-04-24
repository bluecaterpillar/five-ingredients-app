class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def search
    @ingredients = params[:ingredients].reject(&:blank?)
    @recipes = Recipe.joins(:ingredients)
                     .where(ingredients: { name: @ingredients })
                     .select("recipes.*, COUNT(distinct ingredients.id) AS ingredient_count")
                     .group('recipes.id')
                     .having('COUNT(distinct ingredients.id) = ?', @ingredients.count)


    puts params[:ingredients]
    render 'search_results'
  end
end
