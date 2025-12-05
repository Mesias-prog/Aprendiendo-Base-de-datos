--Subconsulta= es una consulta dentro de otra consulta
--la usamos para calcular los valores o filtrar datos que  la consulta principal necesita
--primero se ejecuta la subconsulta y luego la consulta la principal
--ejemplo: obtener el cliente que hizo el pedido mas reciente
use tiendavirtual
select * from pedidos
select c.nombre, p.fechapedido
from pedidos p inner join clientes c on p.idcliente=c.idcliente
where p.fechapedido =(select max(fechapedido) from pedidos)
--listar los productos cuyos precios son mayor al precio promedio
select nombreproducto,precio
from productos
where  precio>(select avg(precio) from productos)
--consultas correlacionadas
--ejemplo: encontrar los clientes que han realizado mas de un solo pedido
select *from clientes 
select *from pedidos 
select nombre
from clientes 
where idcliente in (select idcliente from pedidos
group by idcliente
having count (idpedido)>1)
-- consultar los productos cuyo stok sea inferior al promedio del stockp para todos los productos
select *from productos
select nombreproducto, stock
from productos
where stock<(select avg(stock) from productos)
--encontrar el monto total gastado por cada cliente en pedidos
select  c.nombre,(select sum(p.cantidad*pr.precio)
from pedidos p inner join productos pr on p.idproducto=pr.idproducto
where p.idcliente=c.idcliente) as totalgastado
from clientes c 

SELECT  c.nombre, SUM(p.cantidad * pr.precio) AS totalgastado
FROM clientes c
LEFT JOIN pedidos p ON c.idcliente = p.idcliente
LEFT JOIN productos pr ON p.idproducto = pr.idproducto
GROUP BY c.nombre;


