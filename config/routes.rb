Rails.application.routes.draw do
  scope module: :public do
    devise_for :users, skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: "public/sessions"
    }

    devise_scope :user do
      get "/users/sign_out", to: "devise/sessions#destroy"
      post "users/guest_sign_in", to: "sessions#guest_sign_in"
    end

    resources :posts do
      member do
        get :favorites
      end
      resources :post_comments, only: [:show, :index, :create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    resources :users do
      get 'favorites', on: :member, to: 'users#favorites'
      resource :relationships, only: [:create, :destroy]
        get :followings, on: :member
        get :followers, on: :member
    end

    resources :users

    delete '/posts/:post_id/post_comments', to: 'post_comments#destroy', as: 'post_comments'


  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "dashboards#index"
    get "dashboards", to: "dashboards#index"
    resources :users, only: [:destroy]
  end

  get '/users/:id/posts', to: 'public/posts#user_posts', as: 'user_posts'



  root to: "public/homes#index"
end
