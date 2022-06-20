/* 1) */
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

/* 2) Qual o nome do ou dos retalhistas que são responsáveis por todas as categorias simples?*/
SELECT nome
FROM responsavel_por NATURAL JOIN retalhista NATURAL JOIN categoria NATURAL JOIN categoria_simples
GROUP BY nome