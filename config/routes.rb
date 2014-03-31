Nochat::Application.routes.draw do
  devise_for :users
  resources :messages, only: [:index, :create]
  root 'messages#index'
end

