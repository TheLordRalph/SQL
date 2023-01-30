CREATE DATABASE BIBLIOTECA;

use BIBLIOTECA

CREATE TABLE Editorial(
codEditorial CHAR(2) PRIMARY KEY,
nombre VARCHAR(20) NOT NULL,
direccion VARCHAR(50),
telefono INT(9)
);

CREATE TABLE Socio(
codSocio CHAR(4) PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
direccion VARCHAR(50),
telefono INT(9)
);

CREATE TABLE Tema (
codTema CHAR(3) PRIMARY KEY,
nombre VARCHAR(20) NOT NULL
);

CREATE TABLE Autor (
codAutor CHAR(3) PRIMARY KEY,
nombre VARCHAR(30) NOT NULL
);

CREATE TABLE Libro (
codLibro CHAR(8) PRIMARY KEY,
titulo VARCHAR(30) NOT NULL,
idioma VARCHAR(25),
formato VARCHAR(20),
codEditorial CHAR(2),
FOREIGN KEY (codEditorial) REFERENCES Editorial (codEditorial)
);

CREATE TABLE TrataSobre (
codLibro CHAR(8),
codTema CHAR(3),
FOREIGN KEY (codLibro) REFERENCES Libro (codLibro),
FOREIGN KEY (codTema) REFERENCES Tema (codTema),
PRIMARY KEY (codLibro, codTema)
);

CREATE TABLE EscritoPor (
codLibro CHAR(8),
codAutor CHAR(3),
FOREIGN KEY (codLibro) REFERENCES Libro (codLibro),
FOREIGN KEY (codAutor) REFERENCES Autor (codAutor),
PRIMARY KEY (codLibro, codAutor)
);

CREATE TABLE Ejemplar (
codEjemplar CHAR(10) PRIMARY KEY,
codLibro CHAR(8),
numeroEjemplar VARCHAR(5),
edicion VARCHAR(15),
ubicacion VARCHAR(30),
categoria VARCHAR(20),
FOREIGN KEY (codLibro) REFERENCES Libro (codLibro)
);

CREATE TABLE Prestamo (
codPrestamo CHAR(10) PRIMARY KEY,
codSocio CHAR(4),
codEjemplar CHAR(10),
numeroOrden INT(5),
fechaPrestamo DATE NOT NULL,
fechaDevolucion DATE,
notas VARCHAR(50),
FOREIGN KEY (codSocio) REFERENCES Socio (codSocio),
FOREIGN KEY (codEjemplar) REFERENCES Ejemplar (codEjemplar) 
);