class ProdutosController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :set_produto, only: %i[edit update destroy]

  def index
    unless @produtos.present?
      @produtos = order_and_paginate(Produto.all)
    end
  end

  def new
    @produto = Produto.new
    renderiza :new
  end

  def create
    @produto = Produto.new produto_params

    if @produto.save
      flash[:notice] = 'Produto salvo com sucesso!'
      redirect_to root_path
    else
      renderiza :new
    end
  end

  def edit
    renderiza :edit
  end

  def update
    if @produto.update produto_paramsparams
      flash[:notice] = 'Produto atualizado com sucesso!'
      redirect_to root_path
    else
      renderiza :edit
    end
  end

  def destroy
    @produto.destroy
    flash[:notice] = 'Produto removido com sucesso!'
    redirect_to request.referrer
  end

  def busca
    @produtos_buscado = Produto.where 'nome like ?', "%#{params[:nome]}%"
    @produtos = order_and_paginate(@produtos_buscado)
    render :index
  end

  private

  def set_produto
    @produto = Produto.find(params[:id])
  end

  def produto_params
    params.require(:produto).permit :nome, :descricao, :quantidade, :preco, :departamento_id
  end

  def renderiza(view)
    @departamentos = Departamento.all
    render view
  end

  def order_and_paginate(produtos)
    produtos.order("#{sort_column} #{sort_direction}").paginate(:page => params[:page], :per_page => 5)
  end

  def sortable_columns
    %w[nome preco]
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : 'nome'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
