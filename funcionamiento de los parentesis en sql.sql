--como funciona los parentesis
--sin parentesis: sql sique un orden de precedencia predeterminada sin parentesis
--con parentesis: puedes agrupar condiciones para alterar el orden de la evaluacion y frozar
--que ciertas partes de la condicion sean evaluadas antes que otras
use bdempresa
--sin parentesis
select *from pedidosclientes
where total > 200 or total <100 and fechapedido > '2024-11-01'
--con parentesis
select *from pedidosclientes
where (total > 200 or total <100) and fechapedido > '2024-11-01'
--filtrar pedidos fueron realizados entre el 1 y el 20 de noviembre del 2024 y un total mayor a 200
--fueron realizados despues del 21 de noviembre del 2024 con un monto menor a 300

select
p.idpedido, c.nombre, p.fechapedido, p.total
from pedidosclientes p join cliente c on p.idcliente=c.idcliente
where (p.fechapedido between '2024-11-01' and '2024-11-20' and p.total>200)
or
(p.fechapedido >'2024-11-01' and p.total >300)
order by p.fechapedido desc

--vivan en barcelona y han realizado mayores a 200
--vivan en valencia y tiene un id>2
select c.idcliente, c.nombre, c.viudad
from pedidosclientes p join cliente c on p.idcliente=c.idcliente
where (c.viudad='barcelona' and p.total> 200)
or
(c.viudad='valencia' and c.idcliente>2)

