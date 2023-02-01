/* Dado el siguiente modelo relacional sobre BECAS:

SOLICITUD (IdAlumno, Fecha, Estado)

CURSO (IdCurso, Nombre, Creditos)

CLASIFICACION (IdAlumno, Media, Creditos, Posicion)

EXAMEN (IdCurso, IdAlumno, Fecha, Nota) */ 

DROP DATABASE IF EXISTS BECAS;
CREATE DATABASE BECAS;
USE BECAS;


CREATE TABLE SOLICITUD (
IdAlumno VARCHAR(15),
Fecha DATE,
Estado VARCHAR(15),
PRIMARY KEY (IdAlumno, Fecha)
);

CREATE TABLE CURSO (
IdCurso VARCHAR(10) PRIMARY KEY,
Nombre VARCHAR(50),
Creditos INT(10)
);

CREATE TABLE CLASIFICACION (
IdAlumno VARCHAR(15) PRIMARY KEY,
Media VARCHAR(20),
Creditos INT(10),
Posicion INT(10)
);


CREATE TABLE EXAMEN (
IdCurso VARCHAR(15),
IdAlumno VARCHAR(15),
Fecha DATE,
Nota INT(10),
PRIMARY KEY (IdCurso, IdAlumno, Fecha)
);

INSERT INTO CURSO VALUES('C01', 'Matematicas', 30);
INSERT INTO CURSO VALUES('C02', 'Literatura', 10);
INSERT INTO CURSO VALUES('C03', 'Historia', 20);
INSERT INTO CURSO VALUES('C04', 'Informatica', 40);
INSERT INTO CURSO VALUES('C05', 'Fisica', 10);

INSERT INTO EXAMEN VALUES('C02', 'A01', "2020-08-10", 9);
INSERT INTO EXAMEN VALUES('C03', 'A01', "2020-09-20", 9);
INSERT INTO EXAMEN VALUES('C01', 'A01', "2020-10-30", 10);

INSERT INTO EXAMEN VALUES('C04', 'A02', "2020-12-14", 10);

INSERT INTO SOLICITUD (IdAlumno, Fecha) VALUES('A01', "2021-02-04");
INSERT INTO SOLICITUD (IdAlumno, Fecha) VALUES('A02', "2021-02-04");


/* Queremos gestionar mediante un sistema de triggers la concesión de becas a los estudiantes.

Las becas se otorgan a los estudiantes que las soliciten y que, a la fecha de la solicitud, hayan realizado exámenes por un total de al menos 50 créditos, 
y con una puntuación media de al menos 9.

Si no se cumplen los requisitos, la solicitud se rechaza automáticamente; de lo contrario se acepta. En ambos casos, el valor de la columna Estado en SOLICITUD 
(que inicialmente es NULO), se cambia respectivamente a "rechazado" o "aceptado".

En caso de que se acepte, al estudiante se le asigna automáticamente un puesto en la clasificación, que viene determinada por la media de las calificaciones. 
En caso de que haya dos estudiantes con la misma media, se considerará primero al que mayor número de créditos haya acumulado hasta la fecha de solicitud y si también coincide, 
se mirará el orden de llegada de la solicitud.

Si un estudiante renuncia a la beca (el estado se cambia a "abandono"), la clasificación se actualizará eliminando al estudiante de la misma.

Actualiza las columnas en SOLICITUD  y CLASIFICACIÓN después de la inserción y eliminación de SOLICITUDES. */


----
--
-- FUNCIONES Y PROCEDIMIENTOS
--
----


DELIMITER $$

DROP FUNCTION IF EXISTS Creditos_Examen_Ant_Solicitud$$
--la sigiente funcion nos dará la suma de los creditos de un alumno en la fecha anterior a la solicitud. Funciona correctamente.
CREATE FUNCTION Creditos_Examen_Ant_Solicitud(Alumno VARCHAR(15), FechaSolc DATE)
RETURNS INT NOT DETERMINISTIC
BEGIN

DECLARE fin INT DEFAULT FALSE;
DECLARE curso VARCHAR(10);
DECLARE totalCreditos INT(10);
DECLARE contCreditos INT(10);
DECLARE cur1 CURSOR FOR SELECT IdCurso FROM EXAMEN;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

SET totalCreditos = 0;

open cur1;
FETCH cur1 INTO curso;

WHILE fin = FALSE DO

IF (Alumno = (SELECT IdAlumno FROM EXAMEN WHERE IdCurso = curso)) && (FechaSolc >= (SELECT Fecha FROM EXAMEN WHERE IdCurso = curso)) THEN

SELECT Creditos
INTO contCreditos
FROM CURSO
WHERE IdCurso = curso;

SET totalCreditos = totalCreditos + contCreditos;

END IF;

FETCH cur1 INTO curso;
END WHILE;

CLOSE cur1;
RETURN totalCreditos;
END$$

DELIMITER ;




DELIMITER $$

DROP FUNCTION IF EXISTS Media_Examen_Ant_Solicitud$$
--Esta funcion nos dará la media de las notas de los examenes que ha tenido un alumno antes de la fecha de la solicitud.
CREATE FUNCTION Media_Examen_Ant_Solicitud(Alumno VARCHAR(15), FechaSolc DATE)
RETURNS DECIMAL NOT DETERMINISTIC
BEGIN

