Rails.application.routes.draw do
  root 'static_pages#landing'
  get "signup" => "users#new"
  resources :tasks
  devise_for :users
  resources :users
end
