Rails.application.routes.draw do
  resources :cards
  resources :users
  resources :admins
  resources :punch_logs
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
