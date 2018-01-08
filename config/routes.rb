Rails.application.routes.draw do
  get 'root/index'
  root to: 'root#index'

  resources :devices
  resources :punch_logs
  resources :cards
  resources :users
  resources :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
