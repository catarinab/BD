/* RI-1: Uma Categoria nao pode estar contida em si propria */
DELIMITER //
    DROP TRIGGER IF EXISTS ri1 //
    CREATE TRIGGER ri1 BEFORE INSERT ON tem_outra
    FOR EACH ROW BEGIN
        IF new.super_categoria = new.categoria THEN
            CALL raise_error;
        END IF;
    END//
DELIMITER ;


#RI-4
DELIMITER //
    DROP TRIGGER IF EXISTS RI4 //
    CREATE TRIGGER RI4 BEFORE INSERT ON evento_reposicao
    FOR EACH ROW BEGIN 
        DECLARE x INT;
        SET x = (SELECT COUNT(*)
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

#RI-5
DELIMITER //
    DROP TRIGGER IF EXISTS RI5 //
    CREATE TRIGGER RI5 BEFORE INSERT ON evento_reposicao
    FOR EACH ROW BEGIN 
        DECLARE x INT;
        SET x = (SELECT COUNT(*)
                 FROM prateleira, produto
                 WHERE prateleira.nro = new.nro
                 AND prateleira.num_serie = new.num_serie
                 AND prateleira.fabricante = new.fabricante
                 AND produto.ean = new.ean
                 AND produto.cat = prateleira.cat
                );
        IF x <= 0 THEN
            CALL raise_error;
        END IF;
    END//
DELIMITER ;