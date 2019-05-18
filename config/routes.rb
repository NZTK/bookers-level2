Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :index, :edit]
  resources :books
  resources :post_images, only: [:new, :create, :index, :show]
  root to: 'home#index'
  get  "home/about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
