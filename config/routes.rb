Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  get "/search", to: "searches#search"
  resources :users
  resources :posts

   resources :post_images, only: [:new, :create, :index, :show, :destroy] do
    resources :post_comments, only: [:create]
  end
end
