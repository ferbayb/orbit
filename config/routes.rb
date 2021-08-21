Rails.application.routes.draw do
  root 'static_pages#landing'
  resources :tasks
end
