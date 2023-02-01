DELIMITER $$

DROP FUNCTION IF EXISTS elNumeroMasGrande$$

CREATE FUNCTION elNumeroMasGrande (numero1 INT, numero2 INT, numero3 INT)
returns INT DETERMINISTIC
BEGIN
DECLARE resultado INT;
SET resultado = numero3;

IF numero1 > numero2 THEN
IF numero1 > numero3 THEN
SET resultado = numero1;
return resultado;
END IF;
SET resultado = numero3;
return resultado;
END IF;

IF numero2 > numero3 THEN
SET resultado = numero2;
return resultado;
END IF;

return resultado;
END $$

DELIMITER ;

SET @numeros = elNumeroMasGrande(5, 10, 20);
SELECT @numeros;