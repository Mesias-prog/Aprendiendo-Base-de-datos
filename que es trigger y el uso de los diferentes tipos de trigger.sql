--trigger: es un disparador que se ejecuta de manera automatica en respuesta a un evento especifico en una tabla
--se puede automatizar tareas, registrar cambios en las tablas
--tipos: before, after, instead, de evento, condicion y accion

--create trigger nombredeltrigger
--on nombredeltrigger 
--(after) instead of (before) (insert, update,delete)
--as
--begin
--aqui va la accion del trigger
--end;
use BDveterinaria
select *from cliente
select *from consultas
select *from mascotas
select *from auditoria

--ejemplo 1= usar el after creando un trigger
create table  auditoria (idauditoria int identity (1,1) primary key,
tablaafectada nvarchar(max) not null,
evento nvarchar(20) not null,
fecha datetime not null,
detalle nvarchar (max));
--ahora vamos a registrar la tabla auditoria los detalles de las inserciones
create trigger registroauditoria
on consultas
after insert --este es el evento
as 
	begin
		insert into auditoria(tablaafectada,evento,fecha,detalle)
		select 'consultas' as tablaafectada,
		'insert' as evento,
		getdate() as fecha,
		concat('nueva consulta añadida' , inserted.idconsulta) as detalle
	from inserted
end;

insert into consultas( idmascotas,idcliente,costo,fecha,descripcion)
values (1,2,15.00, getdate(),'cepillado')

update consultas
set costo = costo -5 where idconsulta = 8

--ejemplo 2: usar before para prevenir las actualizaciones en la tabla mascotas si el valor 
--de edad es negativo
alter trigger validarnegativos
on mascotas
instead of update
as	
	begin 
	if exists (select *from inserted where edad <0)
		begin 
			raiserror('la edad es invalida',16,1);
			rollback transaction 
		end
		else 
		begin 
			update mascotas 
			set nombre_mascota=inserted.nombre_mascota, especie=inserted.especie,
			edad=inserted.edad, raza=inserted.raza
		from inserted
		where mascotas.idmascotas=inserted.idmascotas
	end
end;
--por si acaso alguien le pasa lo que me pasó, el codigo está bien, el codigo indica que debe ser menor a 0 pero no 0 como tal
select *from mascotas
update mascotas
set edad =edad -1 where idmascotas=1

--after delete para eliminar un registro en la tabla mascotas,
--y eliminar sus regitros asociados en la tabla consulta

--create trigger eliminarregistros
--on mascotas
--after delete 
--as 
--begin
--	delete from consultas 
--	where idmascotas in (select idmascotas from deleted);
--end;

--activar el modo cascada
--alter table consultas
--drop constraint FK__consultas__idmas__46E78A0C
--foreign key (idmascotas) references consultas (idmascotas)
--on delete cascade;
--select *from consultas
--select *from mascotas