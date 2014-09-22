PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get 'register', to: 'users#new'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  get 'profile', to: 'users#show'
  get 'profile/:id/edit', to: 'users#edit', as: 'edit_profile'

  resources :posts, except: :destroy do
    resources :comments, only: :create
  end

  resources :categories, except: :destroy
  resources :users, except: [:index, :destroy]
  resources :sessions, only: [:new, :create, :destroy]

end
