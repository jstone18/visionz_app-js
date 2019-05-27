Rails.application.routes.draw do
  get 'signup', to: 'users#create'
  resources :users
  root 'welcome#home'
end
