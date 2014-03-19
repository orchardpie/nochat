Nochat::Application.routes.draw do
  devise_for :users
  resources :messages, only: :index
  root 'messages#index'
end

