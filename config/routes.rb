NoChat::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'user_registrations' }
  resources :users, only: [:show]
  resources :messages, only: [:index, :create, :show]
  root 'home#show'
end

