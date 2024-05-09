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
    get "company", on: :collection
    post "awaiting", on: :member
    post "confirmed", on: :member
    post "canceled", on: :member
    resources :budgets, only: [:new, :create]
  end

  namespace :api do
    namespace :v1 do
      resources :buffets, only: [:index, :show] do
        resources :events, only: [:index]
      end
    end
  end
end
