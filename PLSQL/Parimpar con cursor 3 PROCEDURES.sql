DELIMITER $$

DROP PROCEDURE IF EXISTS rellena_num_PI$$
CREATE PROCEDURE rellena_num_PI (IN tope INT)
BEGIN
DECLARE cont INT;

SET cont = 1;

DELETE FROM ParImpar;

WHILE cont <= tope DO

  INSERT INTO ParImpar (numero) VALUES (cont);
  SET cont = cont + 1; 

END WHILE;

END $$

DROP PROCEDURE IF EXISTS act_parimpar()$$
CREATE PROCEDURE act_parimpar()
BEGIN

DECLARE num INT;
DECLARE fin INT DEFAULT FALSE;
DECLARE curPI CURSOR FOR select numero from ParImpar;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

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

END $$


DROP PROCEDURE IF EXISTS Rellena_ParImpar_Mod $$
CREATE PROCEDURE Rellena_ParImpar_Mod (IN tope INT UNSIGNED)
/* Esta función acepta numeros enteros positivos*/
BEGIN 

  CALL rellena_num_PI(tope); 
  CALL act_parimpar();

END $$
