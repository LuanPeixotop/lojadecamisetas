class ProdutosController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :set_produto, only: [:destroy]

  def index
    if not @produtos.present?
      @produtos = Produto.order("#{sort_column} #{sort_direction}")
    end
  end

  def new 
    @novo_produto = Produto.new
    renderiza_new
  end

  def create
    @novo_produto = Produto.new produto_params

    if @novo_produto.save
      flash[:notice] = "Produto salvo com sucesso!"
      redirect_to root_path
    else
      renderiza_new
    end
  end

  def destroy
    set_produto
    @produto.destroy
    flash[:notice] = "Produto removido com sucesso!"
    redirect_to request.referrer
  end

  def busca
    @produtos_buscado = Produto.where "nome like ?", "%#{params[:nome]}%"
    @produtos = @produtos_buscado
    @produtos = @produtos.order("#{sort_column} #{sort_direction}")
    render :index
  end

  private

  def set_produto
    @produto = Produto.find(params[:id])
  end

  def produto_params
    params.require(:produto).permit :nome, :descricao, :quantidade, :preco, :departamento_id
  end

  def renderiza_new
    @departamentos = Departamento.all
    render :new
  end
  
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
