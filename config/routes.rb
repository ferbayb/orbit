Rails.application.routes.draw do
  devise_for :users, controllers: {
            registrations: "users/registrations",
          }
  root "static_pages#landing"
  get "signup" => "users#new"
  resources :tasks do
    resources :quotes
  end
  resources :users, only: [:index, :show, :destroy, :edit, :update]
end
