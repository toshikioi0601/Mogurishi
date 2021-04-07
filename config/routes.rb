Rails.application.routes.draw do
  get 'sessions/new'
  root 'top_pages#home'

  get :about,        to: 'top_pages#about'
  get :use_of_terms, to: 'top_pages#terms'

  get :signup,       to: 'users#new'

  resources :users do
  member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :divelogs

  get    :login,     to: 'sessions#new'
  post   :login,     to: 'sessions#create'
  delete :logout,    to: 'sessions#destroy'

  end
