create database tiendavirtual
use tiendavirtual 
go
 create table clientes (
 idcliente int identity(1,1) primary key,
 nombre nvarchar (100),
 email nvarchar(100),
 telefono nvarchar(10));

  create table productos(
 idproducto int identity(1,1) primary key,
 nombreproducto nvarchar (100),
 precio decimal (12,1),
 stock int);

   create table pedidos (
 idpedido int identity(1,1) primary key,
 idcliente int,
 idproducto int,
 cantidad int,
 fechapedido date default getdate(),
 foreign key (idcliente) references clientes(idcliente),
 foreign key (idproducto) references productos(idproducto))--default es para que escoja la fecha actual

 insert into clientes (nombre, email,telefono)
 values ('Ana García', 'ana.garcia@email.com', '555-1234'),
('Carlos Ruiz', 'carlos.ruiz@tienda.net', '555-5678'),
('Marta López', 'marta_l@correo.org', '555-9012');

insert into productos (nombreproducto, precio,stock)
 values 
 ('Laptop Ultrabook X1', 1250.99, 15),      
('Mouse Inalámbrico RGB', 25.50, 150),    
('Monitor 27 Pulgadas', 350.00, 40),      
('Teclado Mecánico', 79.90, 80);

insert into pedidos (idcliente,idproducto,cantidad)
values (1, 1, 1), -- Ana compra 1 Laptop
(1, 2, 2), -- Ana compra 2 Mouse
(2, 3, 1), -- Carlos compra 1 Monitor
(3, 4, 3), -- Marta compra 3 Teclados
(2, 1, 1); -- Carlos compra otra Laptop

--inner join=permite devolver solo las filas que tengan ambas tablas relacionadas
--si no hay relacion las filas se excluyen del resultado
--se usa cuando se trabaja con datos que estén relacionadas en ambas tablas 
--ejemplo: clientes que hicieron pedidos
select o.idpedido, c.idcliente,p.idproducto,o.cantidad,o.fechapedido
from pedidos o inner join clientes c on o.idcliente=c.idcliente
inner join productos p on p.idproducto=o.idproducto
--left join=permite obtener todos los registros de la tabla izquierda y los datos relacionados
--de la tabla derecha
--si no hay coincidencia se autocompletaran  con nulos, se usa para no perder datos
--ejemplo=mostrar los pedidos incluso si no tiene un cliente relacionado
select o.idpedido, o.cantidad,c.nombre
from pedidos o left join clientes c on o.idcliente=c.idcliente

--right join= permite seleccionar todos los registros de la tabla derecha y los datos relacionados de la tabla izquierda
--se usa cuando te aseguras de no falten datos
--ejemplo=mostrar productos que no tengan pedidos
select o.fechapedido, p.idproducto,p.stock,p.nombreproducto
from pedidos o right join productos p on o.idproducto=p.idproducto
--full outer join= permite convinar los resultados de un left join y un right join,
--selecciona todos los registros de ambas tablas esten o no esten relacionados
--y los valores sin relacion se completa con null
--mostrar todos los clientes y todos los productos incluso si no tienen relacion con un pedido
select c.nombre, p.nombreproducto, o.cantidad
from pedidos o full outer join clientes c on o.idcliente=c.idcliente
full outer join productos p on o.idproducto=p.idproducto

