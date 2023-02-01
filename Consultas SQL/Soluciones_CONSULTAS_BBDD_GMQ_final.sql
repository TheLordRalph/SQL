/* 1.1 */
select codigo_oficina, ciudad 
from oficina;
/* 1.2 */
select ciudad, telefono
from oficina where pais='España';
/* 1.3 */
select nombre, apellido1, apellido2 
from empleado 
where codigo_jefe=7;
/* 1.4 */
select nombre, apellido1, apellido2 
from empleado 
where codigo_jefe is null;
/* 1.5 */
select nombre, apellido1, apellido2, puesto 
from empleado 
where puesto not like 'Representante Ventas';
/* 1.6 */
select nombre_cliente 
from cliente 
where pais like 'Spain';
/* 1.7 */
select distinct estado 
from pedido;
/* 1.8.1 */
select codigo_cliente 
from pedido 
where year(fecha_pedido)=2008;
/* 1.8.2 */
select codigo_cliente 
from pedido 
where DATE_FORMAT(fecha_pedido,'%Y')=2008;
/* 1.8.3 */
select codigo_cliente 
from pedido 
where fecha_pedido like '2008-%-%';

/* 1.9 */
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega 
from pedido 
where datediff(fecha_entrega, fecha_esperada)>1;
/* 1.10.1 */
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega 
from pedido 
where datediff(fecha_esperada, fecha_entrega)>1;
/* 1.10.2 */
select codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega 
from pedido where adddate(fecha_entrega,interval 1 day)<fecha_esperada;
/* 1.11 */
select codigo_pedido as Ped_rechazo_2009 
from pedido where year(fecha_pedido)=2009 
and estado like 'Rechazado';
/* 1.12 */
select codigo_pedido as Ped_enero 
from pedido 
where DATE_FORMAT(fecha_pedido,'%m')=01;
/* 1.13 */
select codigo_cliente, forma_pago, total 
from pago 
where forma_pago='PayPal' 
and year(fecha_pago)=2008 
order by total desc;
/* 1.14 */
select distinct forma_pago 
from pago;
/* 1.15 */
select nombre 
from producto 
where gama = 'Ornamentales' and cantidad_en_stock>100 
order by precio_venta desc;
/* 1.16 */
select nombre_cliente 
from cliente 
where region='Madrid' 
and (codigo_empleado_rep_ventas=11 or codigo_empleado_rep_ventas=30);


/* 2.1 */
select cliente.nombre_cliente, empleado.nombre, empleado.apellido1 
from cliente, empleado 
where empleado.codigo_empleado=cliente.codigo_empleado_rep_ventas;

/* 2.2 */
select distinct cliente.nombre_cliente, empleado.nombre 
from cliente, empleado, pedido 
where empleado.codigo_empleado=cliente.codigo_empleado_rep_ventas 
and pedido.codigo_cliente in (cliente.codigo_cliente);

/* 2.3 */
select distinct cliente.nombre_cliente,empleado.nombre 
from cliente,empleado 
where empleado.codigo_empleado=cliente.codigo_empleado_rep_ventas 
and cliente.codigo_cliente not in (select pago.codigo_cliente from pago);

/* 2.4 */
select distinct cliente.nombre_cliente,empleado.nombre, oficina.ciudad 
from cliente,empleado,oficina 
where oficina.codigo_oficina=empleado.codigo_oficina 
and empleado.codigo_empleado=cliente.codigo_empleado_rep_ventas 
and cliente.codigo_cliente in (select pago.codigo_cliente from pago);

/* 2.5 */
select distinct cliente.nombre_cliente,empleado.nombre, oficina.ciudad 
from cliente,empleado,oficina 
where oficina.codigo_oficina=empleado.codigo_oficina 
and empleado.codigo_empleado=cliente.codigo_empleado_rep_ventas 
and cliente.codigo_cliente not in (select pago.codigo_cliente from pago);

/* 2.6 */
select oficina.linea_direccion1, oficina.linea_direccion2 
from oficina, cliente, empleado 
where empleado.codigo_empleado=cliente.codigo_empleado_rep_ventas 
and empleado.codigo_oficina=oficina.codigo_oficina 
and cliente.ciudad='Fuenlabrada';

/* 2.7 */
select cliente.nombre_cliente, empleado.nombre, oficina.ciudad 
from oficina, cliente, empleado 
where oficina.codigo_oficina=empleado.codigo_oficina 
and empleado.codigo_empleado=cliente.codigo_empleado_rep_ventas 
and empleado.codigo_oficina=oficina.codigo_oficina;

