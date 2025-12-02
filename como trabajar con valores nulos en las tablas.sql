create database empresaxy
use empresaxy

create table empleados(
Id int identity (1,1) primary key,
nombre varchar(50),
edad int,
correo varchar (50),
fecharegist date default getdate())
--insertar los registros de manera individual
insert into empleados (nombre, edad,correo)
values ('diego',13,'calixtomes@gmail.com'),
('Roque',13,'rqoeumesa@gmail.com'),
('diego',13,null)


select *from empleados
--tabla temporal de empleados
create table emptemporal(
Id int identity (1,1) primary key,
nombre varchar(50),
edad int,
correo varchar (50),
fecharegist date default getdate())
insert into emptemporal (nombre,edad,correo,fecharegist)
values ('jota',13,'jotajota@gmail.com','12/12/2023'),
('oscar',13,'osca@gmail.com','12/12/2023'),
('diego',13,null,'12/12/2023')
select *from emptemporal
--ingresar todos los datos temporales a la original
insert into empleados(nombre,edad,correo,fecharegist)
select nombre, edad, correo, fecharegist from emptemporal 

select *from empleados
--filtrar empleados que tengan correo
select *from empleados where correo is not null --para revisar los campos que estan nulos
select nombre, coalesce(correo,'no entregado') as correo
from empleados
--

create table misventas(idventas int identity (1,1)primary key, producto varchar (100), precio decimal(10,2), cantidad int)
insert into misventas
values ('computadora',150.00,1),
('smarthphone',50.00,4),
('mesa',35.99,1),
('teclado',46.00,null)
select sum (precio* isnull (cantidad,1)) as totalventas
from misventas

select *from misventas where cantidad  is not null