/* Para hacer en JARDINERIA

Crea la función calcular_suma_pagos_cliente que dado un código de cliente, devuelva el importe total de la suma de sus pagos.

Crea la función calcular_pagos_pendientes que dado un código de cliente, devuelva si el importe total de la suma de sus pedidos es superior al importe total de la suma de sus pagos. */

DELIMITER $$
DROP FUNCTION IF EXISTS calcular_suma_pagos_cliente$$

CREATE FUNCTION calcular_suma_pagos_cliente(cod_cli INT(11))
RETURNS DECIMAL DETERMINISTIC
BEGIN

DECLARE rdo1 DECIMAL(15,2);
SET rdo1 = 0;

SELECT SUM(total)
INTO rdo1
FROM pago
WHERE codigo_cliente = cod_cli;

RETURN rdo1;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS calcular_pagos_pendientes$$

CREATE FUNCTION calcular_pagos_pendientes(cod_cli INT(11))
RETURNS BOOLEAN DETERMINISTIC
BEGIN

IF (calcular_suma_pagos_cliente(cod_cli)) < (calcular_suma_pedidos_cliente(cod_cli)) THEN 
RETURN TRUE;
END IF;

RETURN FALSE;

END$$

DELIMITER ;