--las sentencias case tiende a dos formas de utilizarse 
--1: case simple: case expression
--when valot1 then resultado1
--when valot3 then resultado2
--when valot2 then resultado3
------------------
--else resultado por defecto
--end
--2: case buscadp
--case 
--when condicion1 then resultado1
--when condicion2 then resultado2
--when condicion3 then resultado3
--else resultaro por defecto
--end
create database dbdemocase
use dbdemocase
create table ventas (
idventa int identity primary key,
monto decimal (10,2));
insert into ventas 
values (49.99),
(25.99),
(11.99);

create table producto(
idproducto int primary key,
categoria int);
insert into producto
values (10,1),
(11,2),
(12,4);

select*from producto;

update ventas
set monto = 28.99 where idventa= 3;

select 
v.idventa,
v.monto,
case 
when v.monto <100 then 'bajo'
when v.monto between 100 and 30 then 'media'
else 'alta'
end as clasificacion
from ventas v

select
p.categoria, p.idproducto,
case p.categoria
when 1 then 'electronica'
when 2 then 'ropa'
when 3 then 'hogar'
else 'otros'
end as categoria
from producto p

create table empleados(
id_empleado int primary key,
salario decimal (10,2));
insert into empleados 
values( 1, 2500.99),( 2, 5000.99),( 3, 4000.99);

select e.salario,e.id_empleado,
case
when e.salario <3000 then e.salario*0.1
when e.salario between 3000 and 7000 then e.salario*0.07
else e.salario * 0.05
end as bono
from empleados e

select p.categoria,p.idproducto
from producto p
order by 
case p.idproducto
when 1 then 2
when 2 then 1
when 3 then 3
else 4
end; 

create table personal(
idpersonal int primary key,
nombre nvarchar (100),
ventasanuales decimal (10,2),
añosexperiencia int);

insert into personal (idpersonal, nombre, ventasanuales, añosexperiencia)
values
(1, 'Carlos Mendez', 25000.50, 2),
(2, 'Andrea López', 48000.00, 4),
(3, 'Miguel Torres', 15000.75, 1),
(4, 'Sofía Ramírez', 52000.90, 5),
(5, 'Javier Castillo', 31000.20, 3);

select p.idpersonal,p.nombre,p.ventasanuales,p.añosexperiencia,
case 
when p.añosexperiencia >=5 and p.ventasanuales>40000 then 'excelente'
when p.añosexperiencia between 4 and 10 and p.ventasanuales>30000 then 'bueno'
when p.añosexperiencia <3and p.ventasanuales<20000 then 'debe mejorar'
else 'promedio'
end as calificaciones
from personal p
