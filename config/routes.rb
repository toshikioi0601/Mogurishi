Rails.application.routes.draw do
  root 'top_pages#home'

  get :about,        to: 'top_pages#about'
  get :use_of_terms, to: 'top_pages#terms'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
