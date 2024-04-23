Rails.application.routes.draw do
  devise_for :companies, path: "companies"
  root to: "home#index"

  resources :companies, only: [:new, :create]
  resources :buffets, only: [:new, :create, :show, :edit, :update]
  resources :events, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :event_pricings, only: [:new, :create, :edit, :update, :destroy]
end
