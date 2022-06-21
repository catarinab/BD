DROP VIEW vendas;

CREATE VIEW vendas(ean, cat, ano, trimestre, mes, dia_mes, dia_semana, distrito, concelho, unidades) AS (
    SELECT produto.ean AS ean,
        categoria.nome AS cat, 
        EXTRACT(YEAR FROM evento_reposicao.instante) AS ano, 
        EXTRACT(QUARTER FROM evento_reposicao.instante) AS trimestre, 
        EXTRACT(MONTH FROM evento_reposicao.instante) AS mes, 
        EXTRACT(DAY FROM evento_reposicao.instante) AS dia_mes, 
        EXTRACT(DOW FROM evento_reposicao.instante) AS dia_semana,
        ponto_de_retalho.distrito AS distrito, 
        ponto_de_retalho.concelho AS concelho, 
        evento_reposicao.unidades AS unidades
    FROM produto, categoria, ponto_de_retalho, evento_reposicao, instalada_em
    WHERE evento_reposicao.ean = produto.ean 
        AND categoria.nome = produto.cat 
        AND evento_reposicao.num_serie = instalada_em.num_serie 
        AND ponto_de_retalho.nome = instalada_em.sitio 
)

/* Para visualizacao */

SELECT * FROM vendas;