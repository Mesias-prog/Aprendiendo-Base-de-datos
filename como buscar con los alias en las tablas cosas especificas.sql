create database bdempresa
go
use bdempresa
go
create table cliente(
idcliente int primary key,
nombre varchar(50), 
viudad varchar(50))
;
create table pedidosclientes(
idpedido int primary key,
idcliente int foreign key references cliente(idcliente),
fechapedido date,
total decimal(10,2))
;
go
--tabla clientes
insert into cliente  values (1, 'maria','madrid'),
(2, 'juan','valencia'),
(3, 'jose','barcelona'),
(4, 'juan','cevilla');
--tabla pedidos
insert into pedidosclientes  values (101,1, '2024-11-05',250.22),
(102,2, '2025-02-15',150.45),
(103,3, '2025-01-26',350.99),
(104,4, '2024-12-09',550.75);

select *from pedidosclientes 
select *from cliente
--obtener los pedidos realizados por un cliente especifico
select p.idpedido, p.fechapedido,p.total,c.nombre,c.viudad
from pedidosclientes p join cliente c on p.idcliente = c.idcliente
where p.idcliente= 1;

--obtener las ciudades donde hay clientes con pedidos registados (los registros duplicados se pueden ver solo uno con el "DISTINCT")
select c.viudad 
from cliente c  join pedidosclientes p on c.idcliente=p.idcliente
--listar todos los pedidos por un monto en orden descendente (los p. son los alias para identificar de que tabla proviene)
select p.idpedido, c.nombre as cliente, p.total as monto
from pedidosclientes p join cliente c on p.idcliente=c.idcliente
order by p.total asc --desc=descendente, asc=ascendente
--obtener los pedidos realizados por clientes de barcelona ordenado por fecha de pedido
select c.nombre as cliente, p.fechapedido,p.total
from cliente c join pedidosclientes p on p.idcliente=c.idcliente
where c.viudad='barcelona'
order by p.fechapedido asc
--obtener los nombres de clientes que hayan realizado al menos un pedidocon un monto superior a 200
select distinct c.nombre 
from cliente c join pedidosclientes p on p.idcliente = c.idcliente
where p.total >200
--filtrar por un rango de fechas entre el 1 de nov del 2024 y el 2 de enero 2025
select p.fechapedido, c.nombre,p.total,p.idcliente
from cliente c join pedidosclientes p on p.idcliente = c.idcliente
where p.fechapedido between '2024-11-01' and '2025-01-02'
order by p.fechapedido asc
--listar los pedidos donde el monto es mayor a 200 o 
--la fecha del pedido es despues de 15 de nov del 2024 
--y el cliente pertenece a la ciudad de barcelon
select p.fechapedido, p.idcliente,c.nombre, c.viudad,p.total
from cliente c join pedidosclientes p on p.idcliente=c.idcliente
where p.total >200 or p.fechapedido>'2024-11-15' and viudad ='barcelona'
order by p.total desc