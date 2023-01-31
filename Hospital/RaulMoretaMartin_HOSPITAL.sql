CREATE DATABASE HOSPITAL;

use HOSPITAL

CREATE TABLE Direccion (
codDir CHAR(3) PRIMARY KEY,
poblacion VARCHAR(15),
provincia VARCHAR(15),
codPostal CHAR(10) NOT NULL
);

CREATE TABLE Paciente (
codigo CHAR(5) PRIMARY KEY,
nombre VARCHAR(10) NOT NULL,
apellidos VARCHAR(10) NOT NULL,
direccion VARCHAR(15),
telefono INT(9),
fecNac DATE,
codDir CHAR(3),
FOREIGN KEY (codDir) REFERENCES Direccion (codDir)
);

CREATE TABLE Plaza ( 
codPz CHAR(5) PRIMARY KEY,
habitacion VARCHAR(12) NOT NULL,
cama VARCHAR(5)
);

CREATE TABLE Especialidades (
codEsp CHAR(4) PRIMARY KEY,
especialidad VARCHAR(18) NOT NULL
);

CREATE TABLE Medico (
codigo CHAR(10) PRIMARY KEY,
nombre VARCHAR(20) NOT NULL,
apellidos VARCHAR(30) NOT NULL,
telefono INT(9),
codEsp CHAR(4),
FOREIGN KEY (codEsp) REFERENCES Especialidades (codEsp)
);

CREATE TABLE Ingreso (
codigo CHAR(10) PRIMARY KEY,
fecha DATE,
codMed CHAR(10),
codPac CHAR(5),
codPz CHAR(5),
FOREIGN KEY (codMed) REFERENCES Medico (codigo),
FOREIGN KEY (codPac) REFERENCES Paciente (codigo),
FOREIGN KEY (codPz) REFERENCES Plaza (codPz)
);

CREATE TABLE Med_Esp (
codMed CHAR(10),
codEsp CHAR(4),
FOREIGN KEY (codMed) REFERENCES Medico (codigo),
FOREIGN KEY (codEsp) REFERENCES Especialidades (codEsp),
CONSTRAINT MED_ESP PRIMARY KEY (codMed, codEsp)
);