CREATE TABLE parImpar(
numero INT(5) PRIMARY KEY,
pares CHAR(1),
impares CHAR(1)
);

DELIMITER $$

DROP PROCEDURE IF EXISTS EsParImpar $$

CREATE PROCEDURE EsParImpar(IN numeroMaximo INT(5), OUT contadorPares INT(5), OUT contadorImpares INT(5))
BEGIN

DECLARE numeroParImpar INT(5);

SET numeroParImpar = 1;
SET contadorPares = 0;
SET contadorImpares = 0;

DELETE FROM parImpar
WHERE numero IS NOT NULL;

WHILE numeroParImpar <= numeroMaximo DO

IF (MOD(numeroParImpar, 2) = 0) THEN
INSERT INTO parImpar VALUES (numeroParImpar, 'X', NULL);
SET contadorPares = contadorPares + 1;
ELSE 
INSERT INTO parImpar VALUES (numeroParImpar, NULL, 'X');
SET contadorImpares = contadorImpares + 1;
END IF;

SET numeroParImpar = numeroParImpar + 1;
END WHILE;
END $$

DELIMITER ;

CALL EsParImpar(4, @rdo1, @rdo2);