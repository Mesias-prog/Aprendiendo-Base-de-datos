/*La cláusula OVER es la pieza fundamental para los (Window Functions). 
Su propósito principal es permitir realizar cálculos avanzados 
sobre un conjunto de filas (una "ventana") sin perder el detalle de cada fila individual.*/
create database wfdb
use wfdb
 create table ventas(
 idventa int primary key,
 fecha date not null,
 idempleado int not null,
 monto decimal(10,2)not null);
insert into ventas (idventa, fecha, idempleado, monto) 
values
(1, '2025-10-01', 101, 150.50),
(2, '2025-10-01', 102, 2300.00),
(3, '2025-10-02', 101, 45.90),
(4, '2025-10-03', 105, 890.00),
(5, '2025-10-04', 103, 120.00),
(6, '2025-10-05', 102, 540.75),
(7, '2025-10-05', 104, 210.00),
(8, '2025-10-06', 101, 95.00),
(9, '2025-10-07', 105, 1500.25),
(10, '2025-10-08', 103, 320.40);
--aqui se hace una suma acumulada
select 
idventa, fecha, idempleado,monto,
sum(monto) over (partition by idempleado order by fecha) as Suma_Acumulada
from ventas
--aqui se hace un ranking : row number
select idventa, fecha, idempleado,monto,
ROW_NUMBER() over (partition by idempleado order by fecha) as Numbero_Venta
from ventas
--ahora a calcular el promedio del monto
-- rows between 2 preceding and current row es para limitar a la ventana de las filas anteriores y las actuales-
select
idempleado,idventa,fecha,monto,
avg(monto) over (partition by idempleado order by fecha rows between 2 preceding and current row) as Promedio_Del_Monto
from ventas
/*ahora a usar RANK Y DENSE_RANK	:
RANK: asigna una un numero a cada fila dentro de un grupo, si existe mismos valores en la columna saltan numeros en la secuencia
DENSE_RANK: es parecido a RANK la diferencia es que no hace saltos 
--(aqui para hacer el ejercicio es preferible unar un 
--truncate table: y poner en el idempleado y fecha hacer que se repita, OJO solo para el ejercicio)*/
select
idempleado, idventa,fecha,monto,
rank()over (partition by idempleado order by monto desc) as rango,
dense_rank() over (partition by idempleado order by monto desc) as rangodemp
from ventas