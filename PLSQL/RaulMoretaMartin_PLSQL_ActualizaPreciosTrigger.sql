/*En la base de datos de jardineria, actualiza la tabla log_cambio_precio para que tenga ahora las siguientes columnas (si es necesario, bórrala y vuélvela a crear):


- id_tr de tipo INT UNSIGNED AUTO_INCREMENT que sea la nueva PK.

- codigo_producto VARCHAR(15)

- fecha DATE

- precio_anterior DECIMAL(5,2) 

- precio_nuevo DECIMAL(5,2)  

Una vez creada, crea un procedimiento llamado actualiza_precios_trigger que haga lo mismo que el 
procedimiento actualiza_precios pero sin insertar nada en la tabla log_cambio_precio .

Para insertar el registro en esta tabla de log, crea un trigger que se dispare cada vez que se 
termina de actualizar el campo precio_venta de un registro de la tabla producto y que inserte en 
la tabla log_cambio_precio un registro con todos los campos rellenos.

NOTA: a la hora de insertar un registro en la tabla de LOG, podemos ignorar el campo id_tr, 
pues el SGBD lo va a a incrementar automáticamente. Así sólo detallaremos el resto de los campos en la sentencia de INSERT.*/


CREATE TABLE log_cambio_precio (
id_tr INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
código_de_producto VARCHAR(15),
fecha DATETIME,
precio_anterior DECIMAL(15,2),
precio_nuevo DECIMAL(15,2)
);


DELIMITER $$

DROP PROCEDURE IF EXISTS actualiza_precios_trigger$$

CREATE PROCEDURE actualiza_precios_trigger()
BEGIN


DECLARE fin INT DEFAULT FALSE;
DECLARE cant INT;
DECLARE codPro VARCHAR(15);
DECLARE precioVen DECIMAL(15,2);
DECLARE cur1 CURSOR FOR SELECT codigo_producto, precio_venta FROM producto;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

OPEN cur1;
FETCH cur1 INTO codPro, precioVen;


WHILE NOT fin DO

IF codPro IN (SELECT producto.codigo_producto 
FROM producto LEFT JOIN detalle_pedido ON detalle_pedido.codigo_producto = producto.codigo_producto 
GROUP BY producto.codigo_producto
HAVING SUM(detalle_pedido.cantidad) >= 400) THEN

UPDATE producto SET precio_venta = precioVen + ((precioVen * 10) / 100) WHERE codigo_producto = codPro;

ELSE

UPDATE producto SET precio_venta = precioVen - ((precioVen * 20) / 100) WHERE codigo_producto = codPro;

END IF;

FETCH cur1 INTO codPro, precioVen;
END WHILE;

CLOSE cur1;
END$$

DELIMITER ;



DELIMITER $$

DROP TRIGGER IF EXISTS tri_act_precio_venta$$

CREATE TRIGGER tri_act_precio_venta
AFTER UPDATE ON producto FOR EACH ROW
BEGIN

INSERT INTO log_cambio_precio (código_de_producto, fecha, precio_anterior, precio_nuevo) VALUES (OLD.codigo_producto, NOW(), OLD.precio_venta, NEW.precio_venta);

END$$

DELIMITER ;