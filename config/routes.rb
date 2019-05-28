Rails.application.routes.draw do
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'sessions#create'

  resources :users
  resources :posts

  root 'welcome#home'
end
