Departamento.create(nome: "Roupas Masculinas")
Departamento.create(nome: "Roupas Femininas")

lista_de_data = []
lista_de_precos = []
lista_de_quantidades = []
100.times do
    lista_de_data << Time.now - rand(1..365).day
    lista_de_precos << rand(1..1000).to_d
    lista_de_quantidades << rand(1..100)
end

500.times do |i|
    i = i.to_s
    Produto.create(nome: "Camisa Masculina " + i, descricao: "Camisa Masculina " + i + " criada via seed", preco: lista_de_precos.sample, quantidade: lista_de_quantidades.sample, departamento_id: 1, data_de_lancamento: lista_de_data.sample)
    Produto.create(nome: "Camisa Feminina " + i, descricao: "Camisa Feminina  " + i + " criada via seed", preco: lista_de_precos.sample, quantidade: lista_de_quantidades.sample, departamento_id: 2, data_de_lancamento: lista_de_data.sample)
end

puts "500 camisas masculinas e 500 camisas femininas criadas!"