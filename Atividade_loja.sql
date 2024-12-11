CREATE DATABASE LojaEsportiva;
USE LojaEsportiva;

CREATE TABLE Categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL
);

CREATE TABLE Produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL CHECK (preco >= 0),
    quantidade_estoque INT NOT NULL CHECK (quantidade_estoque >= 0),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

INSERT INTO Categorias (nome_categoria)
VALUES ('Roupas Esportivas'), 
       ('Equipamentos de Futebol'), 
       ('Acessórios de Treino');

INSERT INTO Produtos (nome_produto, preco, quantidade_estoque, id_categoria)
VALUES ('Camisa de Futebol', 89.90, 100, 2),
       ('Tênis de Corrida', 299.99, 50, 1),
       ('Faixa de Cabeça', 25.00, 200, 3);
       
SELECT Produtos.nome_produto, Produtos.preco, Produtos.quantidade_estoque, Categorias.nome_categoria
FROM Produtos
JOIN Categorias ON Produtos.id_categoria = Categorias.id_categoria;

SELECT nome_produto, preco, quantidade_estoque
FROM Produtos
JOIN Categorias ON Produtos.id_categoria = Categorias.id_categoria
WHERE Categorias.nome_categoria = 'Equipamentos de Futebol';


SELECT Categorias.nome_categoria, SUM(Produtos.quantidade_estoque) AS total_estoque
FROM Produtos
JOIN Categorias ON Produtos.id_categoria = Categorias.id_categoria
GROUP BY Categorias.nome_categoria
HAVING SUM(Produtos.quantidade_estoque) > 50;

SET SQL_SAFE_UPDATES=0;
UPDATE Produtos
SET preco = 279.99
WHERE nome_produto = 'Tênis de Corrida';


-- Adicionar a nova categoria
INSERT INTO Categorias (nome_categoria) VALUES ('Equipamentos de Basquete');

-- Atualizar o produto para a nova categoria
UPDATE Produtos
SET id_categoria = (SELECT id_categoria FROM Categorias WHERE nome_categoria = 'Equipamentos de Basquete')
WHERE nome_produto = 'Tênis de Corrida';


DELETE FROM Produtos
WHERE nome_produto = 'Faixa de Cabeça';






