use NORTHWND

--Transaccion: Las transacciones en SQLserver son fundamentales
--para asegurar la consistencia y la integridad de  los doatos 
--en una base de datos.

--Una transaccion es una uidad de tabajo que se ejecuta de manera
--completamente exitosa o no se ejecuta en absoluto.

--Sigue el principio ACID:
  --Atomicidad: Toda la transaccion se completa o no se realiza
  --nada.
  --Consistencia: La transaccion  lleva la base de datos de
  --un estado valido a otro.
  --Aislamieto: Las transacciones concurrentes no interfieren
  --entre si.
  --Duurabilidad: Una vez que una transaccion se completa, los
  --cambios son permanentes.

--Comandos a utilizar:
  --Begin transaction: Inicia una nueva transaccion.
  --Commit transaction: Confirma todos los cambios realizados.
  --Rollback transaction: Revierte todos los cabios realizados.
  --durante la transaccion

select * from Categories
go

--delete from Categories
--where CategoryID in (10,12)

begin transaction

insert into Categories(CategoryName,Description)
values ('Los remediales','Estara muy bien')
go

--delete from Categories
--where CategoryID = 9

rollback transaction
commit transaction

create  database pruebatransacciones
go

use pruebatransacciones
go

create table empleado(
	empleadoid int not null,
	nombre varchar(30) not null,
	salario money not null,
	constraint pk_empleado
	primary key(empleadoid),
	constraint chk_salario
	check(salario>0.0 and salario<=50000)
)
go

create or alter proc spu_agreagar_empleado
--Parametro de entrada
@empleadoid int,
@nombre varchar(30),
@salario money
as 
begin
begin try
begin transaction;

--Inserta en la tabla enmpleados
insert into empleado(empleadoid,nombre,salario)
values(@empleadoid,@nombre,@salario)

--Se confirma la transaccion
commit transaction;
end try
begin catch
rollback transaction;
--Obtener el error
declare @MensajeError nvarchar(4000);
set @MensajeError = ERROR_MESSAGE();
print @MensajeError
end catch
end
go

exec spu_agreagar_empleado 1,'Monico',21000.0;
go

exec spu_agreagar_empleado 2,'Toribio',-60000.0;
go

select * from empleado