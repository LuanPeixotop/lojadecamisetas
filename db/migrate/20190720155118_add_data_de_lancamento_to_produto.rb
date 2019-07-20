class AddDataDeLancamentoToProduto < ActiveRecord::Migration[5.2]
  def change
    add_column :produtos, :data_de_lancamento, :date
  end
end
