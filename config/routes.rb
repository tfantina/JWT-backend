# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home' => 'home#index'
  # devise_for :users, controllers: { registrations: 'registrations' }
  namespace :api do
    namespace :v1 do
      get 'post/index'

      devise_scope :user do
        resources :registrations, only: %i[new create]
      end
      resources :sessions, only: %i[create destroy]
    end
  end
end
