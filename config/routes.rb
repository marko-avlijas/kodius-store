Rails.application.routes.draw do
  root "store#index"
  get 'store/index'

  resources :line_items, only: [:create, :destroy]
  resource :basket, only: [:destroy]
end
