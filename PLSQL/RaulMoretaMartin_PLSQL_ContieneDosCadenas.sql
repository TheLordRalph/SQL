DELIMITER $$

DROP FUNCTION IF EXISTS contiene$$

CREATE FUNCTION contiene (cadena1 VARCHAR(100), cadena2 VARCHAR(100))
returns BOOLEAN DETERMINISTIC
BEGIN

DECLARE contadorCadena1 INT;
DECLARE contadorCadena2 INT;
DECLARE contador INT;
DECLARE contieneLaCadena BOOLEAN;
DECLARE contenedor1 VARCHAR(100);
DECLARE contenedor2 VARCHAR(100);


SET contador = 0;
SET contieneLaCadena = false;


bucle1: WHILE contador <= LENGTH(cadena2) DO
SET contador = contador + 1;
SET contadorCadena1 = 1;

SET contenedor1 = SUBSTRING(cadena1, contadorCadena1, 1);
SET contenedor2 = SUBSTRING(cadena2, contador, 1);

IF contenedor1 = contenedor2 THEN

SET contadorCadena2 = contador + 1;
SET contadorCadena1 = 2;

bucle2: LOOP

SET contenedor1 = SUBSTRING(cadena1, contadorCadena1, 1);
SET contenedor2 = SUBSTRING(cadena2, contadorCadena2, 1);

IF contenedor1 = contenedor2 THEN
SET contadorCadena1 = contadorCadena1 + 1;
SET contadorCadena2 = contadorCadena2 + 1;
ELSE
ITERATE bucle1;
END IF;

IF contadorCadena1 > LENGTH(cadena1) THEN
SET contieneLaCadena = true;
return contieneLaCadena;
ELSE
ITERATE bucle2;
END IF;

END LOOP bucle2;

END IF;
END WHILE bucle1;
return contieneLaCadena;
END $$

DELIMITER ;

SET @texto = contiene('ac', 'Paco');
SELECT @texto;