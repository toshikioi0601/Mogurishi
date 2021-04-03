Rails.application.routes.draw do
  root 'top_pages#home'

  get :about,        to: 'top_pages#about'
  get :use_of_terms, to: 'top_pages#terms'
  
  get :signup,       to: 'users#new'
  resources :users
  
  end
