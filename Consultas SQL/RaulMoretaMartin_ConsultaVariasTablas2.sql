/*2.11 Muestra un listado que muestre solamente los clientes que no han realizado ningún pago*/
SELECT DISTINCT nombre_cliente FROM cliente WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

/*2.12 Muestra un listado que muestre solamente los clientes que no han realizado ningún pedido*/
SELECT DISTINCT nombre_cliente FROM cliente WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pedido);

/*2.13 Muestra un listado que muestre los clientes que no han realizado ningún pago y los que no han
realizado ningún pedido*/
SELECT DISTINCT nombre_cliente FROM cliente WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pedido) AND codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

/*2.14 Muestra un listado que muestre solamente los empleados que no tienen una oficina asociada*/
SELECT nombre FROM empleado WHERE codigo_oficina IS NULL;

/*2.15 Muestra un listado que muestre solamente los empleados que no tienen un cliente asociado*/
SELECT DISTINCT nombre FROM empleado WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

/*2.16 Muestra un listado que muestre solamente los empleados que no tienen un cliente asociado junto
con los datos de la oficina donde trabajan*/
SELECT DISTINCT nombre, codigo_oficina FROM empleado WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

/*2.17 Muestra un listado que muestre los empleados que no oficina asociada ni clientes asociados*/
SELECT DISTINCT nombre, codigo_oficina FROM empleado WHERE codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente) AND codigo_oficina IS NULL;

/*2.18 Muestra un listado de los productos que nunca han aparecido en un pedido*/ 
SELECT DISTINCT codigo_producto FROM producto WHERE codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);

/*2.19 Muestra un listado de los productos que nunca han aparecido en un pedido El resultado debe
mostrar el nombre, la descripción y la imagen del producto*/
SELECT DISTINCT P.codigo_producto, P.nombre, P.descripcion, G.imagen FROM producto P, gama_producto G WHERE codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido) AND P.gama = G.gama;

/*2.20 Muestra las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes
de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales*/
SELECT codigo_oficina FROM oficina WHERE codigo_oficina NOT IN (SELECT codigo_empleado FROM empleado E, cliente C, pedido PE, detalle_pedido DP, producto PO WHERE E.codigo_empleado = C.codigo_empleado_rep_ventas AND C.codigo_cliente = PE.codigo_cliente AND DP.codigo_pedido = PE.codigo_pedido AND DP.codigo_producto = PO.codigo_producto AND PO.gama = 'Frutales');

/*2.21 Muestra un listado con los clientes que han realizado algún pedido pero no han realizado pagos*/
SELECT DISTINCT C.nombre_cliente FROM cliente C, pedido PE WHERE C.codigo_cliente = PE.codigo_cliente AND C.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

/*2.22 Muestra un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su
jefe asociado*/
SELECT DISTINCT E.nombre FROM empleado E, cliente C WHERE E.codigo_empleado != C.codigo_empleado_rep_ventas AND E.codigo_jefe IS NULL;