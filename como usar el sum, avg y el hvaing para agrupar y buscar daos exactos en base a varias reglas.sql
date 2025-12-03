create database inventarioempresa
use inventarioempresa
go
 create table inventario (
 idinventario int identity primary key,
 producto nvarchar(50), --nvarchar es para usa letras con tilde o caracteres especiales
 categoria nvarchar(max),
 cantidad int,
 precio decimal (10,2),
 fechaingreso date default getdate() ;--default = por default


 insert into inventario(producto,categoria,cantidad,precio, fechaingreso)
 values 
 ('laptop','electronico',50,500.00,'2024-02-15'),
('teclado','electronico',100,35.40,'2025-01-26'),
('silla','muebles',30,150.00,'2024-10-06'),
('mouse','electronico',100,18.40,'2024-05-09'),
('mesa','muebles',16,100.50,'2025-02-03'),
('notebook','papeleria',500,450.00,'2024-09-15'),
('boligrafo','papeleria',1000,1.00,'2024-03-08'),
('impresora','electronico',60,249.99,'2024-04-07')
--agrupar los productos por categoria y obtener la cantidad de productos por categoria
select *from inventario
select categoria, sum(cantidad) as totalproduct
from inventario
where cantidad > 60
group by categoria
--filtrar las categorias con un total de productos superior a 500
select categoria, sum(cantidad) as cantidadproducto
from inventario
group by categoria
having sum(cantidad)>60 --la diferencia con el where opera sobre los datos agregados despues del group by
--calcular el precio promedio y el total de productos por categoria
select categoria, avg(precio) as promediototal, --el avg sirve para calcular el promedio de los valores 
sum (cantidad) as totalproductos
from inventario
group by categoria
--consultas anidadas
select categoria,avg( precio) as preciopromedio
from inventario
group by categoria
having avg(precio) >(select avg(precio) --agrupa si el precio promedio es mayor al global
from inventario)
--filtrar categorias con un precio promedio mayor superior a 50 y un total de productos menor a 600
select categoria, avg(precio) as preciopromedio,
sum(cantidad) as totalproducto
from inventario
group by categoria
having avg(precio) >50 and sum(cantidad)<600
--cateoria cuyo total supera el promedio global de productos por categora
select categoria, sum (cantidad) as totalproducto 
from inventario
group by categoria
having sum(cantidad) >(select avg(cantidad) * count(distinct categoria)--count(distinct categria) =numero de categorias distintas para que no se repita
from inventario)