PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get 'register', to: 'users#new'
  get 'login', to: 'sessions#new'

  resources :posts, except: :destroy do
    resources :comments, only: :create
  end

  resources :categories, except: :destroy
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create]

end
