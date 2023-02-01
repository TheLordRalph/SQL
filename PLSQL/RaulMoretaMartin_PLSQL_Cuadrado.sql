CREATE TABLE enterosCuadrados(
numero INT(5) PRIMARY KEY,
cuadrado INT(5)
);

DELIMITER $$

DROP PROCEDURE IF EXISTS cuadrados$$

CREATE PROCEDURE cuadrados(IN numeroMaximo INT(5))
BEGIN

DECLARE contador INT;
DECLARE cuadrado INT;
SET contador = 0;

DELETE FROM enterosCuadrados
WHERE numero IS NOT NULL;

WHILE contador <= numeroMaximo DO

SET cuadrado = (contador * contador);

INSERT INTO enterosCuadrados VALUES (contador, cuadrado);

SET contador = contador + 1;
END WHILE;
END $$

DELIMITER ;

CALL cuadrados(4);