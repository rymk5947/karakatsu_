Rails.application.routes.draw do
  scope module: :public do
    devise_for :users, skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: "public/sessions"
    }

    devise_scope :user do
      get "/users/sign_out", to: "devise/sessions#destroy"
    end

    resources :users do
      resource :follow, only: [:create, :destroy]
      resources :followings, only: [:index]
      resources :followers, only: [:index]
    end

    resources :posts do
      resources :post_comments, only: [:show, :index, :create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
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
