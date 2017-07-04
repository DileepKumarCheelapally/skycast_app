Rails.application.routes.draw do
  get 'home/index'
  get 'home/visualize'
  get 'home/data'
  root 'users#new'
  resources :locations
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
