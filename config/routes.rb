Rails.application.routes.draw do
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

end
