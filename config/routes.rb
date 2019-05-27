Rails.application.routes.draw do
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'

  resources :users
  
  root 'welcome#home'
end
