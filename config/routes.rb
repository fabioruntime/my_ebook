require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  root 'pages#home'
  resources :ebooks, constraint: { id: /\d+/ }
  resources :ebooks do
    member do
      patch :change_status
    end
  end

  get 'signup', to: 'users#new'
  resources :users, except: [:new], constraint: { id: /\d+/ }
  resources :users do
    member do
      patch :change_status
    end
  end

  get 'ebooksmanagement', to: 'ebooks#manager_ebooks'
  get 'usersmanagement', to: 'users#manager_users'
  get 'ebook/book', to: 'ebooks#book'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  scope '/checkout' do
    get 'new', to: 'checkout#new', as: 'checkout_new'
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end
end
