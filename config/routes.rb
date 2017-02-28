Rails.application.routes.draw do
  get 'sessions/new'

  root to: 'static_pages#home'
  get 'all', to: 'static_pages#all_microposts'
  
  get 'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users do
    member do
      get :followings , :followers
    end
  end
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end
