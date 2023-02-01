DELIMITER $$

DROP PROCEDURE IF EXISTS maximoValor$$

CREATE PROCEDURE maximoValor(IN fp VARCHAR(40))
BEGIN

SELECT MAX(total)
FROM pago
WHERE forma_pago = fp;

END $$

DELIMITER ;

CALL maximoValor('PayPal');
SELECT @rdo0, @rdo1;