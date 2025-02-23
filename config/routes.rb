Rails.application.routes.draw do
  
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:index, :destroy]
    resources :rooms, only: [:index, :show, :destroy]
  end
  
  scope module: :public do
    devise_for :users
    get "users" => redirect("/users/sign_up")
  
    root to: 'homes#top'
  
    get 'homes/about', to: 'homes#about', as: :about
    get "search" => "searches#search"
    resources :rooms do
      resources :comments, only: [:create, :destroy]
    end
    
    
    # /users/:id # /users/5 # /users/10
    # /users/decalidfhlk33353lkf
    get 'users/check' => 'users#check'
    patch  '/users/withdraw' => 'users#withdraw'
    resources :users, only: [:show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
