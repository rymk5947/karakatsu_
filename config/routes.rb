Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  resources :users
  resources :posts
end
