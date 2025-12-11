-- ============================================================
-- Criação das tabelas
-- ============================================================
CREATE TABLE clientes (
    idcliente SERIAL PRIMARY KEY,
    cliente VARCHAR(100),
    sexo CHAR(1),
    estado VARCHAR(2),
    status VARCHAR(20),
    data_cadastro DATE
);

-- Tabela vendedores
CREATE TABLE vendedores (
    idvendedor SERIAL PRIMARY KEY,
    nome VARCHAR(100)
);

-- Tabela vendas
CREATE TABLE vendas (
    idvenda SERIAL PRIMARY KEY,
    idcliente INT REFERENCES clientes(idcliente),
    idvendedor INT REFERENCES vendedores(idvendedor),
    total NUMERIC(10,2),
    data_venda DATE
);

-- ============================================================
-- Inserção de dados de exemplo
-- ============================================================

-- Clientes
INSERT INTO clientes(cliente, sexo, estado, status, data_cadastro) VALUES
('João Silva', 'M', 'SP', 'Silver', '2024-01-10'),
('Maria Santos', 'F', 'RJ', 'Gold', '2024-03-12'),
('Pedro Alves', 'M', 'MG', 'Platinum', '2024-02-20');

-- Vendedores
INSERT INTO vendedores(nome) VALUES
('Carla Souza'),
('Fernando Lima');

-- Vendas
INSERT INTO vendas(idcliente, idvendedor, total, data_venda) VALUES
(1, 1, 5000, '2024-11-10'),
(2, 2, 7000, '2024-11-15'),
(3, 1, 12000, '2024-11-18');

-- ============================================================
-- Consultas básicas e filtros
-- ============================================================

-- Ver todos os clientes
SELECT * FROM clientes;

-- Clientes com status Silver ou Platinum
SELECT cliente, status
FROM clientes
WHERE status IN ('Silver','Platinum');

-- Vendas acima de 6000
SELECT * FROM vendas
WHERE total > 6000;

-- Ordenar clientes por nome
SELECT cliente
FROM clientes
ORDER BY cliente ASC;

-- ============================================================
-- Agregações e métricas
-- ===========================================================

-- Total de vendas
SELECT COUNT(*) AS total_vendas, SUM(total) AS soma_total
FROM vendas;

-- Vendas por vendedor
SELECT idvendedor, COUNT(*) AS qtd_vendas, SUM(total) AS total_vendas
FROM vendas
GROUP BY idvendedor;

-- ============================================================
-- JOINs
-- ===========================================================

-- Combinar clientes e vendas
SELECT c.cliente, v.total
FROM vendas v
INNER JOIN clientes c ON v.idcliente = c.idcliente;

-- Combinar vendedores e vendas
SELECT ve.total, vd.nome
FROM vendas ve
INNER JOIN vendedores vd ON ve.idvendedor = vd.idvendedor;

-- ============================================================
-- Indicador de risco
-- ============================================================

SELECT c.cliente,
CASE
    WHEN v.total > 10000 THEN 'Alto risco'
    WHEN v.total BETWEEN 5000 AND 10000 THEN 'Médio risco'
    ELSE 'Baixo risco'
END AS risco
FROM clientes c
INNER JOIN vendas v ON c.idcliente = v.idcliente;






