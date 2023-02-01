/* Dado el siguiente modelo relacional sobre PARTIDOS:

  JUGADOR ( IdJugador, Nombre, Equipo, Altura, Fecha_Nac, PartidosJugados)

  ARBITRO ( IdArbitro, Nombre)

  EQUIPO ( IdEquipo, Entrenador, PartidosGanados)

  PARTIDO ( IdPartido, Fecha, IdEquipo1, IdEquipo2, GolesEq1, GolesEq2, IdArbitro )

  JUGADOR_PARTIDO ( IdPartido, IdJugador, Posición, Goles ) */

DROP DATABASE IF EXISTS PARTIDOS;
CREATE DATABASE PARTIDOS;
USE PARTIDOS;


CREATE TABLE JUGADOR (
IdJugador VARCHAR(15) PRIMARY KEY,
Nombre VARCHAR(30) NOT NULL,
Equipo INT(10),
Altura DOUBLE(10,5),
Fecha_Nac DATE,
PartidosJugados INT(5) DEFAULT 0,
FOREIGN KEY (Equipo) REFERENCES EQUIPO(IdEquipo)
);

CREATE TABLE ARBITRO (
IdArbitro VARCHAR(10) PRIMARY KEY,
Nombre VARCHAR(50) NOT NULL
);

CREATE TABLE EQUIPO (
IdEquipo INT(10) PRIMARY KEY,
Entrenador VARCHAR(20) NOT NULL,
PartidosGanados INT(20) DEFAULT 0
);


CREATE TABLE PARTIDO (
IdPartido VARCHAR(15) PRIMARY KEY,
Fecha DATE,
IdEquipo1 INT(10),
IdEquipo2 INT(10),
GolesEq1 INT(5),
GolesEq2 INT(5),
IdArbitro VARCHAR(10),
FOREIGN KEY (IdEquipo1) REFERENCES EQUIPO(IdEquipo),
FOREIGN KEY (IdEquipo2) REFERENCES EQUIPO(IdEquipo),
FOREIGN KEY (IdArbitro) REFERENCES ARBITRO(IdArbitro)
);

CREATE TABLE JUGADOR_PARTIDO (
IdPartido VARCHAR(15),
IdJugador VARCHAR(15),
Posición VARCHAR(10),
Goles INT(10),
FOREIGN KEY (IdPartido) REFERENCES PARTIDO(IdPartido),
FOREIGN KEY (IdJugador) REFERENCES JUGADOR(IdJugador),
PRIMARY KEY (IdPartido, IdJugador)
);




/* 1.  Crea un trigger que actualice el valor de PartidosGanados después de las inserciones en PARTIDO, teniendo en cuenta que PartidosGanados acumula toda historia del equipo, no solo al torneo actual, y que un equipo gana un juego cuando marca más goles que el otro.

2.  Crea otro trigger que actualice el campo PartidosJugados de JUGADOR de forma que se actualice cada vez que se inserte un registro en JUGADOR_PARTIDO. */


DELIMITER $$

DROP TRIGGER IF EXISTS act_PartidosGanados$$

CREATE TRIGGER act_PartidosGanados
AFTER INSERT ON PARTIDO FOR EACH ROW
BEGIN

IF NEW.GolesEq1 > NEW.GolesEq2 THEN
UPDATE EQUIPO SET PartidosGanados = (PartidosGanados + 1) WHERE IdEquipo = NEW.IdEquipo1;
ELSE
UPDATE EQUIPO SET PartidosGanados = (PartidosGanados + 1) WHERE IdEquipo = NEW.IdEquipo2;
END IF;

END$$

DELIMITER ;




DELIMITER $$

DROP TRIGGER IF EXISTS act_PartidosJugados$$

CREATE TRIGGER act_PartidosJugados
AFTER INSERT ON JUGADOR_PARTIDO FOR EACH ROW
BEGIN

UPDATE JUGADOR SET PartidosJugados = (PartidosJugados + 1) WHERE IdJugador = NEW.IdJugador;

END$$

DELIMITER ;