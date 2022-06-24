Rails.application.routes.draw do
	  require 'sidekiq/web'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post "/login", to: "sessions#login"
  post "/signup", to: "sessions#signup"

  resources :posts
  resources :comments
  mount Sidekiq::Web => '/sidekiq'
end