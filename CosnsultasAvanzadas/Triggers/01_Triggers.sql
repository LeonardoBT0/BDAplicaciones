create database pruebatriggers;
go

use pruebatriggers;
go

create table empleado(
idempleado int not null primary key,
nombreEmpleado varchar(30) not null,
apellido1 varchar(15) not null,
apellido2 varchar(15),
salario money not null
);
go

create or alter trigger tg_1
on empleado
after insert
as 
begin
print 'Se ejecuto el trigger tg_1, en el evento insert'
end;
go

select * from empleado

insert into empleado
values(1,'Leonardo Isaac','Brrera','Tejda',75000)

drop trigger tg_1

create or alter trigger tg_2
on empleado
after insert 
as
begin
select * from inserted
select * from deleted
end
go

insert into empleado
values(2,'Rocio','Cruz','Cervantes',80000)

create or alter trigger tg_3
on empleado
after delete 
as
begin
select * from inserted
select * from deleted
end
go

delete empleado
where idempleado = 2

create or alter trigger tg_4
on empleado
after update 
as
begin
select * from inserted
select * from deleted
end
go

update empleado
set salario = 100000,
nombreEmpleado = 'Pancracio'
where idempleado = 1

select * from empleado

create or alter trigger tg_5
on empleado
after insert,delete 
as
begin
if exists (select 1 from inserted)
begin
print 'Se realizo un insert'
end
else if exists (select 1 from deleted) and 
not exists (select 1 from inserted)
begin 
print 'Se realizo un deleted'
end
end
go

insert into empleado
values (2,'Lesly','Jimenez','Nery',100000)

delete from empleado
where idempleado = 2