/*1.9. Muestra un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.*/
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE estado != 'Entregado';

/*1.10. Muestra un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.
	Utilizando la función ADDDATE de MySQL.*/
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE fecha_esperada = ADDDATE(fecha_entrega, INTERVAL 2 DAY);

/*	Utilizando la función DATEDIFF de MySQL.*/
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE DATEDIFF(fecha_esperada, fecha_entrega) = 2;

/*1.11. Muestra un listado de todos los pedidos que fueron rechazados en 2009.*/
SELECT codigo_pedido FROM pedido WHERE estado = 'Rechazado' AND YEAR(fecha_pedido) = '2009';

/*1.12. Muestra un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.*/
SELECT codigo_pedido FROM pedido WHERE MONTH(fecha_entrega) = '01';

/*1.13. Muestra un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.*/
SELECT id_transaccion FROM pago WHERE YEAR(fecha_pago) = '2008' AND forma_pago = 'Paypal' ORDER BY id_transaccion DESC;

/*1.14. Muestra un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.*/
SELECT DISTINCT(forma_pago) FROM pago;

/*1.15. Muestra un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer
lugar los de mayor precio.*/
SELECT nombre FROM producto WHERE gama = 'Ornamentales' AND cantidad_en_stock > 100 ORDER BY precio_venta DESC;

/*1.16. Muestra un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.*/
SELECT codigo_cliente, codigo_empleado_rep_ventas FROM cliente WHERE ciudad = 'Madrid' AND codigo_empleado_rep_ventas = 11 OR codigo_empleado_rep_ventas = 30;
