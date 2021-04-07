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

  resources :divelogs
  resources :relationships, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]

  get    :login,     to: 'sessions#new'
  post   :login,     to: 'sessions#create'
  delete :logout,    to: 'sessions#destroy'

  get :favorites, to: 'favorites#index'
  post   "favorites/:divelog_id/create"  => "favorites#create"
  delete "favorites/:divelog_id/destroy" => "favorites#destroy"
end
