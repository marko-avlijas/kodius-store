Rails.application.routes.draw do
  root "store#index"
  get 'store/index'
end
