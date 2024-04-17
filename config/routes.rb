Rails.application.routes.draw do
  devise_for :companies
  root to: "home#index"

  resources :companies, only: [:new, :create]
end
