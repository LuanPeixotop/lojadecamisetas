Rails.application.routes.draw do
  resources :produtos, only: [:create, :destroy, :new]
  root "produtos#index"
end
