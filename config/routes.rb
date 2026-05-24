Rails.application.routes.draw do
  root "pages#home"
  get "pages/home"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :categories
  resources :venues
  
  resources :users, only: [:index, :show]

  resources :events do
    resources :registrations, only: [:create, :destroy]
    resources :reviews, only: [:create, :destroy]
  end
end