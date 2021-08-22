Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'static_pages#landing'
  get "signup" => "users#new"
  resources :tasks
  resources :users
end
