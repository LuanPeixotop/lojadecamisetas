class Produto < ApplicationRecord
    belongs_to :departamento

    validates :nome, presence: true, uniqueness: { case_sensitive: false }, length: {minimum: 4}
    validates_presence_of :descricao, :quantidade, :preco, :departamento_id
end
