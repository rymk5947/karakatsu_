Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  resources :users
  resources :posts

  resources :posts do
    resources :comments, only: [:index]
    resources :likes, only: %i(create destroy)

  end

  resources :users do
    resource :follow

    resources :followings
    resources :followers
  end


end
