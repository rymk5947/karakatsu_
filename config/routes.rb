Rails.application.routes.draw do
  scope module: :public do
    devise_for :users, skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: "public/sessions"
    }

    devise_scope :user do
      get "/users/sign_out", to: "devise/sessions#destroy"
    end

    resources :posts do
      member do
        get :favorites
      end
      resources :post_comments, only: [:show, :index, :create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    resources :users do
      resource :relationships, only: [:create, :destroy]
        get :followings, on: :member
        get :followers, on: :member
    end

    resources :users 
     
    
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "dashboards#index"
    get "dashboards", to: "dashboards#index"
    resources :users, only: [:destroy]
  end

  root to: "public/homes#index"
end
