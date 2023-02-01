Crea una tabla que se llame Cuadrados con dos columnas de tipo entero : número y cuadrado. 


Una vez creada, crea un procedimiento llamado calcula_cuadrado que reciba de entrada un número entero (tope). 
El procedimiento debe calcular los cuadrados de los números empezando por el 1 y acabando en el número tope, 
este último incluido.

Si la tabla está llena, el procedimiento debe vaciarla previamente a hacer las inserciones.

Proceso: 

1. Borrado de la tabla.
2. Rellenar la columna número hasta tope.

El:  calcula_cuadrado (4)

numero          cuadrado

1                  

2                  

3                  

4                  

3. Procedimiento que rellene la columna cuadrado, a partir de la columna numero.

El:  calcula_cuadrado (4)

numero          cuadrado

1                     1

2                     4

3                     9

4                     16

DELIMITER $$

CREATE PROCEDURE rellena_numero (IN tope INT)
BEGIN

declare cont int;

delete from CUADRADOS;

set cont = 1;
while cont <= tope do
	insert into CUADRADOS (numero) values (cont);
	set cont = cont + 1;
end while;

END$$

CREATE PROCEDURE act_cuadrado ()
BEGIN
DECLARE fin INT DEFAULT FALSE;
DECLARE v1 INT;
DECLARE curC CURSOR FOR select numero from CUADRADOS;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

OPEN curC;

FETCH curC INTO v1;

WHILE NOT fin DO

UPDATE CUADRADOS SET cuadrado = v1*v1 WHERE numero = v1;
FETCH curC INTO v1;

END WHILE;

CLOSE curC;

END$$


CREATE PROCEDURE calcula_cuadrado_cursor (IN tope INT)
BEGIN
	call rellena_numero(tope);
	call act_cuadrado;
END $$

