CREATE DATABASE EMPLEADOS

use EMPLEADOS

CREATE TABLE Provincia (
codProv CHAR(2) PRIMARY KEY,
nomProv VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Localidad (
codLoc CHAR(3) PRIMARY KEY,
nombre VARCHAR(40) NOT NULL,
codProv CHAR(2),
codPostal CHAR(5),
FOREIGN KEY (codProv) REFERENCES Provincia (codProv)
);

CREATE TABLE Delegaciones (
codDg CHAR(5) PRIMARY KEY,
nombre VARCHAR(40) NOT NULL,
direccion VARCHAR(50)
);

CREATE TABLE Departamento (
codDep VARCHAR(5) PRIMARY KEY,
nombre VARCHAR(40),
deLeg CHAR(5),
direc VARCHAR(15),
presupuesto FLOAT(15,2),
depSup VARCHAR(5),
FOREIGN KEY (deLeg) REFERENCES Delegaciones (codDg),
CONSTRAINT depSup_FK FOREIGN KEY (depSup) REFERENCES Departamento (codDep)
);

CREATE TABLE Empleado (
codEmp VARCHAR(15) PRIMARY KEY,
nombre VARCHAR(40) NOT NULL,
direccion VARCHAR(100),
localidad CHAR(3),
tfno VARCHAR(15),
fec_nac DATE,
fec_alta DATE,
salario FLOAT(10,2),
hijos INT(2),
deptno VARCHAR(5),
FOREIGN KEY (localidad) REFERENCES Localidad (codLoc),
FOREIGN KEY (deptno) REFERENCES Departamento (codDep)
);

ALTER TABLE Departamento ADD FOREIGN KEY (direc) REFERENCES Empleado (codEmp) ON DELETE SET NULL;