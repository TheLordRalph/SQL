/*4.3.1. Muestra el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.*/
SELECT nombre, apellido1, puesto 
FROM empleado 
WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

/*4.3.2. Muestra un listado que muestre solamente los clientes que no han realizado ningún pago.*/
SELECT codigo_cliente 
FROM cliente 
WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

/*4.3.3. Muestra un listado que muestre solamente los clientes que sí han realizado ningún pago.*/
SELECT codigo_cliente 
FROM cliente 
WHERE codigo_cliente IN (SELECT codigo_cliente FROM pago);

/*4.3.4. Muestra un listado de los productos que nunca han aparecido en un pedido.*/
SELECT codigo_producto 
FROM producto 
WHERE codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);

/*4.3.5. Muestra el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean 4 representante de ventas de ningún cliente.*/
/*NO SE QUE ME QUIERES DECIR EN EL ENCUNCIADO*/
SELECT nombre, apellido1, puesto, telefono 
FROM empleado 
WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

/*4.3.6. Muestra las oficinas donde no trabajan ninguno de los empleados que hayan sido los
representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama
Frutales.*/
SELECT codigo_oficina
FROM oficina
WHERE codigo_oficina NOT IN (
SELECT codigo_oficina
FROM empleado 
WHERE codigo_empleado IN (
SELECT codigo_empleado_rep_ventas 
FROM cliente
WHERE codigo_cliente IN (
SELECT codigo_cliente 
FROM pedido
WHERE codigo_pedido IN (
SELECT codigo_pedido 
FROM detalle_pedido
WHERE codigo_producto IN (
SELECT codigo_producto
FROM producto
WHERE gama = 'Frutales')))));

/*4.3.7. Muestra un listado con los clientes que han realizado algún pedido pero no han realizado pagos.*/
SELECT codigo_cliente 
FROM cliente 
WHERE codigo_cliente IN (SELECT codigo_cliente FROM pedido) AND codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

/*4.4.1. Muestra un listado que muestre solamente los clientes que no han realizado ningún pago.*/
SELECT C.codigo_cliente 
FROM cliente 
WHERE NOT EXISTS (SELECT P.codigo_cliente FROM pago P WHERE P.codigo_cliente = C.codigo_cliente);

/*4.4.2. Muestra un listado que muestre solamente los clientes que sí han realizado ningún pago.*/
SELECT C.codigo_cliente 
FROM cliente 
WHERE EXISTS (SELECT P.codigo_cliente FROM pago P WHERE P.codigo_cliente = C.codigo_cliente);

/*4.4.3. Muestra un listado de los productos que nunca han aparecido en un pedido.*/
SELECT codigo_producto 
FROM producto
WHERE NOT EXISTS (SELECT codigo_producto FROM detalle_pedido);

/*4.4.4. Muestra un listado de los productos que han aparecido en un pedido alguna vez.*/
SELECT codigo_producto 
FROM producto
WHERE EXISTS (SELECT codigo_producto FROM detalle_pedido);