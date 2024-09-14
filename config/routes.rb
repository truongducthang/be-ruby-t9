Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "test" => "test#index"

  namespace :api do
    resources :products, only: [] do
      collection do
        get "newest", to: "products#retrieve_newest_products"
        get "recommended", to: "products#retrieve_recommended_products"
      end
    end
    get "sub_categories", to: "categories#retrieve_subcategories"

    resources :sessions, only: %i[create destroy]
  end
end
