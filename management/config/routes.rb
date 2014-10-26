Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users

  resources :tickets do
    resources :responses, only: [:create]
  end

  namespace :api do
    namespace :v1 do
      resources :tickets, only: [:create]
    end
  end
end
