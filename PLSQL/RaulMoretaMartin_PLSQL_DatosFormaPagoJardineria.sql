DELIMITER $$

DROP PROCEDURE IF EXISTS datosFormaPago$$

CREATE PROCEDURE datosFormaPago(IN fp VARCHAR(40))
BEGIN

SELECT MAX(total), MIN(total), AVG(total), SUM(total), COUNT(total)
FROM pago
WHERE forma_pago = fp;

END $$

DELIMITER ;

CALL datosFormaPago('PayPal');