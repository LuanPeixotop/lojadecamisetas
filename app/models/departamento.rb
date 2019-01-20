class Departamento < ApplicationRecord
    validates :nome, presence: true, uniqueness: { case_sensitive: false }, length: {minimum: 4}
end
