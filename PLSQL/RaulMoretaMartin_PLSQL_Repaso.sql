/*R1. Crea un procedimiento llamado obtener_numero_empleados que reciba como parámetro de entrada el código de una oficina y devuelva el número de empleados que tiene.*/

DELIMITER $$
DROP PROCEDURE IF EXISTS obtener_numero_empleados $$

CREATE PROCEDURE obtener_numero_empleados(IN codigoOficina VARCHAR(10), OUT numeroEmpleado INT)
BEGIN

SELECT COUNT(*) AS 'Numero de Empleados'
FROM empleado
WHERE codigo_oficina = codigoOficina;
 
END$$


DELIMITER ;

call obtener_numero_empleados('TAL-ES', @rdo1);





/*R2. Crea una función llamada busca_más_vendido que devuelva el código del producto del que más cantidad se ha pedido.*/

DELIMITER $$
DROP FUNCTION IF EXISTS cant_vend $$

CREATE FUNCTION cant_vend(cod_pro VARCHAR(15))
RETURNS INT DETERMINISTIC
BEGIN

DECLARE resultado INT DEFAULT 0;

IF cod_pro IN (SELECT codigo_producto FROM producto) THEN

SELECT SUM(cantidad)
INTO resultado
FROM producto
WHERE codigo_producto = cod_pro;

ELSE

SET resultado = 0;

END IF;

RETURN resultado;

END$$

DELIMITER ;


DELIMITER $$
DROP FUNCTION IF EXISTS busca_más_vendido $$

CREATE FUNCTION busca_más_vendido()
RETURNS VARCHAR(15) DETERMINISTIC
BEGIN

DECLARE resultado VARCHAR(15);

SELECT codigo_producto
INTO resultado
FROM producto
WHERE cant_vend(codigo_producto) = (SELECT MAX(cant_vend(codigo_producto)) FROM producto);

RETURN resultado;

END$$

DELIMITER ;

SET @codigoProducto = cant_vend();
SELECT @codigoProducto;





/*R3. Crea una función llamada responsable que reciba como parámetro de entrada el código de un empleado y devuelva el número de clientes que tiene a su cargo.*/

DELIMITER $$
DROP FUNCTION IF EXISTS responsable $$

CREATE FUNCTION responable(codigoEmpleado INT(11))
RETURNS INT DETERMINISTIC
BEGIN

DECLARE empleados INT(11);

SELECT COUNT(codigo_empleado_rep_ventas) INTO empleados
FROM cliente
WHERE codigo_empleado_rep_ventas = codigoEmpleado;

return empleados;
END$$

DELIMITER ;

SET @empleados = responable(12);
SELECT @empleados;



/*R4. Crea una función llamada cuenta_productos_gama que reciba como parámetro de entrada una gama de productos y devuelva el número de productos de esa gama.*/

DELIMITER $$
DROP FUNCTION IF EXISTS cuenta_productos_gama $$

CREATE FUNCTION cuenta_productos_gama(gamaDada VARCHAR(50))
RETURNS INT DETERMINISTIC
BEGIN

DECLARE productos INT;

SELECT COUNT(codigo_producto) 
INTO productos
FROM producto
WHERE gama = gamaDada;

return productos;
END$$

DELIMITER ;

SELECT cuenta_productos_gama('Frutales');




/*R5. Crea una tabla que se llame productos_vendidos que tenga los siguientes campos

• codigo_producto (cadena de caracteres) PK

• cantidad_total (entero)

Después crea un procedimiento llamado total_productos_vendidos que para cada uno de los productos de la tabla 
producto calcule la cantidad total de unidades que se han vendido y almacene esta información en la tabla.*/

CREATE TABLE productos_vendidos (
producto VARCHAR(15) PRIMARY KEY,
cantidad_total INT(11)
);

DELIMITER $$

DROP PROCEDURE IF EXISTS total_productos_vendidos$$

CREATE PROCEDURE total_productos_vendidos()
BEGIN

DELETE FROM productos_vendidos;

INSERT INTO productos_vendidos 
SELECT codigo_producto, SUM(cantidad)
FROM detalle_pedido
GROUP BY codigo_producto;
 
END$$

DELIMITER ;

call total_productos_vendidos();



/*R6. Crea una base de datos ALUMNOS. A continuación, crea una tabla alumno con los siguientes campos:

id (entero y clave primaria)
nombre (cadena de caracteres)
apellido1 (cadena de caracteres)
apellido2 (cadena de caracteres
fecha_nacimiento (fecha)
Después, inserta 4 registros con datos inventados por ti.

A continuación, añadir una nueva columna a la tabla llamada edad de tipo entero  que será un valor calculado posteriormente a partir de la columna fecha_nacimiento.

Una vez hecho esto:

1. Crear una función llamada calcular_edad que reciba una fecha y devuelva el número de años que han pasado desde la fecha actual hasta la fecha pasada como parámetro:

Función: calcular_edad
Entrada: Fecha
Salida: Número de años (entero)
2. Crear un procedimiento llamado actualizar_edad_tabla que calcule la edad de cada alumno y actualice la tabla. Este procedimiento debe usar la función calcular_edad que hemos creado en el paso anterior.*/

CREATE DATABASE ALUMNOS;
use ALUMNOS;

