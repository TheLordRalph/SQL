DELIMITER $$

DROP FUNCTION IF EXISTS caracteresIniciales$$

CREATE FUNCTION caracteresIniciales (texto VARCHAR(100))
returns VARCHAR(100) DETERMINISTIC
BEGIN
DECLARE resultado VARCHAR(100);
DECLARE caracter VARCHAR(2);
DECLARE caracteresMaximos INT;
DECLARE cont INT;

SET cont = 1;
SET resultado = '';
SET caracteresMaximos = LENGTH(texto);

SET caracter = SUBSTRING(texto, cont, 1);
SET resultado = CONCAT(resultado, caracter);

bucle: LOOP

SET caracter = SUBSTRING(texto, cont, 1);

IF caracter LIKE ' ' THEN
SET caracter = SUBSTRING(texto, cont + 1, 1);
SET resultado = CONCAT(resultado, caracter);
END IF;

IF cont = caracteresMaximos THEN
LEAVE bucle;
END IF;

SET cont = cont + 1;

END LOOP bucle;
return resultado;
END $$

DELIMITER ;

SET @cadenaCaracteres = caracteresIniciales('Hola qué tal?');
SELECT @cadenaCaracteres;