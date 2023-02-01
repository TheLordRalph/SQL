/*1. Muestra listado con todos los pedidos que se han realizado ordenados por la fecha de realización, mostrando en primer lugar los pedidos más recientes.*/
SELECT *
FROM pedido
ORDER BY fecha DESC;

/*2. Muestra todos los datos de los dos pedidos de mayor valor.*/
SELECT *
FROM pedido
ORDER BY total DESC
LIMIT 2;

/*3. Muestra un listado con los diferentes identificadores de los clientes que han realizado algún pedido.*/
SELECT distinct id_cliente
FROM pedido;

/*4. Muestra un listado con los identificadores de todos los pedidos con cantidad mayor de 500€ que se realizaron durante el año 2017.*/
SELECT id
FROM pedido
WHERE total > 500 AND YEAR(fecha) = '2017';

/*5. Muestra un listado con el nombre y los apellidos de los comerciales que tienen una comisión entre 0.05 y 0.11.*/
SELECT nombre, apellido1
FROM comercial
WHERE comisión >= 0.05 AND comisión <= 0.11;

/*6. Muestra la comisión de mayor valor que existe en la tabla comercial.*/
SELECT MAX(comisión)
FROM comercial;

/*7. Muestra el identificador, nombre y primer apellido de aquellos clientes cuyo segundo apellido no está vacío, ordenado alfabéticamente por apellidos y nombre de la Z - A.*/
SELECT id, nombre, apellido1
FROM cliente
WHERE apellido2 IS NOT NULL
ORDER BY apellido1 ASC, nombre DESC;

/*8. Muestra un listado de los nombres de los clientes que empiezan por A y terminan por n y también los nombres que empiezan por P ordenado alfabéticamente de la A - Z.*/
SELECT nombre
FROM cliente
WHERE nombre LIKE 'A%' AND nombre LIKE '%n' OR nombre LIKE 'P%'
ORDER BY nombre ASC;

/*9. Muestra un listado de los nombres de los clientes que no empiezan por A.*/
SELECT nombre
FROM cliente
WHERE nombre NOT LIKE 'A%';

/*10. Muestra un listado con los diferentes nombres de los comerciales que terminan por o.*/
SELECT nombre
FROM comercial
WHERE nombre LIKE '%o';

/*11. Muestra un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido.*/
SELECT distinct C.id, C.nombre, C.apellido1, C.apellido2
FROM cliente C, pedido P
WHERE C.id = P.id_cliente;

/*12. Muestra un listado que muestre todos los pedidos que ha realizado cada cliente. El resultado debe mostrar todos los datos de los pedidos y del cliente. Ordenarlo por el primer apellido del cliente.*/
SELECT C.*, P.*
FROM pedido P, cliente C
WHERE P.id_cliente = C.id
ORDER BY C.apellido1;

/*13. Muestra un listado con todos los pedidos en los que ha participado un comercial que muestre todos los datos de los pedidos y de los comerciales*/
SELECT CO.*, P.*
FROM pedido P, comercial CO
WHERE P.id_comercial = CO.id;

/*14. Muestra un listado con todos los clientes, con todos los pedidos que han realizado y con los datos de los comerciales asociados a cada pedido.*/
SELECT C.*, 'cliente', P.*, 'pedido', CO.*, 'comercial'
FROM pedido P, cliente C, comercial CO
WHERE P.id_cliente = C.id AND P.id_comercial = CO.id
ORDER BY C.apellido1;

/*15. Muestra un listado con todos los clientes que realizaron un pedido durante el año 2017,
cuya cantidad esté entre 300 € y 1000 €.*/
SELECT C.*
FROM cliente C, pedido P
WHERE P.id_cliente = C.id AND YEAR(P.fecha) = '2017' AND total BETWEEN 300 AND 1000;

/*16. Muestra el nombre y los apellidos de todos los comerciales que ha participado en algún
pedido realizado por María Santana Moreno.*/
SELECT CO.nombre, CO.apellido1, CO.apellido2
FROM comercial CO, pedido P, cliente C
WHERE CO.id = P.id_comercial AND P.id_cliente = C.id AND C.nombre = 'Maria' AND C.apellido1 = 'Santana' AND C.apellido2 = 'Moreno';

/*17. Muestra el nombre de todos los clientes que han realizado algún pedido con el
comercial Daniel Sáez Vega.*/
SELECT C.nombre, C.apellido1, C.apellido2
FROM comercial CO, pedido P, cliente C
WHERE CO.id = P.id_comercial AND P.id_cliente = C.id AND CO.nombre = 'Daniel' AND CO.apellido1 = 'Sáez' AND CO.apellido2 = 'Vega';

