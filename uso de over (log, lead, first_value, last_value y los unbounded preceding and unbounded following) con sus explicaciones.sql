use wfdb
/*ejemplos de LAG	y LEAD
LAG: devuelve el valor de la fila anterior de las ventanas,
LEAD: devuelve un valor de la fila siguiente de las ventanas */
--comparar el monto de cada venta
select idempleado,idventa,fecha,monto,
LAG (monto) over (partition by idempleado order by fecha) as Monto_Anterior,
LEAD(monto) over(partition by idempleado order by fecha)as Monto_Siguiente
from ventas
/*ejemplo de first_values y last_value
FIRST_VALUE: devuelve el primer valor de la ventana
LAST_VALUE: devuele el ultimo valor de la venta
unbounded preceding: incluyen las filas antes de la fila actual, antes del final de la particion
unbounded following: incluyen las filas despues de la fila actuyal, antes del final de la particion */
--devolver el ultimo y el primer valor delo empleados
select
idempleado,idventa,monto,fecha,
FIRST_VALUE(monto) over(partition by idempleado order by fecha) as Primer_Valor,
LAST_VALUE(monto) over (partition by idempleado order by fecha 
rows between unbounded preceding and unbounded following) as Ultimo_valor
from ventas
--ahora a combinar todo en un mismo script buscando el valor maximo sin importar la fila actual
select
idempleado,idventa,monto,fecha,
max(monto) over(partition by idempleado order by fecha
rows between unbounded preceding and unbounded following) as Valor_Maximo
from ventas