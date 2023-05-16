SELECT * 
  FROM venda

-- 01 Qual foi a quantidade total de produtos vendidos? 
-- Resp.: 7360!
SELECT SUM(quantidade) AS qtd_total_vendas
  FROM venda

-- 02 Qual foi a quantidade total de vendas realizadasw
-- Resp.: 3000 vendas!
SELECT COUNT(*) AS qtd_total_vendas
  FROM venda

-- 03 Qual foi o valor total de vendas? 
-- Resp.: R$6.704.846,61!
SELECT ROUND(SUM(valor_unitario * quantidade), 2) AS total_vendas
  FROM venda

-- 04 Qual foi o valor total do lucro? 
-- Resp.: R$2.762.533,81!
SELECT ROUND(SUM(valor_unitario * quantidade) - SUM(preco_custo * quantidade), 2)
  FROM venda

-- 05 Quanto em % o lucro representa do total de vendas?
-- Resp.: 41.2%
SELECT (SUM(valor_unitario * quantidade) - SUM(preco_custo * quantidade)) / (SUM(valor_unitario * quantidade)) * 100
  FROM venda

-- 06 Qual foi a loja que mais obteve lucro? 
--Resp.: Matriz - R$731.201,97!
SELECT loja.nome_loja,
	   ROUND((SUM(valor_unitario * quantidade) - SUM(preco_custo * quantidade)), 2) AS lucro
  FROM venda
       JOIN loja ON venda.codigo_loja = loja.codigo_loja
GROUP BY loja.nome_loja
ORDER BY lucro DESC
  
-- 07 Quem foi o vendedor com o melhor desempenho (maior valor de venda)? 
-- Resp.: José Maria - R$654.050,81
SELECT vendedor.nome_vendedor,
	   SUM(valor_unitario * quantidade) AS total_vendas_vendedor
  FROM venda
	   JOIN vendedor ON venda.matricula_vendedor = vendedor.matricula_vendedor
GROUP BY vendedor.nome_vendedor
ORDER BY total_vendas_vendedor DESC

-- 08 Crie um relatório com a quantidade de vendas e valor total de vendas por loja e por vendedor, ordenado pelos respectivos campos.
SELECT loja.nome_loja, 
	   vendedor.nome_vendedor,
	   COUNT(codigo_venda) AS qtd_total_vendas,
	   SUM(valor_unitario * quantidade) AS valor_total_vendas
  FROM venda
	   JOIN vendedor ON venda.matricula_vendedor = vendedor.matricula_vendedor
       JOIN loja ON venda.codigo_loja = loja.codigo_loja
GROUP BY loja.nome_loja, vendedor.nome_vendedor
ORDER BY loja.nome_loja,
	     vendedor.nome_vendedor

