PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get 'register' => 'users#new'

  resources :posts, except: :destroy do
    resources :comments, only: :create
  end

  resources :categories, except: :destroy
  resources :users, only: [:new, :create]

end