/*18. Muestra un listado con todos los clientes junto con los datos de los pedidos que han
realizado. Este listado también debe incluir los clientes que no han realizado ningún
pedido. El listado debe estar ordenado alfabéticamente por el primer apellido, segundo
apellido y nombre de los clientes.*/
SELECT 'cliente', C.*, 'pedido', P.*
FROM cliente C, pedido P
WHERE C.id = P.id_cliente
UNION
SELECT 'cliente', C.*, 'pedido', 'NULL', 'NULL', 'NULL', 'NULL', 'NULL'
FROM cliente C, pedido P
WHERE C.id NOT IN 
(SELECT P.id_cliente FROM pedido P)
ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

/*19. Muestra un listado con todos los comerciales junto con los datos de los pedidos en los
que han participado. Este listado también debe incluir los comerciales que no han realizado
ningún pedido. El listado debe estar ordenado alfabéticamente por el primer apellido,
segundo apellido y nombre de los comerciales.*/
SELECT 'comercial', CO.*, 'pedido', P.*
FROM comercial CO, pedido P
WHERE CO.id = P.id_cliente
UNION
SELECT 'comercial', CO.*, 'pedido', 'NULL', 'NULL', 'NULL', 'NULL', 'NULL'
FROM comercial CO, pedido P
WHERE CO.id NOT IN 
(SELECT P.id_comercial FROM pedido P)
ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

/*20. Muestra un listado con los clientes que no han realizado ningún pedido.*/
SELECT DISTINCT C.*
FROM cliente C, pedido P
WHERE C.id NOT IN 
(SELECT P.id_cliente FROM pedido P);

/*21. Muestra un listado con los comerciales que no han participado en ningún pedido.*/
SELECT distinct CO.*
FROM comercial CO, pedido P
WHERE CO.id NOT IN 
(SELECT P.id_comercial FROM pedido P);

/*22. Muestra un listado con los apellidos y nombre de los clientes que no han realizado ningún
pedido y apellidos y nombre de los comerciales que no han participado en ningún pedido.
Ordena el listado alfabéticamente por los apellidos y el nombre. En este listado se debe
diferenciar de algún modo a los clientes de los comerciales.*/
SELECT id, nombre, apellido1, apellido2, 'cliente'
FROM cliente
WHERE id NOT IN 
(SELECT id_cliente FROM pedido)
UNION
SELECT id, nombre, apellido1, apellido2, 'comercial'
FROM comercial
WHERE id NOT IN 
(SELECT id_comercial FROM pedido)
ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

/*23. Calcula la cantidad total que suman todos los pedidos.*/
SELECT SUM(total)
FROM pedido;

/*24. Calcula la cantidad media de todos los pedidos.*/
SELECT AVG(total)
FROM pedido;

/*25. Calcula el número total de comerciales distintos que aparecen en la tabla pedido.*/
SELECT COUNT(DISTINCT id_comercial)
FROM pedido;

/*26. Calcula el número total de clientes que aparecen en la tabla cliente.*/
SELECT COUNT(id)
FROM cliente;

/*27. Muestra la mayor cantidad que aparece en la tabla pedido.*/
SELECT MAX(total)
FROM pedido;

/*28. Muestra la menor cantidad que aparece en la tabla pedido.*/
SELECT MIN(total)
FROM pedido;
 
/*29. Calcula la máxima categoría para cada una de las ciudades de la tabla cliente.*/
SELECT MAX(id_categoria)
FROM cliente;

/*30. Calcula la cantidad máxima de los pedidos realizados durante el mismo día para cada
uno de los clientes. El mismo cliente puede haber realizado varios pedidos de diferentes
cantidades el mismo día. Se trata de calcular cuál es el pedido de máximo valor para cada
uno de los días en los que un cliente ha realizado un pedido (o varios). El listado debe
mostrar: id del cliente, nombre, apellidos, la fecha del pedido y la cantidad máxima.*/
SELECT P.id_cliente, C.nombre, C.apellido1, C.apellido2, P.fecha, MAX(P.total)
FROM pedido P
INNER JOIN cliente C ON C.id = P.id_cliente
GROUP BY P.id_cliente, P.fecha;

/*31. Calcula la cantidad máxima de los pedidos realizados durante el mismo día para cada
uno de los clientes, teniendo en cuenta que sólo queremos mostrar aquellos pedidos que
superen la cantidad de 2000 €.*/
SELECT P.id_cliente, C.nombre, C.apellido1, C.apellido2, P.fecha, MAX(P.total)
FROM pedido P
INNER JOIN cliente C ON C.id = P.id_cliente
WHERE P.total > 2000
GROUP BY P.id_cliente, P.fecha;

