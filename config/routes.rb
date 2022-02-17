Rails.application.routes.draw do
  resources :orders
  root "store#index"
  get 'store/index'

  resources :product_line_items, only: [:create, :destroy]
  resources :bundle_line_items, only: [:create, :destroy]
  resource :basket, only: [:destroy]
  resources :promotions, only: [:create, :destroy]
end
