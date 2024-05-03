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

  resources :events, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :pricings, only: [] do
      resources :event_pricings, only: [:new]
    end
  end

  resources :event_pricings, only: [:create, :edit, :update, :destroy] do
    resources :orders, only: [:new]
  end

  resources :orders, only: [:create, :show] do
    get "client", on: :collection
  end
end
