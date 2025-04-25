Rails.application.routes.draw do
  get "cart/create"
  get "cart/destroy"
  resources :cart, only: [ :create, :destroy, :index ]
  get "categories/:id", to: "categories#show", as: "category"
  get "products/index", to: "products#index", as: "products"
  get "products/show"
  get "search", to: "products#search", as: "search_products"
  get "about", to: "products#about", as: "about"
  # get "categories", to: "categories#show", as: "categories"
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "products#home"
  resources :products, only: [ :index, :show ]
end
