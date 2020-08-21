# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#index'
  devise_for :users
  get 'home' => 'home#index'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :posts, only: %i[index create]

      devise_for :user, only: []

      devise_scope :api_v1_user do
        resources :sessions, only: %i[create destroy]
        resources :registrations, only: %i[new create]
      end
    end
  end
end
