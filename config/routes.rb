Rails.application.routes.draw do
<<<<<<< HEAD
  get "reviews/index"
  get "reviews/show"
  get "registrations/index"
  get "registrations/show"
  get "venues/index"
  get "venues/show"
  get "categories/index"
  get "categories/show"
  get "events/index"
  get "events/show"
  get "users/index"
  get "users/show"
  root "pages#home"

  resources :users, only: [:index, :show]
  resources :events, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :venues, only: [:index, :show]
  resources :registrations, only: [:index, :show]
  resources :reviews, only: [:index, :show]

=======
  get "pages/home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root "pages#home"
>>>>>>> a045b5448b40c3a993b590962c9df29577ee9599
end
