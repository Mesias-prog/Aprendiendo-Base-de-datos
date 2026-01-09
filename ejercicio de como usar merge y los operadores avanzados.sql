create database bdtiendabontia
use bdtiendabontia

create table producto(
idproducto int identity (1,1) primary key,
nombre nvarchar (100),
stock int,
preciounit decimal (16,2));
insert into producto (nombre, stock, preciounit)
values 
('Laptop Lenovo Ideapad 3', 15, 489.99),
('Mouse Logitech M170', 60, 14.50),
('Teclado Redragon Kumara K552', 25, 39.99),
('Monitor LG UltraWide 29"', 10, 229.90),
('Audífonos Sony WH-CH510', 30, 49.99);


create table inventario (
idinventario int identity (1,1) primary key,
fecha_venta date,
cantidad int,
idproducto int);
insert into inventario (fecha_venta, cantidad, idproducto)
values 
('2025-01-10', 5, 1), --Venta de 5 unidades del producto 1
('2025-01-11', 2, 2), --Venta de 2 unidades del producto 2
('2025-01-12', 1, 3), --Venta de 1 unidad del producto 3
('2025-01-15', 4, 1), --Otra venta del producto 1
('2025-01-18', 3, 2); --Otra venta del producto 2

--utilizar merge para actualizar el stock 
merge into producto as p
using (select idproducto, sum (cantidad) as total_vendido from inventario
group by idproducto) as v
on p.idproducto= v.idproducto
when matched then 
update set 
p.stock=p.stock - v. total_vendido;
--categorizar productos segun el stock disponible
select p.nombre,p.idproducto, p.stock,
case
when stock<20 then 'bajo'
when stock between 20 and 50 then 'medio'
when stock >50 then 'alto'
end as categoria
from producto p
--usar operadores mas avanzados 
--aqui al no existir ningun valor nulo saldrá igual que si se le hace un simple select *from " "
select p.idproducto, p.nombre,p.preciounit,p.stock, nullif(p.preciounit,0) as remplazo
from producto p 
select idinventario,fecha_venta,cantidad,idproducto, coalesce(cantidad, 0) as cantidadcorregida
from inventario
--al solo existir una denominacion de precio saldrán exactamente igual pero si existiera otra denominacion como euro o pesos
--este ejemplo mostraria entre las denominaciones dichas cual es el mayor
select p.idproducto, p.nombre,p.preciounit,p.stock, GREATEST(p.preciounit) as mayor_precio
from producto p 
--al solo existir una denominacion de precio saldrán exactamente igual pero si existiera otra denominacion como euro o pesos
--este ejemplo mostraria entre las denominaciones dichas cual es el menor
select p.idproducto, p.nombre,p.preciounit,p.stock, least(p.preciounit) as menor_precio
from producto p 