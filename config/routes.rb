Blog::Application.routes.draw do
  root to: 'posts#index', as: 'root'

  resources :users
  resources :posts

  resources :sessions, only: [:new, :create]
end
