class ProdutosController < ApplicationController

  def index
    @produtos_por_nome = Produto.order(:nome).limit(5)
    @produtos_por_preco = Produto.order(:preco).limit(2)
  end

  def create
    newProduto = params.require(:produto).permit :nome, :descricao, :quantidade, :preco
    Produto.create newProduto
  end
end
