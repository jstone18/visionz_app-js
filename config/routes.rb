Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :users, only: [:show]

  resources :posts do
    member do
      get 'like', to: 'posts#upvote'
      get 'dislike', to: 'posts#downvote'
    end
    resources :comments
  end

  authenticated :user do
    root 'posts#index', as: :authenticated_root
  end

  root "welcome#home"

end
