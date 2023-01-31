/*6.11. Modifica la tabla detalle_pedido para insertar un campo numérico llamado iva. Actualiza el valor de
ese campo a 18 para aquellos registros cuyo pedido tenga fecha a partir de Enero de 2009. A continuación
actualiza el resto de pedidos estableciendo el iva al 21.*/
ALTER TABLE detalle_pedido
ADD iva INT(10);

UPDATE detalle_pedido DP, pedido P
SET DP.iva = 18 
WHERE YEAR(P.fecha_pedido) >= '2009' AND P.codigo_pedido = DP.codigo_pedido;

UPDATE detalle_pedido DP, pedido P
SET DP.iva = 21 
WHERE YEAR(P.fecha_pedido) < '2009' AND P.codigo_pedido = DP.codigo_pedido;

/*6.12. Modifica la tabla detalle_pedido para incorporar un campo numérico llamado total_linea y actualiza
todos sus registros para calcular su valor con la fórmula: total_linea= precio_unidad*cantidad * (1 + (iva/100));*/
ALTER TABLE detalle_pedido
ADD total_linea DECIMAL(15,2);

UPDATE detalle_pedido 
SET total_linea = precio_unidad * cantidad * (1 + (iva/100));

/*6.13. Borra el cliente que menor límite de crédito tenga. ¿Es posible borrarlo solo con una consulta?*/
DELETE FROM cliente
WHERE limite_credito IN (SELECT MIN(limite_credito) FROM cliente);

/*6.14. Inserta una oficina con sede en Granada y tres empleados que sean representantes de ventas.*/
INSERT INTO oficina (codigo_oficina, ciudad, pais, codigo_postal, telefono, linea_direccion1) VALUES ('GRA-ES', 'Granada', 'España', '32474', 234745234, 'Avenida de Granada, 69');

INSERT INTO empleado (codigo_empleado, nombre, apellido1, extension, email, codigo_oficina, puesto) VALUES (33, 'Tomas', 'Turbado', 2354, 'turbadotomas@jardineria.es', 'GRA-ES', 'Representante Ventas');
INSERT INTO empleado (codigo_empleado, nombre, apellido1, extension, email, codigo_oficina, puesto) VALUES (34, 'Lucas', 'Poso', 6473, 'lucasposo@jardineria.es', 'GRA-ES', 'Representante Ventas');
INSERT INTO empleado (codigo_empleado, nombre, apellido1, extension, email, codigo_oficina, puesto) VALUES (35, 'Nicolas', 'Timado', 8234, 'nicolastimado@jardineria.es', 'GRA-ES', 'Representante Ventas');

/*6.15. Inserta tres clientes que tengan como representantes de ventas los empleados que hemos creado en el paso anterior.*/
INSERT INTO cliente (codigo_cliente, nombre_cliente, telefono, fax, linea_direccion1, ciudad, codigo_empleado_rep_ventas) VALUES (39, 'Jardinerias Paco', 234192343, 718234391, 'calle 1', 'Granada', 33);
INSERT INTO cliente (codigo_cliente, nombre_cliente, telefono, fax, linea_direccion1, ciudad, codigo_empleado_rep_ventas) VALUES (40, 'Jardineriasss.SL', 123958345, 738492945, 'calle 2', 'Murcia', 34);
INSERT INTO cliente (codigo_cliente, nombre_cliente, telefono, fax, linea_direccion1, ciudad, codigo_empleado_rep_ventas) VALUES (41, 'El Jardin', 892334223, 124592034, 'calle 3', 'Malaga', 35);
