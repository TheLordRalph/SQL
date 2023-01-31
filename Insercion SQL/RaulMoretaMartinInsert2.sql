/*6.6. Borra el cliente y averigua si hubo cambios en las tablas relacionadas.*/
DELETE FROM cliente WHERE codigo_cliente = 40; /* se elimina tambien el pedido que habia realizado el cliente */

/*6.7. Elimina los clientes que no hayan realizado ningún pedido.*/
DELETE FROM cliente WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pedido);

/*6.8. Incrementa en un 20% el precio de los productos que no tengan pedidos.*/
UPDATE producto SET precio_venta = precio_venta + (precio_venta*0.2) WHERE codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);

/*6.9. Borra los pagos del cliente con menor límite de crédito.*/
DELETE FROM pago WHERE codigo_cliente = (SELECT codigo_cliente FROM cliente WHERE limite_credito = (SELECT MIN(limite_credito) FROM cliente));

/*6.10. Establece a 0 el límite de crédito del cliente que menos unidades pedidas tenga del producto OR-179.*/
UPDATE cliente SET limite_credito = 0 WHERE codigo_cliente =
(SELECT P.codigo_cliente, SUM(DP.cantidad) 
FROM pedido P, detalle_pedido DP
WHERE P.codigo_pedido = DP.codigo_pedido AND DP.codigo_producto = 'OR-179' 
GROUP BY P.codigo_cliente
HAVING SUM(DP.cantidad) <= ALL (SELECT SUM(DP.cantidad)
FROM pedido P1, detalle_pedido DP1
WHERE P1.codigo_pedido = DP1.codigo_pedido
AND DP1.codigo_producto = 'OR-179'
GROUP BY P1.codigo_cliente));