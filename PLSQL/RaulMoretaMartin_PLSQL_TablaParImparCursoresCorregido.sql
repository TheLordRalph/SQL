CREATE DATABASE BDCURSORES;
USE BDCURSORES;

CREATE TABLE parImpar(
numero INT(5) PRIMARY KEY,
pares CHAR(1) DEFAULT ' ',
impares CHAR(1) DEFAULT ' '
);


DELIMITER $$

DROP PROCEDURE IF EXISTS EsParImpar_cursor $$
/*El procedimiento solo acepta numero enteros positivos mayores que 0*/
CREATE PROCEDURE EsParImpar_cursor(IN numeroMaximo INT)
BEGIN

DECLARE fin INT DEFAULT FALSE;
DECLARE cont, num INT;
DECLARE cur1 CURSOR FOR SELECT numero FROM parImpar;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;


SET cont = 1;

DELETE FROM parImpar
WHERE numero IS NOT NULL;


WHILE cont <= ABS(numeroMaximo) DO

INSERT INTO parImpar (numero) VALUES(cont);
SET cont = cont + 1;

END WHILE;


OPEN cur1;
FETCH cur1 INTO num;
WHILE fin = FALSE DO

IF (MOD(num, 2) = 0) THEN
UPDATE parImpar SET pares = 'X' WHERE numero = num;
ELSE
UPDATE parImpar SET impares = 'X' WHERE numero = num;
END IF;

FETCH cur1 INTO num;

END WHILE;

CLOSE cur1;
END $$

DELIMITER ;

CALL EsParImpar_cursor(4);