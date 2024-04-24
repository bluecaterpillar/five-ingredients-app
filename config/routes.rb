Rails.application.routes.draw do
  root "pages#home"
  get 'recipes/search', to: 'recipes#search', as: :recipes_search, defaults: { format: :html }

  resources :ingredients
  resources :recipes
end