/* 2.8 */
select E.nombre, J.nombre 
from empleado E, empleado J where E.codigo_jefe=J.codigo_empleado;

/* 2.9 */
select distinct cliente.nombre_cliente 
from pedido, cliente where cliente.codigo_cliente=pedido.codigo_cliente 
and datediff(pedido.fecha_entrega, pedido.fecha_esperada)>0;

/* 2.10 */
select distinct cliente.nombre_cliente, producto.gama 
from cliente,producto,pedido,detalle_pedido 
where detalle_pedido.codigo_pedido=pedido.codigo_pedido 
and pedido.codigo_cliente=cliente.codigo_cliente 
and detalle_pedido.codigo_producto=producto.codigo_producto; 

/* 2.11 */
select distinct nombre_cliente 
from cliente 
where codigo_cliente not in (select pago.codigo_cliente from pago);

/* 2.12 */
select distinct nombre_cliente 
from cliente 
where codigo_cliente not in (select codigo_cliente from pedido);

/* 2.13 */
select distinct nombre_cliente 
from cliente where codigo_cliente not in (select pago.codigo_cliente from pago) 
and codigo_cliente not in (select codigo_cliente from pedido);

/* 2.14 */
select nombre from empleado where codigo_oficina=NULL;

/* 2.15 */
select nombre 
from empleado 
where codigo_empleado not in (select codigo_empleado_rep_ventas from cliente);

/* 2.16 */
select empleado.nombre, oficina.* 
from empleado, oficina 
where oficina.codigo_oficina=empleado.codigo_oficina 
and codigo_empleado not in (select codigo_empleado_rep_ventas from cliente);

/* 2.17 */
select nombre 
from empleado 
where codigo_oficina=NULL 
and codigo_empleado not in (select codigo_empleado_rep_ventas from cliente);

/* 2.18 */
select nombre 
from producto 
where codigo_producto not in (select codigo_producto from detalle_pedido);

/* 2.19 */
select producto.nombre,producto.descripcion,gama_producto.imagen  
from producto,gama_producto 
where producto.gama=gama_producto.gama and producto.codigo_producto not in (select codigo_producto from detalle_pedido);

/* 2.20 */
select oficina.codigo_oficina 
from oficina 
where codigo_oficina not in (select codigo_oficina from empleado where codigo_empleado in 
                              (select codigo_empleado_rep_ventas from cliente where codigo_cliente in 
							    (select codigo_cliente from pedido where codigo_pedido in 
								  (select codigo_pedido from detalle_pedido where codigo_producto in 
								    (select codigo_producto from producto where gama='Frutales')))));
									
/* 2.21 */
select nombre_cliente 
from cliente 
where codigo_cliente not in (select distinct codigo_cliente from pago) 
and codigo_cliente in (select codigo_cliente from pedido);

/* 2.22 */
select E.nombre, J.nombre 
from empleado E, empleado J 
where E.codigo_jefe=J.codigo_empleado 
and E.codigo_empleado not in (select codigo_empleado_rep_ventas from cliente);

/* 3.1 */
select count(codigo_empleado) 
from empleado;

/* 3.2 */
select distinct pais, count(nombre_cliente) 
from cliente group by pais;

/* 3.3 */
select avg(total)
from pago;

/* 3.4 */
select estado, count(codigo_pedido) 
from pedido 
group by estado 
order by count(codigo_pedido) desc;

/* 3.5 */
select max(precio_venta) as producto_más_caro, min(precio_venta) as producto_mas_barato 
from producto;

/* 3.6 */
select count(nombre_cliente) 
from cliente;

/* 3.7 */
select count(nombre_cliente) 
from cliente 
where ciudad='Madrid';

/* 3.8 */
select ciudad, count(nombre_cliente) 
from cliente 
where ciudad like 'M%' 
group by ciudad;

/* 3.9 */
select empleado.nombre, count(cliente.codigo_empleado_rep_ventas) 
from empleado, cliente 
where empleado.codigo_empleado=cliente.codigo_empleado_rep_ventas 
group by empleado.nombre;

/* 3.10 */
select count(nombre_cliente) 
from cliente 
where codigo_empleado_rep_ventas=NULL;

/* 3.11 */
select cliente.nombre_cliente, cliente.apellido_contacto, min(pago.fecha_pago), max(pago.fecha_pago) 
from pago, cliente 
where pago.codigo_cliente=cliente.codigo_cliente 
group by cliente.nombre_cliente;

