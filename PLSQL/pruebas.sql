DELIMITER $$

DROP PROCEDURE pares10()$$

CREATE PROCEDURE pares10(OUT cadena VARCHAR(100))
BEGIN
DECLARE x INT;

SET cadena = '0';
SET x = 0;

bucle: LOOP
IF x > 20 THEN
LEAVE bucle;
END IF;

SET x = x + 1;

IF MOD(x, 2) = 0 THEN
SET cadena = CONCAT(cadena, ',', x);
ELSE
ITERATE bucle;
END IF;

END LOOP;

select cadena;
END $$