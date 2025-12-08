--tabla de clientes: informacion del clientes
--tabla vendedores: informacion sobre los vendedores
--tabla de productos: informacion sonbre los productos disponibles
--tabal de ventas: informacion sobre las ventas realizadas, incluir vendedor las realizó y que producto fueron vendidos
--tabla detalleventa: relacionar las ventas con los productos que se vendieron en cada venta
create database bdsisventas
use bdsisventas
go
create table cliente(
idcliente int identity (1,1) primary key,
nombrecliente varchar(50),
email varchar(50));

create table vendedores(
idvendedor int identity(1,1) primary key,
nombrevendedor varchar (50),
comisionXventa decimal (5,2));

create table productos(
idproducto int identity primary key,
nombreproducto varchar(50),
precio decimal(10,2));

create table ventas(
idventas int identity primary key,
idvendedor int,
idcliente int,
fechaventa date default getdate(),
totalventa decimal (10,2),
foreign key (idvendedor) references vendedores (idvendedor),
foreign key (idcliente) references cliente(idcliente));

create table detalleventa(
iddetalleventa int identity primary key,
idventas int,
idproducto int,
cantidad int,
precioventa int,
foreign key (idventas) references ventas(idventas),
foreign key (idproducto) references productos(idproducto));

-- CLIENTES 
INSERT INTO cliente (nombrecliente, email)
VALUES 
('Juan Pérez', 'juan@gmail.com'),
('María López', 'maria@hotmail.com'),
('Carlos Gómez', 'carlos@empresa.com'),
('Ana Martínez', 'ana@gmail.com');

-- VENDEDORES 
INSERT INTO vendedores (nombrevendedor, comisionXventa)
VALUES
('Pedro Ruiz', 5.50),
('Laura Sánchez', 4.25),
('Miguel Torres', 6.00),
('Sofía Duarte', 3.75);

-- PRODUCTOS 
INSERT INTO productos (nombreproducto, precio)
VALUES
('Laptop Lenovo', 850.00),
('Mouse Gamer', 25.50),
('Teclado Mecánico', 70.99),
('Monitor Samsung 24"', 140.00);

-- VENTAS 
-- Importante: deben existir cliente y vendedor previamente
INSERT INTO ventas (idvendedor, idcliente, totalventa)
VALUES
(1, 1, 875.50),   -- Pedro vende a Juan
(2, 3, 211.00),   -- Laura vende a Carlos
(3, 2, 140.00),   -- Miguel vende a María
(4, 4, 870.99);   -- Sofía vende a Ana

-- DETALLE VENTA 
INSERT INTO detalleventa (idventas, idproducto, cantidad, precioventa)
VALUES
(1, 1, 1, 850),     -- Laptop
(1, 2, 1, 25),      -- Mouse
(2, 3, 2, 70),      -- Teclado x2
(4, 4, 1, 140);     -- Monitor

 --obtener los detalles de ventas junto con los productos vendidos, el total de la venta y la comision del vendedor
 select c.nombrecliente, v.fechaventa, d.cantidad,v.totalventa,v.totalventa*(ve.comisionXventa/100) as comisionvendedor,precioventa,p.nombreproducto
 from ventas v inner join cliente c on v.idcliente= c.idcliente 
 inner join vendedores ve on v.idvendedor=ve.idvendedor
 inner join detalleventa d on v.idventas=d.idventas
 inner join productos p on d.idproducto=p.idproducto
 order by v.fechaventa

 --consulta para encontrar al producto mas vendido y al vendedor que lo hizo
 select p.nombreproducto, ve.nombrevendedor, sum(db.cantidad) as cantidadvendida
 from detalleventa db  
 inner join productos p on db.idproducto=p.idproducto
 inner join ventas v on v.idventas=db.idventas
 inner join vendedores ve on ve.idvendedor=v.idvendedor 
 group by p.nombreproducto, ve.nombrevendedor
 having sum(db.cantidad)=(select max(cantidadvendida) --filtrando el producto con mayor cantidad vendida
 from (select sum(db.cantidad)as cantidadvendida
 from detalleventa db
 group by db.idproducto) as subquery)
 order by cantidadvendida  desc

 --Muestra los nombres de todos los clientes cuya dirección de correo termine en @gmail.com.
 select email
 from cliente
 where email like '%@gmail.com'
 --
  select telefono
 from cliente
 where telefono like '%09'
