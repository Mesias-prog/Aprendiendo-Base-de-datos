--propiedad acid
--atomicidad: una transaccion es atomica, si se ejecuta completamente o no se ejecuta en obsoluto
--si una parte falla todas las operaciones de la transaccion deben revertirse 
create database bdbancos
use bdbancos

create table cuentas(
cuentaid varchar(50) primary key,
balance decimal (18,2) not null check (balance >=0));

insert into cuentas(cuentaid,balance)
values ('a',500.00),
('b',1000.00);

begin transaction;
--restar a la cuenta a
update cuentas
set balance =balance - 100
where cuentaid='a';
--sumar a la cuenta b
update cuentas
set balance =balance +100
where cuentaid ='b';
--confirmar los cambios
commit;
--si ocurre un error deshacer todo
rollback
select *from cuentas

--consistencia: las reglas y las restriccion (foreign, primary,etc) no deben violarse
begin transaction;
--verificar que la cuenta a tiene suficiente fondo
if (select balance from cuentas where cuentaid='a')>=100
begin
--restar de la cuenta a
update cuentas
set balance = balance -100
where cuentaid = 'a';
--sumar al beneficiario
update cuentas 
set balance=balance +100
where cuentaid='b';
commit;
end
else 
begin
print 'saldoinsuficiente'
rollback;
end;
select *from cuentas

--aislamiento: las transacciones deben ejecutarse como si fueran independientes entre si, el resultado de una
--transaccion por ningun motivo debe verse afectado por otras que se estan ejecutando al mismo tiempo.
--niveles de aislamiento 
--read uncommitted: permite leer datos no confirmados 
--read comitted: permite leer datos confirmados
--repeteable react: bloquea lecturas concurrentes
--serializable: permite asegurar el mayor nivel de aislamiento
 set transaction isolation level serializable
 begin transaction
 if (select balance from cuentas where cuentaid ='b')>=100
 begin
 --verificar saldo de la cuenta b y transferir una cantidad de dinero
	 update cuentas 
	 set balance=balance -100
	 where cuentaid='b';
	 --sumar cuenta a
	 update cuentas
	 set balance=balance+100
	 where cuentaid='a';
	 commit;
	 print 'transaccion completada exitosamente'
	 end
 else
 begin 
	 print 'error saldo insuficiente'
	 rollback;
 end;

 --durabilidad: una vez que una transferencia se confirma (commit) los cambios son permanente, incluso si ocurre un fallo 
 --del sistema
