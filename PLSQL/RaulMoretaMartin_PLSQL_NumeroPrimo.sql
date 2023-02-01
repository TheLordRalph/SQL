DELIMITER $$

DROP FUNCTION IF EXISTS numeroPrimo$$

CREATE FUNCTION numeroPrimo (numero INT)
returns VARCHAR(30) DETERMINISTIC
BEGIN
DECLARE cont INT;
DECLARE esPrimo VARCHAR(30);
SET CONT = 2;
SET esPrimo = 'El numero indicado es Primo';

bucle: LOOP
IF CONT >= numero THEN
LEAVE bucle;
END IF;

IF MOD(numero, CONT) = 0 THEN
SET esPrimo = 'No es primo';
LEAVE bucle;
END IF;

SET CONT = CONT + 1;

END LOOP bucle;
return esPrimo;
END $$

DELIMITER ;

SET @elNumeroEsPrimo = numeroPrimo(643);
SELECT @elNumeroEsPrimo;


