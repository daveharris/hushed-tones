Blog::Application.routes.draw do
  root to: 'posts#index', as: 'root'

  resources :posts

  resources :tags, only: :show

  get "/login" => "sessions#new", :as => 'login'
  post "/login/new" => "sessions#create", :as => 'new_login'
  get "/logout" => "sessions#destroy", :as => 'logout'
end
