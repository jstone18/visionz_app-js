Rails.application.routes.draw do

  devise_for :users
  resources :posts do
    resources :comments
  end

  authenticated :user do
    root 'posts#index', as: :authenticated_root
  end

  root "welcome#home"

end
