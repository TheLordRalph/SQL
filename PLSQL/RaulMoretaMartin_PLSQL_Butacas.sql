/*Crea una base de datos llamada cine que contenga dos tablas con las siguientes columnas.
Tabla cuentas:

id_cuenta: entero sin signo (clave primaria).
saldo: real sin signo.

Tabla entradas:

id_butaca: entero sin signo (clave primaria).
nif: cadena de 9 caracteres.*/

CREATE DATABASE cine;
use cine;

CREATE TABLE cuentas (
id_cuenta INT(10) UNSIGNED PRIMARY KEY,
saldo DECIMAL(15,2) UNSIGNED DEFAULT 0
);

CREATE TABLE entradas (
id_butaca INT(10) UNSIGNED PRIMARY KEY,
nif VARCHAR(9)
);

/*Una vez creada la base de datos y las tablas crea un procedimiento llamado comprar_entrada con las siguientes características:

El procedimiento recibe tres parámetros de entrada (nif, id_cuenta, id_butaca) 
Devolverá como salida un parámetro llamado error que tendrá un valor igual a 0 si la compra de la entrada se ha podido realizar con éxito y un valor igual a 1 en caso contrario.
El procedimiento de compra realiza los siguientes pasos:

Inicia un bloque BEGIN/END.
Actualiza la columna saldo de la tabla cuentas cobrando 5 euros a la cuenta con el id_cuenta adecuado.
Inserta una una fila en la tabla entradas indicando la butaca (id_butaca) que acaba de comprar el usuario (nif).
Comprueba si ha ocurrido algún error en las operaciones anteriores. Si no ocurre ningún error entonces aplica un COMMIT y si ha ocurrido algún error aplica un ROLLBACK.

Además, debe gestionar los siguientes errores que puedan ocurrir durante el proceso.

ERROR 1264 (Out of range value): se produce cuando estás intentando insertar un valor en una columna que excede el rango del tipo de datos.
ERROR 1062 (Duplicate entry for PRIMARY KEY)
3. Responde a las preguntas:
¿Qué ocurre cuando intentamos comprar una entrada y le pasamos como parámetro un número de cuenta que no existe en la tabla cuentas? ¿Ocurre algún error o podemos comprar la entrada?
En caso de que exista algún error, ¿Cómo podríamos resolverlo?*/


/*El procedimiento funciona, en caso de error hará un rollback dejando los datos como estaban, y si ves las salida @error indicara 1 en caso de que hubiera hecho rollback el procedimiento.*/

DELIMITER $$

DROP PROCEDURE IF EXISTS comprar_entrada$$
CREATE PROCEDURE comprar_entrada(IN nif VARCHAR(9), IN idCuenta VARCHAR(15), IN idButaca INT(10), OUT error int(2))
BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SET error = 1;
END;

DECLARE EXIT HANDLER FOR SQLWARNING
BEGIN
ROLLBACK;
SET error = 1;
END;

DECLARE EXIT HANDLER FOR 1264
BEGIN
ROLLBACK;
SET error = 1;
END;

DECLARE EXIT HANDLER FOR 1062
BEGIN
ROLLBACK;
SET error = 1;
END;

SET error = 0;
IF (idCuenta = (SELECT id_cuenta from cuentas WHERE id_cuenta = idCuenta)) && ((SELECT saldo FROM cuentas WHERE id_cuenta = idCuenta) >= 5) THEN

UPDATE cuentas SET saldo = saldo - 5 WHERE id_cuenta = idCuenta;
INSERT INTO entradas VALUES(idButaca, nif);

ELSE

SET error = 1;

END IF;

END$$

DELIMITER ;

INSERT INTO cuentas VALUES(1, 30);
INSERT INTO cuentas VALUES(2, 100);
INSERT INTO cuentas VALUES(3, 60);
INSERT INTO cuentas VALUES(4, 10);
INSERT INTO cuentas VALUES(5, 5);
INSERT INTO cuentas VALUES(6, 2);

call comprar_entrada('11111111B', 1, 01, @error);
call comprar_entrada('22222222A', 2, -02 , @error);
call comprar_entrada('33333333E', 5, 15 , @error);
call comprar_entrada('44444444A', 6, 10 , @error);


