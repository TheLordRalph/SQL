/*En la base de datos de jardineria crea una tabla notificaciones que tenga las siguientes columnas:
id (entero sin signo, autoincremento y clave primaria)
fecha_hora: marca de tiempo con el instante del pago (con la hora completa incluido los segundos)
total: el valor del pago (decimal)
codigo_cliente: código del cliente que realiza el pago (entero)
A continuación, crea un trigger que nos permita llevar un control de los pagos que van 
realizando los clientes con estas indicaciones

Se ejecuta sobre la tabla pago.
Se ejecuta después de hacer la inserción de un pago.
Cada vez que un cliente realice un pago (es decir, se hace una inserción en la tabla pago), 
el trigger deberá insertar un nuevo registro en la tabla llamada notificaciones.
Escriba algunas sentencias SQL para comprobar que el trigger funciona correctamente.*/

CREATE TABLE notificaciones (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
fecha_hora DATETIME,
total DECIMAL(15,2),
codigo_cliente INT
);

DELIMITER $$

DROP TRIGGER IF EXISTS act_pagos$$

CREATE TRIGGER act_pagos
AFTER INSERT ON pago FOR EACH ROW
BEGIN

INSERT INTO notificaciones VALUES (SYSDATE(), NEW.total, NEW.codigo_cliente);

END$$

DELIMITER ;

