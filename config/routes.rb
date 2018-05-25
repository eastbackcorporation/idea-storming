# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :themes, only: %i[index show new create edit update] do
    resources :ideas, only: %i[create], module: 'themes'
  end
  
  root to: 'top#index'
end
