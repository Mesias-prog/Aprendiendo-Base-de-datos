create database dbempres
use dbempres
create table productos 
(idprodu int identity primary key, producto varchar(50),precio decimal (10,2), categoria varchar (50), estado bit)
select * from productos
-------------------------------------------

create table proovedores(
idproo int identity primary key, nombre varchar(50), productid int, estado bit)
insert into proovedores
values ('constansa',1,1),
('constansa',2,1),
('constansa',3,0),
('bayer',2,0),
('bayer',3,1)

alter table proovedores
add constraint pk_prodid
foreign key(productid) references productos(idprodu)

select *from proovedores
---------------------------------
insert into productos 
values ('mesita para la noche',50.75,'muebles',1),
('television',349.99,'tecnologia',0),
('celular',300.99,'tecnologia',0)
--actualizar el precio de los productos
--incrementar tecnologia en un 18%
update productos
set precio = precio * 1.10
where categoria = 'tecnologia'

--modificar el precio de un producto con un codigo 3
update productos
set precio = 350, producto='televisor'
where idprodu = 3
select  * from productos where categoria = 'tecnologia'

--eliminar un registro (no el diseño de la tabla)
delete from productos
where idprodu = 3
--truncate hace que el id se regenere, es decir que si eliminas algun producto y creas otro ya no seguuirá la secuencia
--si no comienza desde el primero
 truncate table productos

 --modificar el estado de los pedidos pendientes
 create table pedidos(
 idpedi int identity primary key,
 fechentreg date,
 estado nvarchar (max),
 idcliente int)
 insert into pedidos 
 values ( '2025/12/25', 'en proceso', 105),
 ( '2026/01/02', 'entregado', 124),
 ( '2026/02/05', 'entregado', 18),
 ( '2026/01/21', 'por confirmar', 10)
 select *from pedidos where estado = 'entregado'

 update pedidos set estado ='entregado'
 where fechentreg >getdate()