/*32. Calcula la cantidad máxima de los pedidos en los que ha participado cada uno de los
comerciales en la fecha 2016-08-17. El listado debe mostrar: id del comercial, nombre,
apellidos y cantidad máxima.*/
SELECT P.id_comercial, CO.nombre, CO.apellido1, CO.apellido2, MAX(P.total)
FROM pedido P
INNER JOIN comercial CO ON CO.id = P.id_comercial
WHERE DATE(fecha) = '2016-08-17'
GROUP BY P.id_comercial;

/*33. Muestra un listado con los clientes y el número total de pedidos que ha realizado cada
uno. Los clientes que no hayan realizado pedidos también deben aparecer en el listado
con número de pedidos realizados igual a 0.
El listado debe mostrar: id del cliente, nombre, apellidos y nº de pedidos.*/
SELECT C.id, C.nombre, C.apellido1, C.apellido2, COUNT(P.id) AS 'nº de pedidos'
FROM cliente C, pedido P
WHERE C.id = P.id_cliente
GROUP BY C.id
UNION
SELECT C.id, C.nombre, C.apellido1, C.apellido2, '0' AS 'nº de pedidos'
FROM cliente C, pedido P
WHERE C.id NOT IN 
(SELECT P.id_cliente FROM pedido P)
GROUP BY C.id;

/*34. Muestra un listado con los clientes y el número total de pedidos que ha realizado cada
uno durante el año 2017 (puede ser 0). El listado debe mostrar: id del cliente, nombre,
apellidos y nº de pedidos.*/
SELECT P.id_cliente, C.nombre, C.apellido1, C.apellido2, COUNT(P.id) AS 'nº de pedidos'
FROM pedido P, cliente C
WHERE YEAR(fecha) = '2017' AND P.id_cliente = C.id
GROUP BY P.id_cliente;

/*35. Muestra un listado con los clientes y la máxima cantidad del pedido incluida en los
pedidos realizados por cada uno de los clientes (puede ser 0). El listado debe mostrar: id
del cliente, nombre, apellidos y cantidad máxima.*/
SELECT P.id_cliente, C.nombre, C.apellido1, C.apellido2, MAX(P.total) AS 'cantidad máxima'
FROM pedido P, cliente C
WHERE YEAR(fecha) = '2017' AND P.id_cliente = C.id
GROUP BY P.id_cliente;

/*36. Muestra el pedido de máximo valor que se ha realizado cada año.*/
SELECT YEAR(fecha), MAX(total) AS 'cantidad máxima'
FROM pedido
GROUP BY YEAR(fecha);

/*37. Muestra el número total de pedidos que se han realizado cada año.*/
SELECT YEAR(fecha), COUNT(*) AS 'total pedidos'
FROM pedido
GROUP BY YEAR(fecha);

/*38. Muestra un listado con todos los pedidos que ha realizado Adela Salas Díaz.
(subconsulta y JOIN).*/
SELECT P.*
FROM pedido P, cliente C
WHERE C.id = P.id_cliente 
AND C.id = (SELECT C.id
FROM cliente C
WHERE C.nombre = 'Adela' AND C.apellido1 = 'Salas' AND C.apellido2 = 'Díaz');

/*39. Muestra el número de pedidos en los que ha participado el comercial Daniel Sáez Vega.
(subconsulta y JOIN).*/
SELECT P.*
FROM pedido P, comercial CO
WHERE CO.id = P.id_comercial 
AND CO.id = (SELECT CO.id
FROM comercial CO
WHERE CO.nombre = 'Daniel' AND CO.apellido1 = 'Sáez' AND CO.apellido2 = 'Vega');

/*40. Muestra los datos del cliente que realizó el pedido más caro en el año 2019.
(subconsulta y JOIN)*/
SELECT C.*
FROM pedido P, cliente C
WHERE C.id = P.id_cliente
AND P.total = (SELECT MAX(total) FROM pedido WHERE YEAR(fecha) = '2019');

/*41. Muestra la fecha y la cantidad del pedido de menor valor realizado por el cliente Pepe
Ruiz Santana. (subconsulta y JOIN).*/
SELECT P.fecha, P.total
FROM pedido P, cliente C
WHERE P.total = (SELECT MIN(P.total) FROM pedido P, cliente C WHERE C.id = P.id_cliente 
AND C.nombre = 'Pepe' 
AND C.apellido1 = 'Ruiz' 
AND C.apellido2 = 'Santana')
LIMIT 1;

/*42. Muestra un listado con los datos de los clientes y los pedidos, de todos los clientes que
han realizado un pedido durante el año 2017 con un valor mayor o igual al valor
medio de los pedidos realizados durante ese mismo año.*/
SELECT C.*, P.*
FROM cliente C, pedido P
WHERE C.id = P.id_cliente 
AND YEAR(P.fecha) = '2017' 
AND P.total >= (SELECT AVG(P.total) FROM pedido P WHERE YEAR(P.fecha) = '2017');

