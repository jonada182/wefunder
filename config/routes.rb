Rails.application.routes.draw do
  resources :slides
  resources :pitches
  resources :companies, param: :slug
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
