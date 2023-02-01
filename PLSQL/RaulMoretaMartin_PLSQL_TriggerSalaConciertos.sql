/*
Una sala de conciertos quiere gestionar las notificaciones sobre los espectáculos mediante un conjunto de triggers.

Dado el siguiente modelo de datos:

CLIENTE (idCliente, nombre, email) 

CLIENTEINTERES (idCliente, idInteres)

INTERES (idInteres, descripcion)

ESPECTACULO (idEsp, Nombre, Fecha, HoraInicio ) 

ESPECINTERES (idEsp, IdInteres )

ENTRADAS (idCliente, IdEsp, nasientos) "asientos > 0"


Los clientes del sitio web de esta sala pueden crear una cuenta y registrar un conjunto de que coincidan sus intereses. 

Cuando se crea (inserta) un nuevo espectáculo en el sitio web, se asocia también a unos intereses. Los clientes que tengan en sus intereses alguno de los que está asociado a ese espectáculo, recibirán un email notificándoles que hay un nuevo espectáculo que podría interesarle y algunos de ellos comprarán entradas para el mismo. 

En el caso de que haya una cancelación (borrado) de un espectáculo o un cambio en la hora de inicio, se envía una notificación a los clientes que compraron entradas para el espectáculo afectado. 

Crea los triggers necesarios para manejar las actividades cuando se inserta un nuevo espectáculo y cuando se cancela/cambia de horario.

Para hacerlo, supondremos que disponemos de una función llamada envia_email con los parámetros:

* email del destinatario / lista de emails separada por ;

* identificador del espectáculo.

* motivo notificación ('nuevo', 'anulación', 'cambiohora')

Esta función 'construye' el email con los datos facilitados y lo envía.
*/


--Creo una tabla que almacenara todos los emails que se envian a los usuarios.
--Para comprobar en el trigger si un usuario ya ha recibido el email y no se vuelva a enviar

emails_enviados (email_Cliente, idEsp, motivo)


-- Creo un trigger despues de insertar en ESPECINTERES, porque si lo hiciesemos despues de insertar un espectaculo,
-- al no tener todavia intereses enlacados con el espectaculo nunca enviara emails. Por eso, ejecuto el trigger despues de agregar
-- los intereses, para cada interes de espectaculo que se inserta revisara cada cliente, y si tiene el mismo interes revisara si se ha enviado
-- un email en la tabla que hemos creado, en caso de no haber ningun email, le enviaria el email.
DELIMITER $$

DROP TRIGGER IF EXISTS Insert_Espectaculo$$

CREATE TRIGGER Insert_Espectaculo
AFTER INSERT ON ESPECINTERES FOR EACH ROW
BEGIN

DECLARE fin INT DEFAULT FALSE;
DECLARE email_C VARCHAR;
DECLARE idC INT;
DECLARE idIn_C INT;
DECLARE cur1 CURSOR FOR SELECT idCliente, idInteres FROM CLIENTEINTERES;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

OPEN cur1;
FETCH cur1 INTO idC, idIn_C;

WHILE fin = FALSE DO

SELECT email
INTO email_C
FROM CLIENTE
WHERE idCliente = idC;


IF (idIn_C = (SELECT idInteres FROM CLIENTEINTERES WHERE idCliente = idC)) && (email_C NOT IN (SELECT email_Cliente FROM emails_enviados WHERE idEsp = NEW.idEsp AND motivo = 'nuevo' AND email_Cliente = email_C)) THEN

SELECT envia_email(email_C, NEW.idEsp, 'nuevo');
INSERT INTO emails_enviados VALUES(email_C, NEW.idEsp, 'nuevo');

END IF;

FETCH cur1 INTO idC, idIn_C;

END WHILE;
CLOSE cur1;
END$$

DELIMITER ;



DELIMITER $$

DROP TRIGGER IF EXISTS Delete_Espectaculo$$

CREATE TRIGGER Delete_Espectaculo
AFTER DELETE ON ESPECTACULO FOR EACH ROW
BEGIN

DECLARE fin INT DEFAULT FALSE;
DECLARE email_C VARCHAR;
DECLARE idC INT;
DECLARE cur1 CURSOR FOR SELECT idCliente FROM ENTRADAS;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

OPEN cur1;
FETCH cur1 INTO idC;

WHILE fin = FALSE DO

SELECT email
INTO email_C
FROM CLIENTE
WHERE idCliente = idC;

DELETE FROM ESPECINTERES WHERE IdEsp = OLD.IdEsp;

IF (email_C = (SELECT email_Cliente FROM emails_enviados WHERE email_Cliente = email_C AND idEsp = OLD.idEsp AND motivo = 'nuevo')) && (email_C NOT IN (SELECT email_Cliente FROM emails_enviados WHERE email_Cliente = email_C AND idEsp = OLD.idEsp AND motivo = 'anulación')) THEN

SELECT envia_email(email_C, OLD.idEsp, 'anulación');
INSERT INTO emails_enviados VALUES(email_C, OLD.idEsp, 'anulación');

DELETE FROM ENTRADAS WHERE idCliente = idC AND IdEsp = OLD.IdEsp;

END IF;

END WHILE;

CLOSE cur1;
END$$

DELIMITER ;



DELIMITER $$

DROP TRIGGER IF EXISTS Update_Espectaculo$$

CREATE TRIGGER Update_Espectaculo
AFTER UPDATE ON ESPECTACULO FOR EACH ROW
BEGIN

DECLARE fin INT DEFAULT FALSE;
DECLARE email_C VARCHAR;
DECLARE idC INT;
DECLARE cur1 CURSOR FOR SELECT idCliente FROM ENTRADAS;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

OPEN cur1;
FETCH cur1 INTO idC;

WHILE fin = FALSE DO

SELECT email
INTO email_C
FROM CLIENTE
WHERE idCliente = idC;

IF (email_C = (SELECT email_Cliente FROM emails_enviados WHERE email_Cliente = email_C AND idEsp = OLD.idEsp AND motivo = 'nuevo')) THEN

SELECT envia_email(email_C, OLD.idEsp, 'cambiohora');
INSERT INTO emails_enviados VALUES(email_C, OLD.idEsp, 'cambiohora');

END IF;

FETCH cur1 INTO idC;

END WHILE;
CLOSE cur1;
END$$

DELIMITER ;