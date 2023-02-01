/*1.1. Muestra un listado con el código de oficina y la ciudad donde hay oficinas.*/
SELECT codigo_oficina, ciudad FROM oficina;

/*1.2. Muestra un listado con la ciudad y el teléfono de las oficinas de España.*/
SELECT ciudad, telefono FROM oficina;

/*1.3. Muestra un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.*/
SELECT nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe = 7;

/*1.4. Muestra el nombre del puesto, nombre, apellidos y email del jefe de la empresa.*/
SELECT puesto, nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe IS NULL;

/*1.5. Muestra un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.*/
SELECT nombre, apellido1, apellido2, puesto FROM empleado WHERE puesto != 'Representante Ventas';

/*1.6. Muestra un listado con el nombre de los todos los clientes españoles.*/
SELECT nombre_cliente FROM cliente WHERE pais = 'Spain';

/*1.7. Muestra un listado con los distintos estados por los que puede pasar un pedido.*/
SELECT DISTINCT(estado) FROM pedido;

/*1.8. Muestra un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008.
Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la
consulta:*/

/*Utilizando la función YEAR de MySQL.*/
SELECT DISTINCT codigo_cliente FROM pago WHERE '2008' = YEAR(fecha_pago);

/*Utilizando la función DATE_FORMAT de MySQL.*/
SELECT DISTINCT codigo_cliente FROM pago WHERE '2008' = DATE_FORMAT(fecha_pago, '%Y');

/*Sin utilizar ninguna de las funciones anteriores.*/
SELECT DISTINCT codigo_cliente FROM pago WHERE fecha_pago BETWEEN '2008-01-01' AND '2008-12-31';

