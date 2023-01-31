/*6.1 Inserta una nueva oficina en Almería*/
INSERT INTO oficina (codigo_oficina, ciudad, pais, codigo_postal, telefono, linea_direccion1) VALUES ('ALM-ES', 'Almeria', 'España', '34876', '+34 913245667', 'Avenida La Grandeza');

/*6.2 Inserta un empleado para la oficina de Almería que sea representante de ventas*/
INSERT INTO empleado (codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina, puesto) VALUES (32, 'Ester', 'Colero', 'Garcia', '3244', 'estercolero@jardineria.es', 'ALM-ES', 'Representante Ventas');

/*6.3 Inserta un cliente que tenga como representante de ventas el empleado que hemos creado en el paso
anterior*/
INSERT INTO cliente (codigo_cliente, nombre_cliente, telefono, fax, linea_direccion1, ciudad, codigo_empleado_rep_ventas) VALUES (39, 'Manolo', '341234123', '2223341232', 'Calle Mayor', 'Almeria', 32);

/*6.4 Inserte un pedido para el cliente que acabamos de crear, que contenga al menos dos productos*/
INSERT INTO pedido (codigo_pedido, fecha_pedido, fecha_esperada, estado, codigo_cliente) VALUES (129, '2008-11-20', '2008-12-05', 'Pendiente', 39);
INSERT INTO detalle_pedido (codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea) VALUES (129, 'OR-141', 10, 29.10, 1);
INSERT INTO detalle_pedido (codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea) VALUES (129, 'FR-13', 30, 40.00, 2);

/*6.5 Actualiza el código del cliente que hemos creado en el paso anterior y averigua si hubo cambios en
las tablas relacionadas*/
UPDATE cliente SET codigo_cliente = 40 WHERE codigo_cliente = 39;
