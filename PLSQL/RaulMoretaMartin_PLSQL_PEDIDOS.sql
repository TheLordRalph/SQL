/* 1. En la base de datos de jardineria, crea la siguiente tabla e inserta la información asociada a los 5 pedidos detallada en los insert. 

CREATE TABLE fichero_pedidos (

  codigo_pedido INTEGER NOT NULL,

  codigo_cliente INTEGER NOT NULL,

  fecha_pedido date NOT NULL,

  fecha_esperada date NOT NULL,

  fecha_entrega date DEFAULT NULL,

  estado VARCHAR(15) NOT NULL,

  comentarios TEXT,

  numero_linea SMALLINT NOT NULL,

  codigo_producto VARCHAR(15) NOT NULL,

  cantidad INTEGER NOT NULL,

  precio_unidad DECIMAL(15,2));



INSERT INTO fichero_pedidos VALUES (127, 30, '2009-04-06','2009-04-10','2009-04-10','Entregado',NULL, 1, 'FR-67',10,70);

INSERT INTO fichero_pedidos VALUES (300, 20, '2021-04-17','2021-06-17',NULL,'Pendiente','Pagado a plazos', 1, 'FR-67', 10, 5);

INSERT INTO fichero_pedidos VALUES (300, 20, '2021-04-17','2021-06-17',NULL,'Pendiente','Pagado a plazos', 2, 'AR-004', 10, 5);

INSERT INTO fichero_pedidos VALUES (300, 20, '2021-04-17','2021-06-17',NULL,'Pendiente','Pagado a plazos', 3, 'AR-009', 10, 5);

INSERT INTO fichero_pedidos VALUES (301, 15, '2021-04-18','2021-06-18',NULL,'Pendiente','Regalo', 1, 'OR-141', 5, 10);

INSERT INTO fichero_pedidos VALUES (301, 15, '2021-04-18','2021-06-18',NULL,'Pendiente','Regalo', 2, 'AR-011', 2, 3);

INSERT INTO fichero_pedidos VALUES (302, 88, '2021-04-19','2021-06-19',NULL,'Pendiente','Pedido mensual', 1, 'OR-140', 10, 10);

INSERT INTO fichero_pedidos VALUES (302, 88, '2021-04-19','2021-06-19',NULL,'Pendiente','Pedido mensual', 2, 'OR-136', 10, 6);

INSERT INTO fichero_pedidos VALUES (303, 10, '2021-04-20','2021-06-20',NULL,'Pendiente','Pedido extra', 1, 'OR-130', 10, 2);

INSERT INTO fichero_pedidos VALUES (303, 10, '2021-04-20','2021-06-20',NULL,'Pendiente','Pedido extra', 3, 'OR-99', 10, 8);

2. Crea un procedimiento llamado carga_pedidos que lea los datos de esta tabla y los cargue en las tablas pedido y detalle_pedido. Este procedimiento debe gestionar convenientemente los errores que os podáis encontrar al hacer los INSERT en ambas tablas. */


CREATE TABLE log_carga_pedidos (
id_log INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
codigo_pedido INT,
codigo_cliente INT,
fecha_pedido DATE,
fecha_log DATETIME,
error_code VARCHAR(10),
error_no VARCHAR(10),
error_text VARCHAR(200)
);


DELIMITER $$

DROP PROCEDURE IF EXISTS carga_pedidos$$

CREATE PROCEDURE carga_pedidos()
BEGIN

DECLARE fin INT DEFAULT FALSE;
DECLARE codigo_pedido INT(11);
DECLARE codigo_cliente INT(11);
DECLARE fecha_pedido DATE;
DECLARE fecha_esperada DATE;
DECLARE fecha_entrega DATE;
DECLARE estado VARCHAR(15);
DECLARE comentarios text;
DECLARE numero_linea SMALLINT(6);
DECLARE codigo_producto VARCHAR(15);
DECLARE cantidad INT(11);
DECLARE precio_unidad DECIMAL(15,2);
DECLARE cur1 CURSOR FOR SELECT * FROM fichero_pedidos;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

DECLARE CONTINUE HANDLER FOR SQLWARNING
BEGIN
GET DIAGNOSTICS CONDITION 1
@code = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO;
INSERT INTO log_carga_pedidos(codigo_pedido, codigo_cliente, fecha_pedido, fecha_log , error_code, error_no, error_text)
VALUES (codigo_pedido, codigo_cliente, fecha_pedido, SYSDATE(),@code, @errno, 'SQL WARNING');
END;

DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
BEGIN
GET DIAGNOSTICS CONDITION 1
@code = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO;
INSERT INTO log_carga_pedidos(codigo_pedido, codigo_cliente, fecha_pedido, fecha_log , error_code, error_no, error_text)
VALUES (codigo_pedido, codigo_cliente, fecha_pedido, SYSDATE(),@code, @errno, 'SQL EXCEPTION');
END;


open cur1;
fetch cur1 into codigo_pedido, codigo_cliente, fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, numero_linea, codigo_producto, cantidad, precio_unidad;

WHILE fin = false do

IF codigo_pedido = (SELECT P.codigo_pedido FROM pedido P WHERE P.codigo_pedido = codigo_pedido) && (numero_linea != 1) THEN

INSERT INTO detalle_pedido VALUES(codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea);

ELSE

INSERT INTO pedido VALUES(codigo_pedido, fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, codigo_cliente);
INSERT INTO detalle_pedido VALUES(codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea);

END IF;

fetch cur1 into codigo_pedido, codigo_cliente, fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, numero_linea, codigo_producto, cantidad, precio_unidad;

END WHILE;
CLOSE cur1;
END$$

DELIMITER ;