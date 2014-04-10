Nochat::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'user_registrations' }
  resources :messages, only: [:index, :create]
  root 'messages#index'
end

