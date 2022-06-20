/* 1) Qual o nome do retalhista (ou retalhistas) responsaveis pela reposicao do maior numero de categorias? */

WITH ret_count AS (
    SELECT nome, COUNT(DISTINCT nome_cat) 
    FROM (
        SELECT nome, nome_cat
        FROM responsavel_por NATURAL JOIN retalhista
    ) AS ret_cat GROUP BY nome
)
SELECT nome 
FROM ret_count
WHERE count = (SELECT MAX(count) FROM ret_count);

/* 2) Qual o nome do ou dos retalhistas que sao responsaveis por todas as categorias simples? */

WITH retalhista_simples AS (
	SELECT tin, retalhista.nome
	FROM retalhista NATURAL JOIN responsavel_por JOIN categoria_simples ON responsavel_por.nome_cat = categoria_simples.nome
)
SELECT nome
FROM retalhista_simples;

/* 3) Quais os produtos (ean) que nunca foram repostos?*/

WITH produto_reposto AS (
	SELECT ean, cat, descr
    FROM evento_reposicao NATURAL JOIN produto
)
SELECT ean
FROM produto
WHERE ean NOT IN (
	SELECT ean
    FROM produto_reposto
);

/* 4) Quais os produtos (ean) que foram repostos sempre pelo mesmo retalhista? */

WITH reposicoes_diferente_retalhista AS (
    SELECT ean, COUNT(DISTINCT tin)
    FROM evento_reposicao GROUP BY ean
)
SELECT ean 
FROM reposicoes_diferente_retalhista
WHERE count = 1;