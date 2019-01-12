class ProdutosController < ApplicationController

  def index
    @produtos_por_nome = Produto.order(:nome).limit(5)
    @produtos_por_preco = Produto.order(:preco).limit(2)
  end

  def create
    newProduto = params.require(:produto).permit :nome, :descricao, :quantidade, :preco
    Produto.create newProduto
    redirect_to root_path
  end

  def destroy
    produto_id = params[:id]
    produto.destroy produto_id
    redirect_to root_path
  end
end
