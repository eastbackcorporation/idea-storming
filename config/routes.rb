# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :themes, only: %i[index show new create edit update]

  root to: 'top#index'
end
