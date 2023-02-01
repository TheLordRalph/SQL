DELIMITER $$

DROP FUNCTION IF EXISTS multiplicacion$$

CREATE FUNCTION multiplicacion (numero1 INT, numero2 INT)
returns INT DETERMINISTIC
BEGIN

DECLARE resultado INT;
DECLARE cont INT;
SET resultado = 0;
SET cont = 1;

bucle: LOOP
SET resultado = numero1 + resultado;

IF cont = numero2 THEN
LEAVE bucle;
END IF;

SET cont = cont + 1;

END LOOP bucle;
return resultado;
END $$

DELIMITER ;

SET @resultadoMultiplicacion = multiplicacion(2, 4);
SELECT @numeros;