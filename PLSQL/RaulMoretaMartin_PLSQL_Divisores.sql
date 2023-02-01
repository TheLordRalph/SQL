-- Bucle con LOOP

DELIMITER $$

DROP PROCEDURE IF EXISTS numerosDivisores$$

CREATE PROCEDURE numerosDivisores (IN numero INT, OUT divisores VARCHAR(100), OUT cantidadDivisores INT)
BEGIN
DECLARE cont INT;
SET cont = 1;
SET divisores = '1';
SET cantidadDivisores = 1;

bucle: LOOP

IF cont > numero THEN
LEAVE bucle;
END IF;

SET cont = cont + 1;

IF MOD(numero, cont) = 0 THEN
SET divisores = CONCAT(divisores, ',', cont);
SET cantidadDivisores =  cantidadDivisores + 1;
ELSE
ITERATE bucle;
END IF;

END LOOP;

END $$

DELIMITER ;

CALL numerosDivisores(10, @rdo0, @rdo1);
SELECT @rdo0, @rdo1;





-- Bucle con WHILE

DELIMITER $$

DROP PROCEDURE IF EXISTS numerosDivisores$$

CREATE PROCEDURE numerosDivisores (IN numero INT, OUT divisores VARCHAR(100), OUT cantidadDivisores INT)
BEGIN
DECLARE cont INT;
SET cont = 1;
SET divisores = '1';
SET cantidadDivisores = 1;

WHILE cont <= numero DO

SET cont = cont + 1;

IF MOD(numero, cont) = 0 THEN
SET divisores = CONCAT(divisores, ',', cont);
SET cantidadDivisores =  cantidadDivisores + 1;
END IF;

END WHILE;

END $$

DELIMITER ;

CALL numerosDivisores(10, @rdo0, @rdo1);
SELECT @rdo0, @rdo1;








-- Bucle con REPEAT

DELIMITER $$

DROP PROCEDURE IF EXISTS numerosDivisores$$

CREATE PROCEDURE numerosDivisores (IN numero INT, OUT divisores VARCHAR(100), OUT cantidadDivisores INT)
BEGIN
DECLARE cont INT;
SET cont = 1;
SET divisores = '1';
SET cantidadDivisores = 1;

REPEAT

SET cont = cont + 1;

IF MOD(numero, cont) = 0 THEN
SET divisores = CONCAT(divisores, ',', cont);
SET cantidadDivisores =  cantidadDivisores + 1;
END IF;

UNTIL cont > numero
END REPEAT;

END $$

DELIMITER ;

CALL numerosDivisores(10, @rdo0, @rdo1);
SELECT @rdo0, @rdo1;