create database bancos
use bancos 
go

create table acoount(
accountid int identity primary key,
accountholder nvarchar(100),
balance decimal(10,2));
 
 create table transacciones(
 transaccionesid int identity primary key,
 fromacoountid int, --de donde es la transaccion
 toacoountid int, --a donde vá la transaccion
 amount decimal (18,2),
 transaccion date default getdate(),
 status nvarchar(20) default 'pendiente',
 foreign key (fromacoountid) references acoount(accountid),
 foreign key (toacoountid) references acoount (accountid));

insert into acoount (accountholder, balance)
values 
('Juan Pérez', 1500.75),
('María Gómez', 2300.00),
('Carlos López', 500.50),
('Ana Torres', 3200.00);
--como buscar por un solo nombre en especifico (2 opsiones para buscar)
select  accountholder
from acoount
where accountholder like 'María%'

SELECT  accountholder
FROM acoount
WHERE LEFT(accountholder, CHARINDEX(' ', accountholder + ' ') - 1) = 'María';

select *from transacciones

begin transaction --iniciamos la transaccion
begin try 
update acoount
set balance = balance -1000 --restar 1000 dolares de la cuenta de jun perez
where accountid = 1 and balance >=1000 --solo si existe suficiente saldo
--verificamos si afecta las filas de la cuenta de juan perez 
if @@ROWCOUNT =0
begin 
throw 5000 , 'saldo insuficiente',1; --así se personaliza un error
end

--acredito el monto en la cuenta de destino(ana torres)
update acoount
set balance =balance +1000 --añadir 1000 dolares a la cuenta de ana torres
where accountid =4

--registramos la transaccion en la tabal transacciones
insert into transacciones (fromacoountid, toacoountid, amount,status)
values
(1, 4, 200.00,'completed');     -- Juan envía a ana
 commit transaction --se confirma la transaccion
 print 'transferencia completada con exito'
 end try
 begin catch
 --validar si ocurre un error revertir todos los cambios
 rollback transaction --el rollback permite revertir todos los cambios si existe un error durante la transaccion
 print 'error en transaccion, se revierte la transaccion'
 print error_message();--mostramos el mensaje del error
 end catch; 

--deducir un monto de una cuenta
--registar una transferencia en otras cuentas
--aumentar el saldo de otra cuenta como bonificacion
--si existe un error revertir los cambios realizados despues de un punto de control
begin transaction
begin try
	--paso uno deducir el monto de la cuenta juan perez
	update acoount
	set balance = balance - 500 --deducir
	where accountid = 1 and balance >=500
	--aseguramos que la operacion afecta la fila
	if @@ROWCOUNT =0
	begin 
	throw 50001,'saldo insuficiente en la cuenta',1;
	end 
	--crear un punto de control
	checkpoint;
	--paso 2 indicar la transferencia la transferencia de la tabla transacciones
	insert into transacciones(fromacoountid, toacoountid, amount,status)
	values ( 1,4,500,'pendiente');
	--paso 3 aumentar el saldo desde la cuenta de destino
	update acoount
	set balance =balance +500
	where accountid=4
	--activar el estado de la transaccion
	update transacciones
	set status = 'completed'
	where fromacoountid=1 and toacoountid= 4 and amount=500
	commit transaction
	print 'transaccion exitosa'
end try
begin catch
	print 'error, revertiendo transaccion parcial'
	print error_message()
	rollback transaction
end catch
