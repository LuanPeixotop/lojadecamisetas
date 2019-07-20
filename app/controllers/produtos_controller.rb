class ProdutosController < ApplicationController
  
  helper_method :sort_column, :sort_direction
  before_action :set_produto, only: %i[edit update destroy]

  def index
    @produtos = order_and_paginate(Produto.all) unless @produtos.present?
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
    if @produto.update produto_params
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

  def graficos
    @camisas_masculinas = Produto.where 'nome like ?', "%masculina%"
    @camisas_masculinas_por_mes = @camisas_masculinas.group_by_month(:data_de_lancamento).count
    @camisas_femininas = Produto.where 'nome like ?', "%feminina%"
    @camisas_femininas_por_mes = @camisas_femininas.group_by_month(:data_de_lancamento).count
    @camisas_masculinas_e_femininas = Produto.where 'nome like ? or nome like ?', "%masculina%", "%feminina%"
    @camisas_masculinas_e_femininas_por_mes = @camisas_masculinas_e_femininas.group_by_month(:data_de_lancamento).count
    @camisas_masculinas_e_femininas_por_mes_max = @camisas_masculinas_e_femininas_por_mes.values.max
    render :graficos
  end

  private

  def set_produto
    @produto = Produto.find(params[:id])
  end

  def produto_params
    params.require(:produto).permit :nome, :descricao, :quantidade, :preco, :departamento_id, :data_de_lancamento
  end

  def renderiza(view)
    @departamentos = Departamento.all
    render view
  end

  def order_and_paginate(produtos)
    if params[:per_page] != ''
      produtos.order("#{sort_column} #{sort_direction}").paginate(page: params[:page], per_page: params[:per_page])
    else
      produtos.order("#{sort_column} #{sort_direction}").paginate(page: params[:page])
    end
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
