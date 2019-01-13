class Produto < ApplicationRecord
    validates_presence_of :nome, :descricao, :quantidade, :preco
end
