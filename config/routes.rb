Rails.application.routes.draw do
  root 'pages#home'
  resources :ebooks
  resources :ebooks do
    member do
      patch :change_status
    end
  end
  resources :users, except: [:new]
  resources :users do
    member do
      patch :change_status
    end
  end
  get 'signup', to: 'users#new'
  get 'ebooksmanagement', to: 'ebooks#manager_ebooks'
  get 'usersmanagement', to: 'users#manager_users'
end
