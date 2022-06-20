
DROP VIEW vendas;

CREATE VIEW vendas AS
FOR EACH ROW ON evento_reposicao
    SELECT produto.ean, categoria.nome, EXTRACT(YEAR FROM evento_reposicao), EXTRACT(QUARTER FROM evento_reposicao), 
    EXTRACT(MONTH FROM evento_reposicao), EXTRACT(DAY FROM evento_reposicao), EXTRACT(DOW FROM evento_reposicao),
    ponto_de_retalho.distrito, ponto_de_retalho.concelho, evento_reposicao.unidades
    FROM produto, categoria, ponto_de_retalho, evento_reposicao, instalada_em
    WHERE evento_reposicao.ean = produto.ean AND categoria.nome = produto.cat AND 
    evento_reposicao.num_serie = instalada_em.num_serie AND ponto_de_retalho.nome = instalada_em.sitio 

/*PARA DAR DISPLAY*/

SELECT * FROM vendas;