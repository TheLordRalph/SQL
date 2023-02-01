/*3.1.¿Cuántos empleados hay en la compañía?*/
SELECT COUNT(codigo_empleado) FROM empleado;

/*3.2.¿Cuántos clientes tiene cada país?*/
SELECT pais, COUNT(codigo_cliente) FROM cliente GROUP BY pais;

/*3.3.¿Cuál fue el pago medio en 2009?*/
SELECT AVG(total) FROM pago WHERE YEAR(fecha_pago) = '2009';

/*3.4.¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.*/
SELECT estado, COUNT(codigo_pedido) FROM pedido GROUP BY estado ORDER BY COUNT(codigo_pedido) DESC;

/*3.5.Calcula el precio de venta del producto más caro y más barato en una misma consulta.*/
SELECT MAX(precio_venta) AS precioMasCaro, MIN(precio_venta) AS precioMasBarato FROM producto;

/*3.6.Calcula el número de clientes que tiene la empresa.*/
SELECT COUNT(codigo_cliente) FROM cliente;

/*3.7.¿Cuántos clientes tiene la ciudad de Madrid?*/
SELECT COUNT(codigo_cliente) FROM cliente WHERE ciudad = 'Madrid';

/*3.8.¿Calcula cuantos clientes tiene cada una de las ciudades que empiezan por M?*/
SELECT COUNT(codigo_cliente) FROM cliente WHERE ciudad LIKE 'M%';

/*3.9.Muestra el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.*/
SELECT codigo_empleado_rep_ventas, COUNT(codigo_cliente) FROM cliente GROUP BY codigo_empleado_rep_ventas;

/*3.10.Calcula el número de clientes que no tiene asignado representante de ventas.*/
SELECT COUNT(codigo_cliente) FROM cliente WHERE codigo_empleado_rep_ventas = NULL;

/*3.11.Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.*/
SELECT C.nombre_contacto, C.apellido_contacto, MIN(P.fecha_pago) AS primerPago,  MAx(P.fecha_pago) AS ultimoPago
FROM cliente C, pago P 
WHERE C.codigo_cliente = P.codigo_cliente 
GROUP BY C.codigo_cliente;

/*3.12.Calcula el número de productos diferentes que hay en cada uno de los pedidos.*/
SELECT COUNT(DISTINCT codigo_producto), codigo_pedido FROM detalle_pedido GROUP BY codigo_pedido;