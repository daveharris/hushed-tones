Blog::Application.routes.draw do
  root to: 'posts#index', as: 'home'

  resources :users
  resources :posts
end
