Rails.application.routes.draw do

  devise_for :companies, path: "companies", controllers: {
    sessions: "companies/sessions",
    registrations: "companies/registrations"
  }
  devise_for :clients, path: "clients", controllers: {
    sessions:"clients/sessions",
    registrations: "clients/registrations"
  }

  get '/company' => "buffets#show", :as => :company_root

  root to: "home#index"

  resources :companies, only: [:new, :create]
  resources :buffets, only: [:new, :create, :show, :edit, :update] do
    get "search", on: :collection
  end
  resources :events, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :event_pricings, only: [:new, :create, :edit, :update, :destroy]
end
