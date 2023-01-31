SELECT codPedido, domicilio FROM Pedido WHERE domicilio = true;

SELECT codPedido, tipo, codIngrediente, cantidadEx 
FROM Pedido_Ingrediente 
WHERE codPedido = (SELECT codPedido FROM Pedido WHERE (Pedido.domicilio = true) AND (Pedido.codCliente = 'C00002'));

SELECT SUM(CASE Pedido_Ingrediente.cantidadEx WHEN 1 THEN Ingrediente.precio*2 ELSE Ingrediente.precio END) AS 'Importe de la Pizza' 
FROM Pedido_Ingrediente, Ingrediente
WHERE tipo='barbacoa' AND codPedido='P00004' AND Ingrediente.codIngrediente=Pedido_Ingrediente.codIngrediente;

SELECT COUNT(DISTINCT codPedido) AS 'Pizzas Al Gusto'
FROM Pedido_Ingrediente
WHERE tipo='al gusto';

SELECT Cliente.nombre, SUM(Pedido.importe) 
FROM Pedido, Cliente 
WHERE Pedido.codCliente=Cliente.codCliente 
GROUP BY Cliente.nombre;