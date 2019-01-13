class ProdutosController < ApplicationController

  def index
    @produtos_por_nome = Produto.order(:nome)
  end

  def create
    newProduto = params.require(:produto).permit :nome, :descricao, :quantidade, :preco
    Produto.create newProduto
    redirect_to root_path
  end

  def destroy
    produto_id = params[:id]
    Produto.destroy produto_id
    redirect_to root_path
  end

  def busca
    @nome_produto_buscado = params[:nome]
    @produtos_buscado = Produto.where "nome like ?", "%#{@nome_produto_buscado}%"
    @produtos_buscado = @produtos_buscado.order(:nome)
  end
end
