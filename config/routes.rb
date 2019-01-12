Rails.application.routes.draw do
  resources :produto, only: [:create, :destroy, :new]
  root "produtos#index"
end
