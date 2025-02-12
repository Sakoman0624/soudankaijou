Rails.application.routes.draw do
  devise_for :users
  get "users" => redirect("/users/sign_up")

  root to: 'homes#top'

  get 'homes/about', to: 'homes#about', as: :about
  get "search" => "searches#search"
  resources :rooms
  resources :users, only: [:show, :edit, :update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
