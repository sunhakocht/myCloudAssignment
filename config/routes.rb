Rails.application.routes.draw do
  resources :users, only: [:create, :new]
  resources :categories, only: [:create, :new, :index]
  resources :products, only: [:create, :edit, :new, :index, :destroy, :update]
  resources :sessions, only: [:create, :new, :destroy]
  get "Logout", to: 'sessions#destroy', as: 'logout'
  get "remove", to: "products#destroy", as: 'remove_product'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "categories#index"
end