/*43. Muestra el pedido más caro que existe en la tabla pedido usando ANY o ALL.*/
SELECT P.total 
FROM pedido P
WHERE P.total = ALL (SELECT MAX(P.total) FROM pedido P);

/*44. Muestra un listado de los clientes que no han realizado ningún pedido usando ANY o ALL.*/
SELECT C.* 
FROM cliente C
WHERE C.id != ALL (SELECT P.id_cliente FROM pedido P);

/*45. Muestra un listado de los comerciales que no han realizado ningún pedido
usando ANY o ALL.*/
SELECT CO.* 
FROM comercial CO
WHERE CO.id != ALL (SELECT P.id_comercial FROM pedido P);

/*46. Muestra un listado de los clientes que no han realizado ningún pedido usando IN o NOT
IN.*/
SELECT C.* 
FROM cliente C
WHERE C.id NOT IN (SELECT P.id_cliente FROM pedido P);

/*47. Muestra un listado de los comerciales que no han participado en ningún pedido
usando IN o NOT IN.*/
SELECT CO.* 
FROM comercial CO
WHERE CO.id NOT IN (SELECT P.id_comercial FROM pedido P);

/*48. Muestra un listado de los clientes que no han realizado ningún pedido
usando EXISTS o NOT EXISTS.*/
SELECT C.* 
FROM cliente C
WHERE NOT EXISTS (SELECT P.id_cliente FROM pedido P WHERE P.id_cliente = C.id);
 
/*49. Muestra un listado de los comerciales que no han realizado ningún pedido.
(Utilizando EXISTS o NOT EXISTS).*/
SELECT CO.* 
FROM comercial CO
WHERE NOT EXISTS (SELECT P.id_comercial FROM pedido P WHERE P.id_comercial = CO.id);

/*50. Inserta una nueva categoría de cliente en la base de datos.*/
INSERT INTO catcliente VALUES (400, 'El Master');

/*51. Inserta un nuevo cliente en la base de datos.*/
INSERT INTO cliente VALUES (11, 'Santiago', 'Ramon', 'Cajal', 'Tomelloso', 400);

/*52. Inserta un nuevo comercial en la base de datos.*/
INSERT INTO comercial VALUES (9, 'Facundo', 'Tanhausen', 'Primero', 0.01);

/*53. Inserta un nuevo pedido en la base de datos y asócialo al cliente y al comercial recién
creados.*/
INSERT INTO pedido VALUES (20, 10000, '2021-03-21', 11, 9);

/*54. Crea una tabla oficina con los campos: identificador (entero de tamaño 3) y nombre de
la oficina (cadena de tamaño 50 que no puede ser vacía) y teléfono (cadena de tamaño
20 y por defecto con valor ‘Sevilla’).*/
CREATE TABLE oficina (
id INT(3) PRIMARY KEY,
nombre_oficina VARCHAR(50) NOT NULL,
telefono INT(10)
);

/*55. Inserta las oficinas con nombres: Sevilla y Granada.*/
INSERT INTO oficina VALUES (1, 'Sevilla', 951234572);
INSERT INTO oficina VALUES (2, 'Granada', 931886440);

/*56. Añade un campo id_oficina a la tabla de comerciales que haga referencia a la tabla
recién creada.*/
ALTER TABLE comercial ADD id_oficina INT(3);
ALTER TABLE comercial ADD FOREIGN KEY (id_oficina) REFERENCES oficina(id);

/*57. Asigna a cada comercial alguna de las oficinas recién creadas.*/
UPDATE comercial SET id_oficina = 2 WHERE id = 1;
UPDATE comercial SET id_oficina = 1 WHERE id = 2;
UPDATE comercial SET id_oficina = 2 WHERE id = 3;
UPDATE comercial SET id_oficina = 2 WHERE id = 4;
UPDATE comercial SET id_oficina = 1 WHERE id = 5;
UPDATE comercial SET id_oficina = 2 WHERE id = 6;
UPDATE comercial SET id_oficina = 1 WHERE id = 7;
UPDATE comercial SET id_oficina = 1 WHERE id = 8;
UPDATE comercial SET id_oficina = 1 WHERE id = 9;

/*58. Borra la categoría de cliente denominada ‘Otros’.*/
DELETE FROM catcliente WHERE id = 0;

/*59. Asigna al cliente Adolfo Rubio Flores la categoría ‘Ocasional’.*/
UPDATE cliente SET id_categoria = 100 WHERE id = 3;

/*60. Modifica la tabla cliente de tal forma que cuando se borre una categoría de cliente en la
tabla catcliente, el valor borrado de esa categoría que exista en la tabla de clientes quede
vacío.*/
ALTER TABLE cliente ADD CONSTRAINT FK_id_cliente
FOREIGN KEY (id_categoria) REFERENCES catcliente(id) ON DELETE SET NULL;
