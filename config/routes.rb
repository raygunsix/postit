PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get 'register', to: 'users#new'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  get 'pin', to: 'sessions#pin'
  post 'pin', to: 'sessions#pin'

  resources :posts, except: :destroy do
    member do
      post 'vote'
    end
    resources :comments, only: :create do
      member do
        post 'vote'
      end
    end
  end

  resources :categories, except: :destroy
  resources :users, except: [:index, :destroy]
  resources :sessions, only: [:new, :create, :destroy]

end
