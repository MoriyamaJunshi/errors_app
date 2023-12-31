Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :errors
  get 'search', to: 'errors#search', as: 'search'
  get 'signup', to: 'users#new'
  resources :users, only: [:create]
end
