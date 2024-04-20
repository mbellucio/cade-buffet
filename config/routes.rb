Rails.application.routes.draw do
  devise_for :companies
  root to: "home#index"

  resources :companies, only: [:new, :create]
  resources :buffets, only: [:new, :create, :show, :edit, :update]
  resources :events, only: [:new, :create, :show, :edit, :update]
  resources :event_pricings, only: [:new, :create, :edit, :update]
end
