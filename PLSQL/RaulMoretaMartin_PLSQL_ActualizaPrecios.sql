/*En la base de datos de jardineria, crea una tabla que se llame log_cambio_precio con tres columnas: código de producto, precio_anterior, precio_nuevo. Revisa y utiliza los tipos de datos adecuados para cada campo de la tabla.

Una vez creada, crea un procedimiento llamado actualiza_precios que haga lo siguiente:

1. Para aquellos productos de los que se han vendido 400 unidades o más, incrementamos el precio de venta un 10%.

2. Para aquellos productos de los que se han vendido menos de 400 unidades, reducimos su precio de venta un 20%.

Además, esta modificación debe quedar registrada en la tabla log_cambio_precio que acabamos de crear.*/

CREATE TABLE log_cambio_precio (
código_de_producto VARCHAR(15) PRIMARY KEY,
fecha DATE,
precio_anterior DECIMAL(15,2),
precio_nuevo DECIMAL(15,2)
);


DELIMITER $$

DROP PROCEDURE IF EXISTS inserta_productos$$

CREATE PROCEDURE inserta_productos()
BEGIN



DELETE FROM log_cambio_precio
WHERE código_de_producto IS NOT NULL;

INSERT INTO log_cambio_precio (SELECT codigo_producto FROM producto);

END$$

DELIMITER ;



DELIMITER $$

DROP PROCEDURE IF EXISTS actualiza_precios$$
/* No funciona, seguramente sea por culpa de los select, que me dan codigos repetido. si le doy un pensamiento lo saco pero no me da tiempo.*/
CREATE PROCEDURE actualiza_precios()
BEGIN

DECLARE fin INT DEFAULT FALSE;
DECLARE cant INT;
DECLARE codPro VARCHAR(15);
DECLARE precioAnt DECIMAL(15,2);
DECLARE cur1 CURSOR FOR SELECT codigo_producto, precio_unidad, SUM(cantidad) FROM detalle_pedido GROUP BY codigo_producto, precio_unidad;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;




SELECT codigo_producto, precio_unidad, SUM(cantidad) 
INTO codPro
FROM detalle_pedido 
GROUP BY codigo_producto, precio_unidad;

INSERT log_cambio_precio (código_de_producto) 
VALUES (codPro);


OPEN cur1;
FETCH cur1 INTO codPro, precioAnt, cant;

WHILE fin = FALSE THEN

IF cant >= 400 THEN
   UPDATE log_cambio_precio SET precio_anterior = precioAnt WHERE código_de_producto = codPro;
   UPDATE log_cambio_precio SET precio_nuevo = precioAnt + ((precioAnt * 10) / 100) WHERE código_de_producto = codPro;
END IF;
IF cant < 400 THEN
   UPDATE log_cambio_precio SET precio_anterior = precioAnt WHERE código_de_producto = codPro;
   UPDATE log_cambio_precio SET precio_nuevo = precioAnt - ((precioAnt * 20) / 100) WHERE código_de_producto = codPro;
END IF;

FETCH cur1 INTO codPro, precioAnt, cant;
END WHILE;
END $$

DELIMITER ;

call actualiza_precios();