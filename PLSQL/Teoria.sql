CREATE DATABASE bdejtrans;
USE bdejtrans;

CREATE table fichero_transferencia(
id INT UNSIGNED PRIMARY KEY,
id_tr INT UNSIGNED,
fecha_tr DATETIME,
cta_orig VARCHAR(20),
cta_dest VARCHAR(20),
importe FLOAT(15,2));


CREATE table cuenta(
id_cta VARCHAR(20) PRIMARY KEY,
cliente VARCHAR(50));


CREATE table transferencia(
id_tr INT UNSIGNED PRIMARY KEY,
fecha_tr DATETIME);


CREATE table movimiento
(id_mv VARCHAR(10) PRIMARY KEY,
 fecha_mv DATETIME,
 id_tran INT UNSIGNED,
 cuenta VARCHAR(20),
 imp FLOAT(15, 2),
 FOREIGN KEY (id_tran) REFERENCES transferencia(id_tr) ON DELETE CASCADE,
 FOREIGN KEY (cuenta) REFERENCES cuenta(id_cta) ON DELETE CASCADE);
 
 
 
 insert into cuenta VALUES ('ESOOOOOOOO', 'Cliente 1');
 insert into cuenta VALUES ('ESDDDDDDDD', 'Cliente 2');
 
  INSERT INTO fichero_transferencia VALUES (1, 1, SYSDATE(), 'ESOOOOOOOO', 'ESDDDDDDDD', 1000);
 INSERT INTO fichero_transferencia VALUES (2, 2, SYSDATE(), 'ESOOOOOOOO', 'ESDDDDDDD1', 2000);
 INSERT INTO fichero_transferencia VALUES (3, 3, SYSDATE(), 'ESOOOOOOOO', 'ESDDDDDDDD', 3000);
 INSERT INTO fichero_transferencia VALUES (4, 3, SYSDATE(), 'ESOOOOOOO1', 'ESDDDDDDDD', 3000);
 
 
 
 
 DELIMITER $$
DROP PROCEDURE IF EXISTS InsertaTransferencia$$
CREATE PROCEDURE InsertaTransferencia (OUT error VARCHAR(100))
BEGIN
DECLARE vid, vidtr INT UNSIGNED;
DECLARE vfetr DATE;
DECLARE ctor,ctde VARCHAR(20);
DECLARE cant FLOAT(15,2);
DECLARE fin INT DEFAULT FALSE;
DECLARE curtr CURSOR FOR SELECT * from fichero_transferencia;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;
SET error = 'Todo OK';
OPEN curtr;
FETCH curtr INTO vid, vidtr, vfetr, ctor, ctde, cant;
WHILE NOT fin DO

 INSERT INTO transferencia VALUES (vidtr, vfetr);
INSERT INTO movimiento VALUES (CONCAT(vidtr, '_S'), SYSDATE(), vidtr, ctor, (-1)*cant);
INSERT INTO movimiento VALUES (CONCAT(vidtr, '_E'), SYSDATE(), vidtr, ctde, cant);
COMMIT;
FETCH curtr INTO vid, vidtr, vfetr, ctor, ctde, cant;
END WHILE;
CLOSE curtr;
END $$
call InsertaTransferencia (@error);
select @error;

select * from fichero_transferencia;
 select * from cuenta;
 select * from transferencia;
 select * from movimiento;
 
 delete from transferencia;
 delete from movimiento;
 
 DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
	   GET DIAGNOSTICS CONDITION 1
	    @code = RETURNED_SQLSTATE, @msg = MESSAGE_TEXT, @errno = MYSQL_ERRNO;
	   select @code, @errno, @msg;
	   ROLLBACK;
    END;

CREATE table log_fichero_transferencia(
idlog INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id INT UNSIGNED,
error_code VARCHAR(10),
error_no VARCHAR(10),
error_text VARCHAR(200));
 