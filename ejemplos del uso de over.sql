use wfdb
/*identificar cuando cambia el monto de una vetna respecto al anterior*/
select 
idempleado,idventa,monto,fecha,
lag (monto) over(partition by idempleado order by fecha) as Venta_Anterior,
case
when LAG(monto) over(partition by idempleado order by fecha) <> monto then 'cambio'
else 'sin cambio'
end as cambios
from ventas
--ahora las ventas mas altas por empleado
select * from(
	select idempleado,idventa,monto,fecha,
	rank() over(partition by idempleado order by monto desc) as Venta_Alta
	from ventas) as VentaCodigo
	where Venta_Alta <=3
--ahora un escenario donde el empleado no haya tenido ventas consecutivas basado en fechas (el datediff(day,lag) es para compara
--la diferencia de tiempo entre dos fechas 
select *from ventas
select
idempleado,fecha,
datediff(day,lag(fecha) over (partition by idempleado order by fecha),fecha) as SinVentasConsecutivas
from ventas
--ahora a comparar el promedio de ventas entre empleados 
/*el monto - avg(monto) calcula cuanto se desvia*/
select
idempleado,idventa,monto,fecha,
avg(monto) over (partition by idempleado order by fecha) as Promedio_Empleados,
monto - avg(monto) over (partition by idempleado order by fecha) as Diferencia_Con_Promedio
from ventas
