Rails.application.routes.draw do
  root "pages#home", as: :home
  get 'recipes/search', to: 'recipes#search', as: :recipes_search, defaults: { format: :html }
  post 'run_rake', to: 'task#run_rake_task'
end