DECLARE mediaNotas DECIMAL(15,2);

SELECT AVG(nota) 
INTO mediaNotas
FROM EXAMEN 
WHERE IdAlumno = Alumno AND Fecha <= FechaSolc;

RETURN mediaNotas;
END$$

DELIMITER ;



--Procedimiento que nos dara la posicion del alumno y modificara las posiviones de los demas alumnos
DELIMITER $$

DROP PROCEDURE IF EXISTS posi_clasificacion$$

CREATE PROCEDURE posi_clasificacion(IN Alumno VARCHAR(15), IN FechaSolc DATE, OUT posicion INT(10))
BEGIN

DECLARE fin INT DEFAULT FALSE;
DECLARE alumno VARCHAR(15);
DECLARE PosicionEncontrada BOOLEAN DEFAULT FALSE;
DECLARE cur1 CURSOR FOR SELECT IdAlumno FROM CLASIFICACION;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;


open cur1;
FETCH cur1 INTO alumno;

WHILE PosicionEncontrada = FALSE DO

IF ((SELECT Media_Examen_Ant_Solicitud(Alumno, FechaSolc)) > (SELECT Media FROM CLASIFICACION WHERE IdAlumno = alumno)) THEN

SET posicion = (SELECT Posicion FROM CLASIFICACION WHERE IdAlumno = alumno);
UPDATE CLASIFICACION SET Posicion = Posicion + 1 WHERE IdAlumno = alumno;
SET PosicionEncontrada = TRUE;

ELSEIF ((SELECT Media_Examen_Ant_Solicitud(Alumno, FechaSolc)) = (SELECT Media FROM CLASIFICACION WHERE IdAlumno = alumno)) THEN
IF ((SELECT Creditos_Examen_Ant_Solicitud(Alumno, FechaSolc)) > (SELECT Creditos FROM CLASIFICACION WHERE IdAlumno = alumno)) THEN

SET posicion = (SELECT Posicion FROM CLASIFICACION WHERE IdAlumno = alumno);
UPDATE CLASIFICACION SET Posicion = Posicion + 1 WHERE IdAlumno = alumno;
SET PosicionEncontrada = TRUE;

ELSEIF ((SELECT Creditos_Examen_Ant_Solicitud(Alumno, FechaSolc)) = (SELECT Creditos FROM CLASIFICACION WHERE IdAlumno = alumno)) THEN
IF ((SELECT Fecha FROM SOLICITUD WHERE IdAlumno = Alumno) > (SELECT Fecha FROM SOLICITUD WHERE IdAlumno = alumno)) THEN

SET posicion = (SELECT Posicion FROM CLASIFICACION WHERE IdAlumno = alumno);
UPDATE CLASIFICACION SET Posicion = Posicion + 1 WHERE IdAlumno = alumno;
SET PosicionEncontrada = TRUE;

END IF;
END IF;
END IF;

FETCH cur1 INTO alumno;
END WHILE;

WHILE PosicionEncontrada = TRUE DO

UPDATE CLASIFICACION SET Posicion = Posicion + 1 WHERE IdAlumno = alumno;

FETCH cur1 INTO alumno;
END WHILE;

CLOSE cur1;
END$$

DELIMITER ;




----
--
-- TRIGGERS
--
----


DELIMITER $$
--El trigger funciona correctamente. Y asigna aceptada o rechazada a la solicitud si cumple con los requisitos.
DROP TRIGGER IF EXISTS act_estado_solicitud$$

CREATE TRIGGER act_estado_solicitud
BEFORE INSERT ON SOLICITUD FOR EACH ROW
BEGIN

IF (50 <= (SELECT Creditos_Examen_Ant_Solicitud(NEW.IdAlumno, NEW.Fecha))) && (9 <= (SELECT Media_Examen_Ant_Solicitud(NEW.IdAlumno, NEW.Fecha))) THEN

SET NEW.Estado = 'aceptado';

ELSE

SET NEW.Estado = 'rechazado';

END IF;
END$$

DELIMITER ;


--Este trigger no funciona creo que falla a la hora de asignar la posicion mediante el procedimiento.

DELIMITER $$

DROP TRIGGER IF EXISTS act_puesto_clasificacion$$

CREATE TRIGGER act_puesto_clasificacion
AFTER INSERT ON SOLICITUD FOR EACH ROW
BEGIN

DECLARE posicion INT;

IF (NEW.Estado = 'aceptado') && ((SELECT * FROM CLASIFICACION) IS NULL) THEN

INSERT INTO CLASIFICACION VALUES(NEW.IdAlumno, (SELECT Media_Examen_Ant_Solicitud(NEW.IdAlumno, NEW.Fecha)), (SELECT Creditos_Examen_Ant_Solicitud(NEW.IdAlumno, NEW.Fecha)), 1);

ELSEIF (NEW.Estado = 'aceptado') THEN

call posi_clasificacion(NEW.IdAlumno, NEW.Fecha, posicion);
INSERT INTO CLASIFICACION VALUES(NEW.IdAlumno, (SELECT Media_Examen_Ant_Solicitud(NEW.IdAlumno, NEW.Fecha)), (SELECT Creditos_Examen_Ant_Solicitud(NEW.IdAlumno, NEW.Fecha)), posicion);

END IF;

END$$

DELIMITER ;
