Rails.application.routes.draw do
  root 'pages#home'
  resources :ebooks, constraint: { id: /\d+/ }
  resources :ebooks do
    member do
      patch :change_status
    end
  end
  resources :users, except: [:new], constraint: { id: /\d+/ }
  resources :users do
    member do
      patch :change_status
    end
  end
  get 'signup', to: 'users#new'
  get 'ebooksmanagement', to: 'ebooks#manager_ebooks'
  get 'usersmanagement', to: 'users#manager_users'
  get 'ebook/book', to: 'ebooks#book'

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end
end
