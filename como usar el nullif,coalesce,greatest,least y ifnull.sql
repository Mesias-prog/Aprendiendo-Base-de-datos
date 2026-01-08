/*
NULLIF: este operador deveulve null si los 2 valores que se comparan son iguales,
si no lo son devueleve el primer valor
COALESCE: debuelve el primer valor nulo de la lista de valores proporcionales
GREATEST: este operador devuelve el valor mas grande de la lista 
LEAST: este operador devuelve el valor mas bajo de la lista
ISNULL: remplaza valores
*/
create database operadoresbd
use operadoresbd
create table productos(
idproducto int identity (1,1) primary key,
nombreprod nvarchar (100) not null,
precioUSD decimal,
precioEUR decimal,
cantidad int);
insert into productos (nombreprod, precioUSD, precioEUR, cantidad)
values
('Mouse inalámbrico Logitech M185', 15.99, 14.50, 120),
('Teclado mecánico Redragon K552', 39.99, 36.20, 75),
('Monitor Samsung 24" LED', 129.99, 118.30, 40),
('Laptop Lenovo IdeaPad 3', 549.99, 507.10, 25),
('Disco SSD Kingston 480GB', 42.99, 39.70, 90),
('Memoria RAM DDR4 8GB HyperX', 29.99, 27.60, 65),
('Audífonos Sony WH-CH510', 49.99, 46.10, 50),
('Impresora HP DeskJet 2775', 89.99, 82.90, 30),
('Cámara web Logitech C270', 24.99, 23.10, 100),
('Router TP-Link Archer C6', 44.99, 41.40, 55);
---------------------------------------------------------------------
select p.idproducto,p.nombreprod, nullif(p.precioUSD,0) as remplazoalUSD
from productos p
-----------------------------------------------------------------------
select p.cantidad,p.idproducto,p.nombreprod, coalesce(p.precioEUR,p.precioUSD,'sin precio') as preciofinal
from productos p
select *from productos
-------------------------------------------------------------------------
select p.cantidad,p.idproducto,p.nombreprod, GREATEST(p.precioEUR,p.precioUSD) as mayorvalor
from productos p
----------------------------------------------------------------------
select p.cantidad,p.idproducto,p.nombreprod, least (p.precioEUR,p.precioUSD) as mayorvalor
from productos p
----------------------------------------------------
update productos
set precioUSD= null where idproducto =1
select p.cantidad,p.idproducto,p.nombreprod, isnull (p.precioEUR,p.precioUSD) as precioremplazado
from productos p