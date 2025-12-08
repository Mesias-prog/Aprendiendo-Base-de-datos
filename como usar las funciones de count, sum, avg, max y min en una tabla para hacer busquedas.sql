create database empresaavon
use empresaavon

create table ventas (
ventaid int identity primary key,
producto varchar (50),
cantidad int,
preciounitario decimal (10,2),
fechaventa date,
ciudad varchar (50))
;
insert into ventas  (producto,cantidad,preciounitario,fechaventa,ciudad)
values ('camisa',2,20.00,'2024-02-15','guayaquil'),
('zapatos',2,20.00,'2025-01-26','duran'),
('pantalon',2,20.00,'2024-10-06','samborondon'),
('camisa',2,20.00,'2024-05-09','empalme'),
('zapatos',2,20.00,'2025-02-03','pichincha'),
('pantalon',2,20.00,'2024-09-15','quito'),
('vestido',2,20.00,'2024-03-08','azuai'),
('Blusa',2,20.00,'2024-04-07','loja')
go

select *from ventas
--contar el nuemro total de ventas
select count (*) as totalventas
from ventas
--contar el numero de ventas por ciudad
select ciudad, count (*) as totalventasciudad
from ventas
group by ciudad
--sumar la cantidad de unidades vendidas en total
select sum (cantidad) as sumacantidad
from ventas
--sumar la cantidad de unidades por ciudad(en valor monetario)
select ciudad, sum(cantidad*preciounitario) as ciudacant
from ventas
where ciudad = 'guayaquil' and producto = 'camisa'
group by ciudad

select ciudad, sum (cantidad*preciounitario) as sumacantidad
from ventas
group by ciudad
--calcular el rpecio promedio de las unidades vendidas 
select producto, avg(preciounitario) as promedioprecio
from ventas
where producto = 'pantalon'
group by producto
--calcular la cantidad maxima de blusas vendidas
select producto, min(cantidad) as cantidadblusasvendidas
from ventas
where producto = 'camisa'
group by producto
--calcular el precio promedio por ciudad
select ciudad, avg(preciounitario) as promedioprecioporciudad
from ventas
group by ciudad
--obtener la cantidad maxima de productos vendidos a una sola venta
select ciudad, max(cantidad) as maximacantidad
from ventas
group by ciudad
--modificar precio unitario del id 2,4,5 
update ventas
set cantidad= 4
where ventaid in (2,4,5) --asi se modifica en diferentes id de una sola sentada
--obtener la cantidad maxima vendida por producto
select producto, max (cantidad) as mascantidadporproducto
from ventas
group by producto
--obtener la cantidad minima por producto 
select producto, min (cantidad) as cantidadmin
from ventas
group by producto
--calcular el total de ventas por ciudad en un rango de fechas del 2024-01-01 hasta el 2025-01-01
select ciudad , sum(cantidad*preciounitario) as totventasporciudad
from ventas
where fechaventa between '2024-01-01' and '2025-01-01'
group by ciudad
