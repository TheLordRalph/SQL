/*4.1.1. Muestra el nombre del cliente con mayor límite de crédito.*/
SELECT nombre_cliente
FROM cliente
WHERE limite_credito = (SELECT MAX(limite_credito) FROM cliente);

/*4.1.2. Muestra el nombre del producto que tenga el precio de venta más caro.*/
SELECT nombre
FROM producto
WHERE precio_venta = (SELECT MAX(precio_venta) FROM producto);

/*4.1.3. Muestra el nombre del producto del que se han vendido más unidades. (Tenga en cuenta que
tendrá que calcular cuál es el número total de unidades que se han vendido de cada producto a
partir de los datos de la tabla detalle_pedido. Una vez que sepa cuál es el código del producto,
puede obtener su nombre fácilmente).*/
SELECT nombre
FROM producto
WHERE codigo_producto = (SELECT codigo_producto 
FROM detalle_pedido 
WHERE cantidad = (SELECT SUM(cantidad), codigo_producto FROM detalle_pedido GROUP BY codigo_producto));

/*4.1.4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).*/
SELECT limite_credito
FROM cliente;
WHERE limite_credito > (SELECT SUM(total)
FROM pago
GROUP BY codigo_cliente);

/*4.1.5. Muestra el producto que más unidades tiene en stock.*/
SELECT codigo_producto
FROM producto
WHERE cantidad_en_stock = (SELECT MAX(cantidad_en_stock) FROM producto);

/*4.1.6. Muestra el producto que menos unidades tiene en stock.*/
SELECT codigo_producto
FROM producto
WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) FROM producto);

/*4.1.7. Muestra el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.*/
SELECT  nombre, apellido1, email
FROM empleado
WHERE codigo_jefe = (SELECT codigo_empleado FROM empleado WHERE nombre = 'Alberto' AND apellido1 = 'Soria');

/*4.2.1. Muestra el nombre del cliente con mayor límite de crédito.*/
SELECT nombre_cliente
FROM cliente
WHERE limite_credito = ALL (SELECT MAX(limite_credito) FROM cliente);

/*4.2.2. Muestra el nombre del producto que tenga el precio de venta más caro.*/
SELECT nombre
FROM producto
WHERE precio_venta = ANY (SELECT MAX(precio_venta) FROM producto);

/*4.2.3. Muestra el producto que menos unidades tiene en stock.*/
SELECT codigo_producto
FROM producto
WHERE cantidad_en_stock = ANY (SELECT MIN(cantidad_en_stock) FROM producto);