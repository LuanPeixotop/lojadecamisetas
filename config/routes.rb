Rails.application.routes.draw do
  root "produtos#index"
  resources :produtos, only: [:create, :destroy, :new]
  get "/produtos/busca" => "produtos#busca", as: :busca_produto
end
