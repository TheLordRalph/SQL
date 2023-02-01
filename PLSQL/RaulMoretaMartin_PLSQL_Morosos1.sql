/*Para hacer en JARDINERIA

1. Crea la función calcular_precio_total_pedido que dado un código de pedido, devuelva el importe total de un pedido.

2. Crea la función calcular_suma_pedidos_cliente que dado un código de cliente, devuelva el importe total de la suma de sus pedidos.*/

DELIMITER $$
DROP FUNCTION IF EXISTS calcular_precio_total_pedido$$

CREATE FUNCTION calcular_precio_total_pedido(cod_ped INT(11))
RETURNS DECIMAL DETERMINISTIC
BEGIN

DECLARE rdo DECIMAL(15,2);

SELECT SUM(precio_unidad*cantidad)
INTO rdo
FROM detalle_pedido
WHERE codigo_pedido = cod_ped;

RETURN rdo;

END$$

DELIMITER ;

SELECT calcular_precio_total_pedido();


 

DELIMITER $$
DROP FUNCTION IF EXISTS calcular_suma_pedidos_cliente$$

CREATE FUNCTION calcular_suma_pedidos_cliente(cod_cli INT(11))
RETURNS DECIMAL DETERMINISTIC
BEGIN

DECLARE fin INT DEFAULT FALSE;
DECLARE rdo DECIMAL(15,2);
DECLARE cantPed DECIMAL(15,2);
DECLARE cod_ped INT;
DECLARE cur1 CURSOR FOR SELECT codigo_pedido FROM pedido;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

SET rdo = 0;

OPEN cur1;
FETCH cur1 INTO cod_ped;

WHILE fin = FALSE DO

IF ((SELECT codigo_cliente FROM pedido WHERE codigo_pedido = cod_ped) = cod_cli) THEN

SET cantPed = calcular_precio_total_pedido(cod_ped);
SET rdo = rdo + cantPed;

END IF;

FETCH cur1 INTO cod_ped;

END WHILE;
CLOSE cur1;
RETURN rdo;

END$$

DELIMITER ;

SELECT calcular_suma_pedidos_cliente();


