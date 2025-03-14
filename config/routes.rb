Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }



  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:index, :destroy] do
      member do
        patch :withdraw
        patch :reactivate
      end
    end
    resources :rooms, only: [:index, :show, :destroy]
  end
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    devise_for :users

    get "users" => redirect("/users/sign_up")

    root to: 'homes#top'

    get 'homes/about', to: 'homes#about', as: :about
    get "search" => "searches#search"
    get "liked_rooms", to: "rooms#liked_rooms"
    resources :rooms do
      member do
        patch :toggle_public
      end
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    resources :my_rooms, only: [:index]


    get 'users/check' => 'users#check'
    patch  '/users/withdraw' => 'users#withdraw'
    resources :users, only: [:show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
