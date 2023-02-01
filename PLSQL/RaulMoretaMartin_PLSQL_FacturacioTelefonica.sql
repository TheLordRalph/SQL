/* CREACION DE LA BASE DE DATOS */

DROP DATABASE IF EXISTS FACTURACION;
CREATE DATABASE FACTURACION;
USE FACTURACION;


CREATE TABLE plan_tfno (
idPlan VARCHAR(15) PRIMARY KEY,
preEstLlam DOUBLE(15,5),
preSeg DOUBLE(15,5)
);


CREATE TABLE cliente (
idCliente VARCHAR(15) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50),
telefono INT(15),
idPlan VARCHAR(15),
FOREIGN KEY (idPlan) REFERENCES plan_tfno(idPlan)
);


CREATE TABLE llamada (
codLineaLlamada INT AUTO_INCREMENT PRIMARY KEY,
idCliente VARCHAR(15),
fecha DATE,
hora TIME,
numLlamado INT(15),
segundos INT(10),
FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
);

CREATE TABLE factura (
codLineaFactura INT AUTO_INCREMENT PRIMARY KEY,
idCliente VARCHAR(15),
mes INT,
año INT,
cantidad DOUBLE(15,2),
FOREIGN KEY (idCliente) REFERENCES cliente(idCliente)
);



/* CREACION DEL TRIGGER */

/* Cuando se inserta un dato en la tabla de llamada. Sobre la tabla de factura comprobara si existe una factura del cliente en el mes y año actual. 
En caso de que ya exista una factura del cliente para el mismo mes y año, actualizara ese registro para sumar la nueva cantidad de la factura. 
En caso de que no exista una factura para ese cliente en el mes y año actual, insertara un nuevo registro con la cantidad de la factura de la llamada que se ha realizado. */

/* Para insertar la cantidad de la factura, lo que hago es, el select de "preEstLlam" + ("preSeg" * "segundo que ha durado la llamada") con eso obtengo la cantidad "precio" de la llamada que se ha realizado bajo el precio establecido en el plan_tfno del cliente.
Y para el actualizado hago el select de lo que cuesta la llamada que se ha realizado igual que con el insert pero le sumamos la cantidad que ya tenia acumulada la factura para el mes y año igual del cliente.*/

DELIMITER $$

DROP TRIGGER IF EXISTS actualiza_factura$$

CREATE TRIGGER actualiza_factura
AFTER INSERT ON llamada FOR EACH ROW
BEGIN

IF EXISTS (SELECT mes FROM factura WHERE idCliente = NEW.idCliente AND mes = MONTH(NOW())) THEN
IF EXISTS (SELECT año FROM factura WHERE idCliente = NEW.idCliente AND año = YEAR(NOW())) THEN

UPDATE factura SET cantidad = cantidad + (SELECT P.preEstLlam + (P.preSeg*NEW.segundos) FROM plan_tfno P WHERE P.idPlan = (SELECT C.idPlan FROM cliente C WHERE idCliente = NEW.idCliente)) WHERE idCliente = NEW.idCliente AND mes = MONTH(NOW()) AND año = YEAR(NOW());
ELSE
INSERT INTO factura (idCliente, mes, año, cantidad) VALUES (NEW.idCliente, MONTH(NOW()), YEAR(NOW()), (SELECT P.preEstLlam + (P.preSeg*NEW.segundos) FROM plan_tfno P WHERE P.idPlan = (SELECT C.idPlan FROM cliente C WHERE idCliente = NEW.idCliente)));

END IF;

ELSE
INSERT INTO factura (idCliente, mes, año, cantidad) VALUES (NEW.idCliente, MONTH(NOW()), YEAR(NOW()), (SELECT P.preEstLlam + (P.preSeg*NEW.segundos) FROM plan_tfno P WHERE P.idPlan = (SELECT C.idPlan FROM cliente C WHERE idCliente = NEW.idCliente)));

END IF;
END$$

DELIMITER ;



INSERT INTO llamada (idCliente, fecha, hora, numLlamado, segundos) VALUES('1', DATE(NOW()), TIME(NOW()), 665444382, 80);
INSERT INTO llamada (idCliente, fecha, hora, numLlamado, segundos) VALUES('1', DATE(NOW()), TIME(NOW()), 234341223, 10);
INSERT INTO llamada (idCliente, fecha, hora, numLlamado, segundos) VALUES('2', DATE(NOW()), TIME(NOW()), 241213332, 140);