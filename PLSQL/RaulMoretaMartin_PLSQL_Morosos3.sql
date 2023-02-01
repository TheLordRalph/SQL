/* En JARDINERIA, crea una tabla llamada MOROSOS. 

Esta tabla tendrá los campos: 

• código del cliente

• nombre y apellidos del cliente 

• límite de crédito del cliente 

• importe total de los pedidos del cliente (ITP) 

• importe total facturado del cliente (ITF) 

• importe pendiente del cliente (IPCL) = ITP – ITF 



Después crea un procedimiento busca_morosos que deberá insertar en esta tabla aquellos clientes* con pagos pendientes. 

Recuerda borrar el contenido de la tabla antes de empezar a insertar valores. 

* Si no hay ningún cliente así en las tablas, modifica algún campo para lograr que se inserten valores en la tabla. */

CREATE TABLE MOROSOS (
codigo_cliente INT(15) PRIMARY KEY,
nombre VARCHAR(50),
apellido VARCHAR(50),
limite_credito DECIMAL(15,2),
ITP DECIMAL(15,2),
ITF DECIMAL(15,2),
IPCL DECIMAL(15,2),
FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente)
);




DELIMITER $$

DROP PROCEDURE IF EXISTS busca_morosos$$

CREATE PROCEDURE busca_morosos()
BEGIN

DECLARE fin INT DEFAULT FALSE;
DECLARE ITP_ITF DECIMAL(15,2);
DECLARE CoCli INT(11);
DECLARE nombreCli VARCHAR(30);
DECLARE apellidoCli VARCHAR(30);
DECLARE LimCred DECIMAL(15,2);
DECLARE cur1 CURSOR FOR SELECT codigo_cliente, nombre_contacto, apellido_contacto, limite_credito FROM cliente;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

DELETE FROM MOROSOS
WHERE codigo_cliente IS NOT NULL;


OPEN cur1;
FETCH cur1 INTO CoCli, nombreCli, apellidoCli, LimCred;

WHILE fin = FALSE DO

IF calcular_pagos_pendientes(CoCli) = TRUE THEN

SET ITP_ITF = calcular_suma_pedidos_cliente(CoCli) - calcular_suma_pagos_cliente(CoCli);

INSERT INTO MOROSOS VALUES(CoCli, nombreCli, apellidoCli, LimCred, calcular_suma_pedidos_cliente(CoCli), calcular_suma_pagos_cliente(CoCli), ITP_ITF);

END IF;

FETCH cur1 INTO CoCli, nombreCli, apellidoCli, LimCred;
END WHILE;

CLOSE cur1;
END$$

DELIMITER ;

call busca_morosos();