/* 3.12 */
select codigo_pedido, count(codigo_producto) 
from detalle_pedido 
group by codigo_pedido;

/* 3.13 */
select codigo_pedido, count(codigo_producto) 
from detalle_pedido 
group by codigo_pedido;

/* 3.14 */
select codigo_producto, sum(cantidad) 
from detalle_pedido 
group by codigo_producto 
order by sum(cantidad) desc limit 20;

/* 3.15 */
select sum(detalle_pedido.cantidad*producto.precio_venta) as base_imponible, 
sum(detalle_pedido.cantidad*producto.precio_venta*0.21) as IVA, 
sum(detalle_pedido.cantidad*producto.precio_venta*1.21) as total 
from detalle_pedido, producto 
where detalle_pedido.codigo_producto=producto.codigo_producto;

/* 3.16 */
select detalle_pedido.codigo_producto, 
sum(detalle_pedido.cantidad*producto.precio_venta) as base_imponible, 
sum(detalle_pedido.cantidad*producto.precio_venta*0.21) as IVA, 
sum(detalle_pedido.cantidad*producto.precio_venta*1.21) as total 
from detalle_pedido,producto 
where detalle_pedido.codigo_producto=producto.codigo_producto 
group by detalle_pedido.codigo_producto;

/* 3.17 */
select detalle_pedido.codigo_producto, 
sum(detalle_pedido.cantidad*producto.precio_venta) as base_imponible, 
sum(detalle_pedido.cantidad*producto.precio_venta*0.21) as IVA, 
sum(detalle_pedido.cantidad*producto.precio_venta*1.21) as total 
from detalle_pedido,producto 
where detalle_pedido.codigo_producto=producto.codigo_producto 
and detalle_pedido.codigo_producto like 'OR%' 
group by detalle_pedido.codigo_producto; 

/* 3.18 */
select detalle_pedido.codigo_producto, producto.nombre, 
sum(detalle_pedido.cantidad), 
sum(detalle_pedido.cantidad*producto.precio_venta) as base_imponible, 
sum(detalle_pedido.cantidad*producto.precio_venta*0.21) as IVA, 
sum(detalle_pedido.cantidad*producto.precio_venta*1.21) as total 
from detalle_pedido,producto 
where detalle_pedido.codigo_producto=producto.codigo_producto 
group by detalle_pedido.codigo_producto 
having sum(detalle_pedido.cantidad*producto.precio_venta)>=3000;


/* 4.1.1 */
select nombre_cliente 
from cliente 
where limite_credito=(select max(limite_credito) from cliente);

/* 4.1.2 */
select nombre 
from producto 
where precio_venta=(select max(precio_venta) from producto);


/* 4.1.3 */
select nombre 
from producto 
where codigo_producto=(select codigo_producto from detalle_pedido group by codigo_producto order by sum(cantidad) desc limit 1); 

select nombre 
from producto 
where codigo_producto in (select codigo_producto 
                            from detalle_pedido
							group by codigo_producto 
							having sum(cantidad)>=ALL(select sum(cantidad) from detalle_pedido group by codigo_producto));

/* 4.1.4 */
select nombre_cliente, limite_credito 
from cliente 
where limite_credito>(select sum(pago.total) 
                       from pago 
					   where pago.codigo_cliente=cliente.codigo_cliente 
					   group by codigo_cliente);
					   
/* 4.1.5 */
select codigo_producto 
from producto 
where cantidad_en_stock>=ALL(select cantidad_en_stock from producto);

/* 4.1.6 */
select codigo_producto 
from producto 
where cantidad_en_stock<=ALL(select cantidad_en_stock from producto);

/* 4.1.7 */
select nombre, apellido1, apellido2, email 
from empleado 
where codigo_jefe=(select codigo_empleado from empleado where nombre='Alberto' and apellido1='Soria');

/* 4.2.1 */
select nombre_cliente 
from cliente 
where limite_credito>=ALL(select limite_credito from cliente);

/* 4.2.2 */
select nombre 
from producto 
where precio_venta>=ALL(select precio_venta from producto);

/* 4.2.3 */
select codigo_producto 
from producto 
where cantidad_en_stock<=ALL(select cantidad_en_stock from producto);

/* 4.3.1 */
select nombre, apellido1, puesto 
from empleado 
where codigo_empleado in (select codigo_empleado_rep_ventas from cliente);

/* 4.3.2 */
select nombre_cliente 
from cliente 
where codigo_cliente not in (select codigo_cliente from pago);

/* 4.3.3 */
select nombre_cliente 
from cliente 
where codigo_cliente in (select codigo_cliente from pago);

