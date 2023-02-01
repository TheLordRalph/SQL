/*5.1. Muestra el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado.
Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.*/
SELECT  C.nombre_cliente, COUNT(P.codigo_pedido)
FROM cliente C LEFT JOIN pedido P ON (C.codigo_cliente = P.codigo_cliente)
GROUP BY C.nombre_cliente;

/*5.2. Muestra un listado con los nombres de los clientes y el total pagado por cada uno de ellos.
Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.*/
SELECT  C.nombre_cliente, SUM(P.total)
FROM cliente C LEFT JOIN pedido P ON (C.codigo_cliente = P.codigo_cliente)
GROUP BY C.nombre_cliente;

SELECT  C.nombre_cliente, SUM(P.total)
FROM cliente C LEFT JOIN pago P ON (C.codigo_cliente = P.codigo_cliente)
GROUP BY C.nombre_cliente;

/*5.3. Muestra el nombre de los clientes que hayan hecho pedidos en 2008 ordenados
alfabéticamente de menor a mayor.*/
SELECT DISTINCT C.nombre_cliente
FROM cliente C, pedido P
WHERE C.codigo_cliente = P.codigo_cliente AND YEAR(P.fecha_pedido) = '2008'
ORDER BY nombre_cliente ASC;

/*5.4. Muestra el nombre del cliente, el nombre y primer apellido de su representante de ventas y el
número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan
realizado ningún pago.*/
SELECT C.nombre_cliente, E.nombre, E.apellido1, O.telefono
FROM cliente C, empleado E, oficina O
WHERE C.codigo_empleado_rep_ventas = E.codigo_empleado AND E.codigo_oficina = O.codigo_oficina AND C.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

/*5.5. Muestra el listado de clientes donde aparezca el nombre del cliente, el nombre y primer
apellido de su representante de ventas y la ciudad donde está su oficina.*/
SELECT C.nombre_cliente, E.nombre, E.apellido1, O.ciudad
FROM cliente C, empleado E, oficina O
WHERE C.codigo_empleado_rep_ventas = E.codigo_empleado AND E.codigo_oficina = O.codigo_oficina;

/*5.6. Muestra el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no
sean representante de ventas de ningún cliente.*/
SELECT C.nombre_cliente, E.nombre, E.apellido1, E.puesto, O.telefono
FROM cliente C, empleado E, oficina O
WHERE C.codigo_empleado_rep_ventas = E.codigo_empleado AND E.codigo_oficina = O.codigo_oficina AND E.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

/*5.7. Muestra un listado indicando todas las ciudades donde hay oficinas y el número de empleados
que tiene.*/
SELECT DISTINCT O.ciudad, COUNT(E.codigo_empleado)
FROM oficina O, empleado E
WHERE E.codigo_oficina = O.codigo_oficina
GROUP BY O.ciudad;
