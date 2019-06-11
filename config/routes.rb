Rails.application.routes.draw do

  authenticated :user do
    root 'posts#index', as: :authenticated_root
  end

  root "welcome#home"
  
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    resources :posts, only: [:index, :new, :show]
  end

  resources :posts do
    member do
      get 'like', to: 'posts#upvote'
      get 'dislike', to: 'posts#downvote'
    end
    resources :comments
  end

  get 'search' => 'search#index'

end
