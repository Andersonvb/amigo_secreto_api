Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :workers, defaults: { format: :json }
  resources :locations, defaults: { format: :json }
  resources :games, defaults: { format: :json }
end
