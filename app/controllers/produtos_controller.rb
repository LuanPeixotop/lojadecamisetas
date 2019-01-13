class ProdutosController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    if not @produtos.present?
      @produtos = Produto.order("#{sort_column} #{sort_direction}")
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
    redirect_to request.referrer
  end

  def busca
    @nome_produto_buscado = params[:nome]
    @produtos_buscado = Produto.where "nome like ?", "%#{@nome_produto_buscado}%"
    @produtos = @produtos_buscado
    @produtos = @produtos.order("#{sort_column} #{sort_direction}")
    render :index
  end

  private
  def sortable_columns
    ["nome", "preco"]
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : "nome"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
