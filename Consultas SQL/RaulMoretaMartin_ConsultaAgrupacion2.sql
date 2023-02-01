/*3.13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.*/
SELECT codigo_pedido, COUNT(cantidad)
FROM detalle_pedido
GROUP BY codigo_pedido;

/*3.14. Muestra un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. 
El listado deberá estar ordenado por el número total de unidades vendidas.*/
SELECT codigo_producto, cantidad
FROM detalle_pedido
GROUP BY codigo_producto
ORDER BY cantidad DESC
LIMIT 20;

/*3.15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el
IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el número
de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total
la suma de los dos campos anteriores.*/
SELECT SUM(precio_unidad * cantidad) AS baseImponible, SUM((precio_unidad * cantidad) * 0.21) AS IVA, SUM((precio_unidad * cantidad) + (precio_unidad * cantidad) * 0.21) AS total
FROM detalle_pedido;

/*3.16. La misma información que en la pregunta anterior, pero agrupada por código de producto.*/
SELECT (precio_unidad * cantidad) AS baseImponible, ((precio_unidad * cantidad) * 0.21) AS IVA, ((precio_unidad * cantidad) + (precio_unidad * cantidad) * 0.21) AS total
FROM detalle_pedido
GROUP BY codigo_producto;

/*3.17. La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.*/
SELECT codigo_producto, (precio_unidad * cantidad) AS baseImponible, ((precio_unidad * cantidad) * 0.21) AS IVA, ((precio_unidad * cantidad) + (precio_unidad * cantidad) * 0.21) AS total
FROM detalle_pedido
WHERE codigo_producto LIKE "OR%"
GROUP BY codigo_producto;

/*3.18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará
el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).*/
SELECT P.nombre, SUM(DP.cantidad) AS cantidadTotal, SUM(DP.precio_unidad * DP.cantidad) AS totalFacturado, SUM((DP.precio_unidad * DP.cantidad) + ((DP.precio_unidad * DP.cantidad) * 0.21)) AS totalFacturadoIVA
FROM detalle_pedido DP, producto P
WHERE P.codigo_producto = DP.codigo_producto
GROUP BY P.codigo_producto
HAVING totalFacturado >= 3000;
