/*2.1 Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas*/
SELECT C.nombre_cliente, E.nombre, E.apellido1 FROM cliente C, empleado E WHERE C.codigo_empleado_rep_ventas = E.codigo_empleado;

/*2.2 Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus
representantes de ventas*/
SELECT DISTINCT C.nombre_cliente, E.nombre FROM pago P, cliente C, empleado E WHERE P.codigo_cliente = C.codigo_cliente AND C.codigo_empleado_rep_ventas = E.codigo_empleado;

/*2.3 Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas*/
SELECT DISTINCT C.nombre_cliente, E.nombre FROM pago P, cliente C, empleado E WHERE P.codigo_cliente != C.codigo_cliente AND C.codigo_empleado_rep_ventas = E.codigo_empleado;

/*2.4 Muestra el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la
ciudad de la oficina a la que pertenece el representante*/
SELECT DISTINCT C.nombre_cliente, E.nombre, O.ciudad FROM pago P, cliente C, empleado E, oficina O WHERE P.codigo_cliente = C.codigo_cliente AND C.codigo_empleado_rep_ventas = E.codigo_empleado AND E.codigo_oficina = O.codigo_oficina; 

/*2.5 Muestra el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto
con la ciudad de la oficina a la que pertenece el representante*/
SELECT DISTINCT C.nombre_cliente, E.nombre, O.ciudad FROM pago P, cliente C, empleado E, oficina O WHERE P.codigo_cliente != C.codigo_cliente AND C.codigo_empleado_rep_ventas = E.codigo_empleado AND E.codigo_oficina = O.codigo_oficina;

/*2.6 Lista la dirección de las oficinas que tengan clientes en Fuenlabrada*/
SELECT O.linea_direccion1 FROM oficina O, cliente C, empleado E WHERE C.codigo_empleado_rep_ventas = E.codigo_empleado AND E.codigo_oficina = O.codigo_oficina AND C.ciudad = 'Fuenlabrada';

/*2.7 Muestra el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina
a la que pertenece el representante*/
SELECT C.nombre_cliente, E.nombre, O.ciudad FROM cliente C, empleado E, oficina O WHERE codigo_empleado_rep_ventas = codigo_empleado AND E.codigo_oficina = O.codigo_oficina;

/*2.8 Muestra un listado con el nombre de los empleados junto con el nombre de sus jefes*/
SELECT E.nombre, J.nombre AS nombreJefe FROM empleado E, empleado J WHERE J.codigo_empleado = E.codigo_jefe;

/*2.9 Muestra el nombre de los clientes a los que no se les ha entregado a tiempo un pedido*/
SELECT C.nombre_cliente, P.estado FROM pedido P, cliente C WHERE DATEDIFF(P.fecha_esperada, P.fecha_entrega) > 0 AND P.codigo_cliente = C.codigo_cliente;

/*2.10 Muestra un listado de las diferentes gamas de producto que ha comprado cada cliente*/
SELECT DISTINCT(P.gama), C.nombre_cliente FROM producto P, cliente C, pedido PE, detalle_pedido DP WHERE DP.codigo_producto = P.codigo_producto AND PE.codigo_cliente = C.codigo_cliente AND PE.codigo_pedido = DP.codigo_pedido;
