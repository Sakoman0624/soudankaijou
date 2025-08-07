Rails.application.routes.draw do

  get 'contacts/new'
  get 'contacts/confirm'
  get 'contacts/thanks'
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }



  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:index, :show, :destroy] do
      member do
        patch :withdraw
        patch :reactivate
      end
    end
    resources :rooms, only: [:index, :show, :update, :destroy] do
      member do
        patch :toggle_public
      end
      resources :comments, only: [:create, :update, :destroy]
    end
  end
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    devise_for :users
    get 'privacy', to: 'pages#privacy', as: 'privacy'

    get "users" => redirect("/users/sign_up")

    root to: 'homes#top'
    
    get "tags/guide", to: "tags#guide", as: "tag_guide"
    get 'homes/about', to: 'homes#about', as: :about
    get "search" => "searches#search"
    get "liked_rooms", to: "rooms#liked_rooms"
    resources :rooms do
      member do
        patch :toggle_public
      end
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :update, :destroy]
    end

    resources :my_rooms, only: [:index]


    get 'users/check' => 'users#check'
    patch  '/users/withdraw' => 'users#withdraw'
    resources :users, only: [:show, :edit, :update]
  end
  
  resources :contacts, only: [:new] do
    collection do
      post 'confirm'         # 確認画面に送信（POST）
      post 'thanks'          # 送信処理（POST）
      get  'thanks', to: 'contacts#thanks'  # 完了画面（GET）
    end
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
