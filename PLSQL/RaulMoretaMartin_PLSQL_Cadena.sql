DELIMITER $$

DROP FUNCTION IF EXISTS cadenaAmpliada$$

CREATE FUNCTION cadenaAmpliada (texto VARCHAR(50))
returns VARCHAR(50) DETERMINISTIC
BEGIN
DECLARE resultado VARCHAR(50);
DECLARE caracter VARCHAR(2);
DECLARE caracteresMaximos INT;
DECLARE cont INT;
SET resultado = '';
SET cont = 1;
SET caracteresMaximos = LENGTH(texto);

bucle: LOOP
SET caracter = SUBSTRING(texto, cont, 1);
SET resultado = CONCAT(resultado, caracter, ' ');

IF cont = caracteresMaximos THEN
LEAVE bucle;
END IF;

SET cont = cont + 1;

END LOOP bucle;
return resultado;
END $$

DELIMITER ;

SET @cadenaCaracteres = cadenaAmpliada('Hola qué tal?');
SELECT @cadenaCaracteres;