/* 4.3.4 */
select nombre 
from producto 
where codigo_producto not in (select codigo_producto from detalle_pedido);

/* 4.3.5 */
select codigo_oficina, pais, telefono 
from oficina 
where codigo_oficina in (select codigo_oficina from empleado where codigo_empleado in 
                                 (select codigo_empleado_rep_ventas from cliente));
								 
/* 4.3.6 */
select codigo_oficina, pais, telefono 
from oficina where codigo_oficina not in 
                         (select codigo_oficina from empleado where codigo_empleado in 
						    (select codigo_empleado_rep_ventas from cliente where codigo_cliente in 
							   (select codigo_cliente from pedido where codigo_pedido in 
							      (select codigo_pedido from detalle_pedido where codigo_producto in 
								     (select codigo_producto from producto where gama='Frutales')))));
									 
/* 4.3.7 */
select nombre_cliente 
from cliente 
where codigo_cliente in (select codigo_cliente from pedido) 
and codigo_cliente not in (select codigo_cliente from pago);

/* 4.4.1 */
select nombre_cliente 
from cliente 
where not exists (select codigo_cliente from pago where cliente.codigo_cliente=pago.codigo_cliente);

/* 4.4.2 */
select nombre_cliente 
from cliente 
where exists (select codigo_cliente from pago where cliente.codigo_cliente=pago.codigo_cliente);

/* 4.4.3 */
select nombre 
from producto 
where not exists (select codigo_producto from detalle_pedido where producto.codigo_producto=detalle_pedido.codigo_producto);

/* 4.4.4 */
select nombre 
from producto 
where exists (select codigo_producto from detalle_pedido where producto.codigo_producto=detalle_pedido.codigo_producto);


/* 5.1 */
select cliente.nombre_cliente, count(pedido.codigo_pedido) 
from cliente left join pedido on cliente.codigo_cliente=pedido.codigo_cliente 
group by cliente.codigo_cliente;

/* 5.2 */
select cliente.nombre_cliente, sum(pago.total) 
from cliente left join pago on cliente.codigo_cliente=pago.codigo_cliente 
group by cliente.codigo_cliente;

/* 5.3 */
select nombre_cliente 
from cliente 
where codigo_cliente in (select codigo_cliente from pedido where year(fecha_pedido)=2008) 
order by nombre_cliente desc;

/* 5.4 */
select cliente.nombre_cliente, empleado.nombre, empleado.apellido1, oficina.telefono 
from cliente, empleado, oficina 
where cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado 
and empleado.codigo_oficina=oficina.codigo_oficina 
and cliente.codigo_cliente in (select codigo_cliente from pago);

/* 5.5 */
select cliente.nombre_cliente, empleado.nombre, empleado.apellido1, oficina.ciudad 
from cliente, empleado, oficina 
where cliente.codigo_empleado_rep_ventas=empleado.codigo_empleado 
and empleado.codigo_oficina=oficina.codigo_oficina;

/* 5.6 */
select empleado.nombre, empleado.apellido1, empleado.apellido2, oficina.telefono 
from empleado, oficina 
where empleado.codigo_oficina=oficina.codigo_oficina 
and empleado.codigo_empleado not in (select codigo_empleado_rep_ventas from cliente);

/* 5.7 */
select oficina.ciudad, count(empleado.codigo_empleado) 
from oficina, empleado 
where oficina.codigo_oficina=empleado.codigo_oficina 
group by oficina.codigo_oficina;


/* 6.1 */insert into oficina  values ('ALM-ES','Almeria','España','Almería´','04001','+34918503332','Avenida Almeria','Nºpatata');
/* 6.2 */insert into empleado values (32,'Javier','Perez','Nazario','4811','patata@jardineria.es','ALM-ES','32','Representante Ventas');
/* 6.3 */insert into cliente values (39,'Patata World','S.L','e Hijos','+34612312312','+34612312312','Dir cliente',NULL,'Almeria','Almeria','España','04001',32,'123456789');
/* 6.4 */insert into pedido values (129,'2021-01-18','2021-01-21','2021-01-21','Entregado','El pedido llego a tiempo',39); 
		 insert into pedido values (130,'2021-01-18','2021-01-21','2021-01-22','Entregado','El pedido llego tarde',39);
