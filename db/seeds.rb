50.times do |i|
    i = i.to_s
    Produto.create(nome: "Camisa Masculina " + i, descricao: "Camisa Masculina criada via seed", preco: 0.5e2, quantidade: 1, departamento_id: 1)
    Produto.create(nome: "Camisa Feminina " + i, descricao: "Camisa Feminina criada via seed", preco: 0.5e2, quantidade: 1, departamento_id: 2)
    puts "50 camisas masculinas e 50 camisas femininas criadas!"
end