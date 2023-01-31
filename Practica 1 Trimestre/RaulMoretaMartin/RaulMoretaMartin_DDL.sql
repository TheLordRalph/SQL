CREATE DATABASE PIZZERIA;

use PIZZERIA;

CREATE TABLE Cliente (
codCliente VARCHAR(6) PRIMARY KEY,
nombre VARCHAR(40),
apellido VARCHAR(50),
direccion VARCHAR(60),
telefono INT(15),
mail VARCHAR(50)
);

CREATE TABLE Ingrediente (
codIngrediente VARCHAR(3) PRIMARY KEY,
descripcion VARCHAR(15),
precio INT(3) NOT NULL
);

CREATE TABLE Pedido (
codPedido VARCHAR(6) PRIMARY KEY,
fecha DATE NOT NULL,
domicilio BOOLEAN NOT NULL,
codCliente VARCHAR(6)NOT NULL,
nPizzas INT(3),
importe INT(3),
FOREIGN KEY (codCliente) REFERENCES Cliente(codCliente)
);

CREATE TABLE Pedido_Ingrediente (
codLinea VARCHAR(9) PRIMARY KEY,
codPedido VARCHAR(6),
tipo VARCHAR(10) NOT NULL,
codIngrediente VARCHAR(3),
cantidadEx INT(2),
FOREIGN KEY (codPedido) REFERENCES Pedido(codPedido),
FOREIGN KEY (codIngrediente) REFERENCES Ingrediente(codIngrediente),
CHECK (tipo IN ('margarita','barbacoa','carbonara','al gusto'))
);



