NoChat::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'user_registrations' }
  resources :messages, only: [:index, :create]
  root 'home#index'
end

