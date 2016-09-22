Rails.application.routes.draw do
  devise_for :users

  resources :posts do
    get :like, on: :member
  end

  resources :blogs

  resource :user, only: [:edit, :show]

  root 'blogs#index'
end
