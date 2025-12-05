--cte: es una tabla virtual definida con with al inicio de la consulta 
--sirve para dividir consultas complejas en pasos logicos
--mejora la legibilidad y evitar las subconsultas repetidas 
--realiza consultas recursivas como jerarquias
--ventajas: organiza consultas complejas en pasos claros
--evita repetir sus consultas en multiples lugares 
--soporta operaciones y no ocupan espacio fisico (disco duro/solido) ya que soloe xiste en la ejecucion de la consulta
--ejemplos
create database tiendacte
use tiendacte
go

create table categoria (
idcategoria int identity(1,1) primary key,
nombrecategoria nvarchar(100));

create table productos(
idproducto int identity(1,1) primary key,
nombreproducto nvarchar(100),
precio decimal(10,2),
stock int,
idcategoria int,
foreign key (idcategoria) references categoria(idcategoria))

create table jerarquiacategoria(
categoriaid int identity (1,1) primary key,
nombrecategoria nvarchar(50),
categoriapadreid int null)


insert into categoria(nombrecategoria)
values ('electronico'),('ropa'),('hogar')
insert into productos(nombreproducto,precio,stock ,idcategoria)
values ('laptop',150.40, 20,1),
('camiseta roja nike',30.99,50,2),
('sofa',500.00,10,3),
('pantalla led',74.99,30,1)
insert into jerarquiacategoria(nombrecategoria,categoriapadreid)
values ('electroncio',null),
('laptop',1),
('computadora',null),
('celular',2),
('muebles',1),
('hogar',5)
select *from jerarquiacategoria
select *from categoria
select *from productos
--listar los productos cuyo precio sea mayor a 500 y que pertenesca a la categoria electronica
with productosfiltrado as (select p.idproducto, p.nombreproducto, p.precio, c.nombrecategoria
from productos p inner join categoria c on p.idcategoria=c.idcategoria
where p.precio>100
)
select*from  productosfiltrado
order by precio desc

--mostrar todas las categorias en jerarquia con su nivel
with cte_jerarquia as ( 
--nivel basico:categoria raizas 
select 
	categoriaid, 
	nombrecategoria, 
	categoriapadreid, 
	1 AS nivel
from 
	jerarquiacategoria
where 
	categoriapadreid is null
union all 
--recursividad categoria hijas
select 
	jc.categoriaid, 
	jc.nombrecategoria,
	jc.categoriapadreid, 
	cte.nivel +1
from jerarquiacategoria jc
inner join 
cte_jerarquia cte on jc.categoriapadreid=cte.categoriaid
)
select *from cte_jerarquia
order by nivel, nombrecategoria