CREATE TABLE alumno (
id INT(5) PRIMARY KEY,
nombre VARCHAR(20),
apellido1 VARCHAR(20),
apellido2 VARCHAR(20),
fecha_nacimiento DATE
);

INSERT INTO alumno VALUES (1, 'Amancio', 'Morales', 'Gomez', '2017-02-1');
INSERT INTO alumno VALUES (2, 'Roberto', 'Garcia', 'Santos', '2017-08-20');
INSERT INTO alumno VALUES (3, 'Antonio', 'Lopez', 'Martin', '2017-10-10');
INSERT INTO alumno VALUES (4, 'Benito', 'Kamleas', 'García', '2016-05-9');

ALTER TABLE alumno ADD edad INT(2);



DELIMITER $$
DROP FUNCTION IF EXISTS calcular_edad $$

CREATE FUNCTION calcular_edad(fecha DATE)
RETURNS INT DETERMINISTIC
BEGIN

DECLARE numeroDeAños INT;
DECLARE fechaActual DATE;
SET fechaActual = CURDATE();
SET numeroDeAños = (YEAR(fechaActual) - YEAR(fecha));

return numeroDeAños;
END$$

DELIMITER ;


DELIMITER $$

DROP PROCEDURE IF EXISTS actualizar_edad_tabla$$

CREATE PROCEDURE actualizar_edad_tabla()
BEGIN

DECLARE fechaNac DATE;
DECLARE cont INT;
DECLARE numAlum INT;
DECLARE years INT;
SET cont = 1;

SELECT COUNT(*)
COLLECT INTO numAlum
FROM alumno;

WHILE cont <= numAlum DO

SELECT fecha_nacimiento
COLLECT INTO fechaNac
FROM alumno
WHERE id = cont;

SET years = calcular_edad(fechaNac);

UPDATE alumno SET edad = years WHERE id = cont;

SET cont = cont + 1;

END WHILE;
END$$

DELIMITER ;

call actualizar_edad_tabla();



/*R7. Modifica la tabla alumnos del ejercicio anterior para añadir una nueva columna email. 

1.  Una vez que hemos creada necesitamos asignarle una dirección de correo electrónico de forma automática. 
Para ello, crearemos un procedimiento llamado crea_email con los siguientes parámetros:

•Entrada: nombre (cadena de caracteres), apellido1 (cadena de caracteres), apellido2 (cadena de caracteres), dominio (cadena de caracteres).

•Salida: email (cadena de caracteres) . Este email de salida ha de tener el siguiente formato:

•	El primer carácter del nombre.

•	Los tres primeros caracteres del apellido1.

•	Los tres primeros caracteres del apellido2.

•	El carácter @.

•	El dominio pasado como parámetro.

 2.  A continuación, escribe un procedimiento que permita crear un email para todos los alumnos que ya existen en la tabla.
 Para esto será necesario crear un procedimiento llamado actualizar_columna_email que actualice la columna email de la tabla alumnos.
 Este procedimiento hará uso del procedimiento crear_email que hemos creado en el paso anterior.

 3. Por último, escribe un procedimiento llamado crear_lista_emails_alumnos que devuelva la lista de emails de la tabla alumnos separados por un punto y coma. 
 Ejemplo: jdialop@dom.org;mgarber@dom.org;plopsan@dom.org;ldomgom@dom.org.*/

/**/

ALTER TABLE alumno ADD email VARCHAR(100);


DELIMITER $$

DROP PROCEDURE IF EXISTS crea_email$$

CREATE PROCEDURE crea_email(IN nombre VARCHAR(20), IN apellido1 VARCHAR(20), IN apellido2 VARCHAR(20), IN dominio VARCHAR(20), OUT email VARCHAR(100))
BEGIN

SET email = CONCAT(SUBSTRING(nombre, 1, 1), SUBSTRING(apellido1, 1, 3), SUBSTRING(apellido2, 1, 3), '@', dominio);

END$$

DELIMITER ;


DELIMITER $$

DROP PROCEDURE IF EXISTS actualizar_columna_email$$
/*Esta procedimiento no me funciona, no carga los datos en la tabla, yo creo que es como lo he hecho. 
Creo que mi fallo es cuando llamo al procedimiento "crea_email()" que no estoy sacando bien el resultado, pero lo he intentado de toda las formas y no me funciona.*/
CREATE PROCEDURE actualizar_columna_email()
BEGIN

DECLARE fin INT DEFAULT FALSE;
DECLARE cont INT;
DECLARE emailCreado VARCHAR(100);
DECLARE nombre VARCHAR(20);
DECLARE apellido1 VARCHAR(20);
DECLARE apellido2 VARCHAR(20);
DECLARE cur1 CURSOR FOR SELECT id FROM alumno;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;


open cur1;
FETCH cur1 INTO cont;

WHILE NOT fin DO

SELECT nombre
INTO nombre
FROM alumno
WHERE id = cont;

SELECT apellido1
INTO apellido1
FROM alumno
WHERE id = cont;

SELECT apellido2
INTO apellido2
FROM alumno
WHERE id = cont;


call crea_email(nombre, apellido1, apellido2, 'colegio.com', emailCreado);

UPDATE alumno 
SET email = CONCAT(' ', emailCreado) 
WHERE id = cont; 

FETCH cur1 INTO cont;

END WHILE;

CLOSE cur1;
END$$

DELIMITER ;

call actualizar_columna_email();