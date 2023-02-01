
-- Esta es mi segunda entrega, porque la primera fallaba con ciertas fechas y la he ajustado mas para que de menos fallos.

DELIMITER $$

DROP FUNCTION IF EXISTS fechas$$

CREATE FUNCTION fechas (fechaInicio DATE, fechaFin DATE)
returns VARCHAR(50) DETERMINISTIC
BEGIN

DECLARE resultado VARCHAR(50);

DECLARE dias INT;
SET dias = 0;

DECLARE meses INT;
SET meses = 0;

DECLARE año INT;
SET año = 0;

IF fechaInicio > fechaFin THEN
SET dias = DATEDIFF(fechaInicio, fechaFin);
END IF;
IF fechaFin > fechaInicio THEN
SET dias = DATEDIFF(fechaFin, fechaInicio);
END IF;

IF dias >= 365 THEN
SET año = dias / 365;
SET dias = dias - (365 * año);
END IF;

IF dias >= 31 THEN
SET meses = dias / 31;
SET dias = dias - (31 * meses);
END IF;

SET resultado = concat(año, ' años, ', meses, ' meses, ', dias, ' dias');
return resultado;
END $$

DELIMITER ;

SET @diasEntreFechas = fechas('2012-5-24', '2009-11-02');
SELECT @diasEntreFechas;