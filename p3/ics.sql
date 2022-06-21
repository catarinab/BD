/* RI-1) Uma Categoria nao pode estar contida em si propria */

DELIMITER //
    DROP TRIGGER IF EXISTS ri1 //
    CREATE TRIGGER ri1 BEFORE INSERT ON tem_outra
    FOR EACH ROW BEGIN
        /* Obter as super categorias da super categoria da nova relacao. */
        WITH RECURSIVE super AS (
            SELECT tem_outra.super_categoria
            FROM tem_outra
            WHERE categoria = new.super_categoria
            UNION ALL
            SELECT tem_outra.super_categoria
            FROM super, tem_outra
            WHERE super.super_categoria = tem_outra.categoria
        )
        DECLARE x INT;
        SET x = (
            SELECT COUNT(*)
            /* A partir da super categoria da nova relacao junta com as suas super categorias. */
            FROM (
                SELECT super_categoria AS nome
                FROM super UNION ALL (
                    SELECT nome 
                    FROM categoria 
                    WHERE nome = new.super_categoria
                )
            ) AS categoria_prateleira
            /* Verificar se a categoria da nova relacao esta presente nesse conjunto. */
            WHERE categoria_prateleira.nome = new.categoria
        );
        /* Se estiver, lancar um erro. */
        IF x > 0 THEN
            CALL raise_error;
        END IF;
    END//
DELIMITER ;

/* RI-4) O numero de unidades repostas num Evento de Reposicao nao pode exceder o numero de unidades especificado no Planograma */

DELIMITER //
    DROP TRIGGER IF EXISTS ri4 //
    CREATE TRIGGER ri4 BEFORE INSERT ON evento_reposicao
    FOR EACH ROW BEGIN 
        DECLARE x INT;
        SET x = (
            SELECT COUNT(*)
            FROM planograma
            WHERE planograma.ean = new.ean
            AND planograma.nro = new.nro
            AND planograma.num_serie = new.num_serie
            AND planograma.fabricante = new.fabricante
            AND planograma.unidades < new.unidades
        );
        IF x > 0 THEN
            CALL raise_error;
        END IF;
    END//
DELIMITER ;

/* RI-5) Um Produto so pode ser reposto numa Prateleira que apresente (pelo menos) uma das Categorias desse produto */

DELIMITER //
    DROP TRIGGER IF EXISTS ri5 //
    CREATE TRIGGER ri5 BEFORE INSERT ON evento_reposicao
    FOR EACH ROW BEGIN 
        /* Obter as super categorias das categorias do produto da nova reposicao. */
        WITH RECURSIVE super AS (
            SELECT tem_outra.super_categoria
            FROM tem_outra, tem_categoria
            WHERE tem_categoria.ean = new.ean
            AND tem_categoria.nome = tem_outra.categoria
            UNION ALL
            SELECT tem_outra.super_categoria
            FROM super, tem_outra
            WHERE super.super_categoria = tem_outra.categoria
        )
        DECLARE x INT;
        SET x = (
            SELECT COUNT(*)
            /* A partir das categorias do produto juntas com as suas super categorias. */
            FROM prateleira, produto, (
                SELECT super_categoria AS nome
                FROM super UNION ALL (
                    SELECT nome 
                    FROM tem_categoria 
                    WHERE ean = new.ean
                )
            ) AS categoria_produto
            /* Verificar se a categoria da prateleira esta presente nesse conjunto. */
            WHERE prateleira.nro = new.nro
            AND prateleira.num_serie = new.num_serie
            AND prateleira.fabricante = new.fabricante
            AND categoria_produto.nome = prateleira.nome
        );
        /* Se nao estiver, lancar um erro. */
        IF x <= 0 THEN
            CALL raise_error;
        END IF;
    END//
DELIMITER ;
