class ProdutosController < ApplicationController

  def index
    if not @produtos.present?
      @produtos = Produto.order(:nome)
    end
  end

  def new 
    @novo_produto = Produto.new
  end

  def create
    valores = params.require(:produto).permit :nome, :descricao, :quantidade, :preco
    @novo_produto = Produto.new valores
    
    if @novo_produto.save
      flash[:notice] = "Produto salvo com sucesso!"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    produto_id = params[:id]
    Produto.destroy produto_id
    flash[:notice] = "Produto removido com sucesso!"
    redirect_to root_path
  end

  def busca
    @nome_produto_buscado = params[:nome]
    @produtos_buscado = Produto.where "nome like ?", "%#{@nome_produto_buscado}%"
    @produtos_buscado = @produtos_buscado.order(:nome)
    @produtos = @produtos_buscado
    render :index
  end
end
