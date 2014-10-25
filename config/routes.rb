Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users

  resources :tickets

  namespace :api do
    namespace :v1 do
      resources :tickets
    end
  end
end
