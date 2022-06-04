# frozen_string_literal: true
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'top#index'

  resources :users, only: [:create] do
    collection do
      get :sign_up
      get :sign_in
      post :login
      delete :sign_out
    end
  end

  resources :portfolios do
    resources :stocks, controller: :portfolio_stocks, param: :ticker, only: [:new, :create, :destroy]

    member do
      post :reorder
    end
  end
end
