Rails.application.routes.draw do
  resources :departamentos
  root "produtos#index"
  resources :produtos, only: [:create, :destroy, :new, :index, :edit, :update]
  get "/produtos/busca" => "produtos#busca", as: :busca_produto
  get "/produtos/graficos" => "produtos#graficos"
end
