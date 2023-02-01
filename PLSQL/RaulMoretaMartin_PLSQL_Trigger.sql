/*1. Crea una tabla  log_act_producto en jardineria con tres campos: 

- id_tr de tipo INT UNSIGNED AUTO_INCREMENT que sea la nueva PK.

- fecha de tipo DATE, 

- detalles de tipo VARCHAR(100).

2. Crea un trigger que se dispare cada vez que se termina de actualizar un registro de la tabla producto que inserte en la tabla log_act_producto un registro con los siguientes datos:

id <- (no es necesario insertarlo pues el un campo que se auto-incrementa sólo)

fecha <- (la fecha del momento en que se produce la actualización)

detalles <- (cadena de texto 'Se ha actualizado el producto con código: ' codigo_producto)

*/

CREATE TABLE log_act_producto (
id_tr INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
fecha DATETIME,
detalles VARCHAR(100)
);



DELIMITER $$

DROP FUNCTION IF EXISTS fechaActual$$
/*CREO UNA FUNCION QUE ME DEVUELVE LA FECHA Y HORA ACTUAL*/
CREATE FUNCTION fechaActual()
RETURNS DATETIME DETERMINISTIC
BEGIN

DECLARE fecha DATETIME;

SELECT now()
INTO fecha;

return fecha;

END$$

DELIMITER ;



DELIMITER $$

DROP TRIGGER IF EXISTS trigger_act_producto $$
/*CREO UN TRIGGER QUE INSERTARA EN LA TABLA LOG, LA FECHA QUE NOS DEVULVE LA FUNCION Y EL CODIGO DEL PRODUCTO DONDE SE HA HECHO LA ACTUALIZACIÓN*/
CREATE TRIGGER trigger_act_producto
AFTER UPDATE ON producto FOR EACH ROW
BEGIN

INSERT INTO log_act_producto (fecha, detalles) VALUES(fechaActual(), CONCAT('Se ha actualizado el producto con código: ', OLD.codigo_producto));

END$$

DELIMITER ;