/* 6.5 */update cliente values codigo_cliente=40 where codigo_cliente=39;
/* 6.6 */delete from cliete where nombre_cliente='Patata World';
/* No se borra en las tablas relacionadas xq no están establecidas las condiciones de borrado y actualización */
/* 6.7 */delete from cliente where codigo_cliente not in (select codigo_cliente from pedido);
/* 6.8 */update producto set precio_venta=precio_venta*1.20 where codigo_producto not in (select codigo_producto from pedido);
/* 6.9 */delete from pago where codigo_cliente=(select codigo_cliente from cliente having min(limite_credito)); 
/* 6.10 */update cliente set limite_credito=0 where (select C.codigo_cliente, sum(DP.cantidad) from cliente C, pedido P, detalle_pedido DP where C.codigo_cliente=P.codigo_cliente and P.codigo_pedido=DP.codigo_pedido and DP.codigo_producto='OR-179' group by C.codigo_cliente)<= ALL

/* 6.11 */alter table detalle_pedido add iva int;
update detalle_pedido set iva = 18 where codigo_pedido in (select codigo_pedido from pedido where year(fecha_pedido)>2008);
update detalle_pedido set iva = 21 where iva is NULL;
/* 6.12 */alter table detalle_pedido add total_linea int;
update detalle_pedido set total_linea = precio_unidad*cantidad * (1 + (iva/100));
/* 6.13  */
delete from cliente where limite_credito=(select codigo_cliente from cliente having min(limite_credito)); /* No permite borrar xq no se puede hacer referencia a la misma tabla */ 
select min(limite_credito) from cliente;
/* hay que quitar las foreign key para que se borre */SET FOREIGN_KEY_CHECKS=0;
delete from cliente where limite_credito=/* insertar valor de la consulta anterior */1500;
/* No se borra en las tablas relacionadas xq no están establecidas las condiciones de borrado y actualización */
SET FOREIGN_KEY_CHECKS=1;
/* 6.14 */
insert into oficina (codigo_oficina, ciudad, pais, region, codigo_postal, telefono, linea_direccion1, linea_direccion2)
values ('GRN-ES', 'Granada', 'España', 'Granada', '1234', '123456789', 'Calle De Granada', 'n3');

insert into empleado (codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto)
values (33, 'Jacinto', 'María', 'Ruiz', '69420', 'nose@nose.com', 'GRN-ES', 8, 'Representante Ventas');
insert into empleado (codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto)
values (34, 'Jacinto', 'Rodolfo', 'Valentino', '69421', 'nose2@nose.com', 'GRN-ES', 8, 'Representante Ventas');
insert into empleado (codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto)
values (35, 'Jacinto', 'Ramón', 'Ramirez', '69422', 'nose3@nose.com', 'GRN-ES', 8, 'Representante Ventas');

/* 6.15*/
insert into cliente (codigo_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal,
                     codigo_empleado_rep_ventas, limite_credito)
values (39, 'Jardinerías LaPiña', 'Mariano', 'Lopez', '1234567890', '1234567890', 'Calle no', '', 'Santa Fe', 'Granada', 'España', '18320', 33, 1234.56);
insert into cliente (codigo_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal,
                     codigo_empleado_rep_ventas, limite_credito)
values (40, 'Jardinerías La Fresa', 'Amalia', 'Lopez', '1234567891', '1234567891', 'Calle no 2', '', 'Santa Fe', 'Granada', 'España', '18320', 34, 1236.57);
insert into cliente (codigo_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal,
                     codigo_empleado_rep_ventas, limite_credito)
values (41, 'Jardinerías El Sauce', 'Roberto', 'Lopez', '1234567892', '1234567892', 'Calle no 3', '', 'Santa Fe', 'Granada', 'España', '18320', 35, 1230.95);












--Ejercicios de repaso

--2.17 Muestra un listado que muestre los empleados que no oficina asociada ni clientes asociados
SELECT E.codigo_empleado
FROM empleado E
WHERE E.codigo_oficina = NULL 
AND E.codigo_empleado NOT IN (SELECT C.codigo_empleado_rep_ventas FROM cliente C);



/*2.20 Muestra las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes
de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales*/
SELECT O.codigo_oficina
FROM oficina O
WHERE O.codigo_oficina NOT IN (SELECT E.codigo_oficina
FROM empleado E
WHERE E.codigo_empleado IN (SELECT C.codigo_empleado_rep_ventas
FROM cliente C
WHERE C.codigo_cliente IN (SELECT P.codigo_cliente
FROM pedido P
WHERE P.codigo_pedido IN (SELECT DP.codigo_pedido
FROM detalle_pedido DP
WHERE DP.codigo_producto IN (SELECT PR.codigo_producto
FROM producto PR
WHERE gama = 'Frutales')))));



