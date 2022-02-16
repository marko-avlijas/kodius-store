Rails.application.routes.draw do
  root "store#index"
  get 'store/index'

  resources :line_items, only: [:create]
  resource :basket, only: [:destroy]
end
