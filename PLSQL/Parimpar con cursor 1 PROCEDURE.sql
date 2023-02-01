CREATE TABLE ParImpar (
numero INT PRIMARY KEY,
par char(1) DEFAULT ' ', 
impar char(1) DEFAULT ' ');


DELIMITER $$
DROP PROCEDURE IF EXISTS RellenaParImpar $$
CREATE PROCEDURE RellenaParImpar (IN tope INT UNSIGNED)
/* Esta función acepta numeros enteros positivos mayores que cero*/

BEGIN
DECLARE cont, num INT;
DECLARE fin INT DEFAULT FALSE;
DECLARE curPI CURSOR FOR select numero from ParImpar;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

SET cont = 1;

IF tope <= 0 THEN 
    SELECT 'El parámetro de entrada ha de ser un numero positivo mayor que cero';

ELSE
   DELETE FROM ParImpar;
   WHILE cont <= tope DO

     INSERT INTO ParImpar (numero) VALUES (cont);
     SET cont = cont + 1; 

   END WHILE;

   OPEN curPI;


   FETCH curPI INTO num;
   WHILE NOT fin DO
  
      IF MOD(num,2) = 0 THEN
         UPDATE ParImpar SET par = 'X' WHERE numero = num;
      ELSE
         UPDATE ParImpar SET impar = 'X' WHERE numero = num;
      END IF;
      FETCH curPI INTO num;
   END WHILE;
   CLOSE curPI;

END IF;

END $$


