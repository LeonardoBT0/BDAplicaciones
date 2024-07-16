--MERGE INTO <target table> AS TGT
--USING <SOURCE TABLE> AS SRC  
--  ON <merge predicate>
--WHEN MATCHED [AND <predicate>] -- two clauses allowed:  
--  THEN <action> -- one with UPDATE one with DELETE
--WHEN NOT MATCHED [BY TARGET] [AND <predicate>] -- one clause allowed:  
--  THEN INSERT... –- if indicated, action must be INSERT
--WHEN NOT MATCHED BY SOURCE [AND <predicate>] -- two clauses allowed:  
--  THEN <action>; -- one with UPDATE one with DELETE

create database mergeEscuelita
go

use mergeEscuelita
go

CREATE TABLE StudentsC1(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);
go


INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)
go

CREATE TABLE StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);
go

select * from StudentsC1
go

select * from
StudentsC1 as c1
inner join 
StudentsC2 as c2
on c1.StudentID = c2.StudentID
go

select c1.StudentID,c1.StudentName,c1.StudentStatus from
StudentsC1 as c1
inner join 
StudentsC2 as c2
on c1.StudentID = c2.StudentID
go

select c1.StudentID,c1.StudentName,c1.StudentStatus from
StudentsC1 as c1
left join 
StudentsC2 as c2
on c1.StudentID = c2.StudentID
where c2.StudentID is null
go

insert into StudentsC2 
values (1,'Axel Romero',0)
go

truncate table studentsc2
go

---------------------------------------------------------------------------store procedure

--Store procedure que agrega y actualiza los registros nuevos y registros modificados
--de la tabla StudentC1 a StudentC2 utilizando cosnultas con left join e inner join y transacciones 

create or alter procedure spu_carga_delta_s1_s2
--Parametros
as
begin
--Programacion del SP
begin transaction
begin try
--Procedimiento a ejecutar de forma exitosa
--Insertar nuevos registros de la tabla Student1 a Student2
insert into StudentsC2 (StudentID,StudentName,StudentStatus)
select c1.StudentID,c1.StudentName,c1.StudentStatus from
StudentsC1 as c1
left join 
StudentsC2 as c2
on c1.StudentID = c2.StudentID
where c2.StudentID is null
--Se actualizan los registros que han tenidomalgun cambio en la tabla source (StudentC1) y
--se cambian en la tabla target(StudentC2)
update c2
set
c2.StudentName = c1.StudentName,
c2.StudentStatus = c1.StudentStatus
from
StudentsC1 as c1
inner join 
StudentsC2 as c2
on c1.StudentID = c2.StudentID
--Vamos a confirmar la transaccion
commit transaction
end try
begin catch
rollback transaction
declare @mensajeError varchar(100)
set @mensajeError = ERROR_MESSAGE()
print @mensajeError
end catch
end
go

exec spu_carga_delta_s1_s2
go

select c1.StudentID,c1.StudentName,c1.StudentStatus from
StudentsC1 as c1
inner join 
StudentsC2 as c2
on c1.StudentID = c2.StudentID
go

select c1.StudentID,c1.StudentName,c1.StudentStatus from
StudentsC1 as c1
left join 
StudentsC2 as c2
on c1.StudentID = c2.StudentID
go

select * from StudentsC1
go
select * from StudentsC2
go

update StudentsC1
set StudentName = 'Axel Ramero'
where StudentID = 1
go

update StudentsC1
set StudentStatus = 1
where StudentID = 3
go

update StudentsC1
set StudentStatus = 0
where StudentID in(1,4,5)
go

insert into StudentsC1
values (6,'Monico Hernandez',0)
go

select @@VERSION
go

create or alter procedure spu_carga_delta_s1_s2_merge
--Parametros
as
begin
--Programacion del SP
begin transaction
begin try
merge into StudentsC2 as TGT
using (
select studentid,studentname,studentstatus
from StudentsC1
)as SRC
on(
TGT.studentid = SRC.studentid
)
--Para actualizar
when matched then
Update 
set TGT.studentname = SRC.studentname,
TGT.studentstatus = SRC.studentstatus
--Para insertar
when not matched then
insert (studentid,studentname,studentstatus)
values (SRC.studentid,SRC.studentname,SRC.studentstatus);

--Procedimiento a ejecutar de forma exitosa
--Insertar nuevos registros de la tabla Student1 a Student2

--Se actualizan los registros que han tenidomalgun cambio en la tabla source (StudentC1) y
--se cambian en la tabla target(StudentC2)

--Vamos a confirmar la transaccion
commit transaction
end try
begin catch
rollback transaction
declare @mensajeError varchar(100)
set @mensajeError = ERROR_MESSAGE()
print @mensajeError
end catch
end
go

exec spu_carga_delta_s1_s2_merge
go

truncate table studentsc2
go

select * from StudentsC1
go
select * from StudentsC2
go

update StudentsC1
set StudentName = 'Juana de arco'
where StudentID = 2
go

create or alter procedure spu_carga_delta_s1_s2_d
--Parametros
as
begin
--Programacion del SP
begin transaction
begin try
--Procedimiento a ejecutar de forma exitosa
--Insertar nuevos registros de la tabla Student1 a Student2
insert into StudentsC2 (StudentID,StudentName,StudentStatus)
select c1.StudentID,c1.StudentName,c1.StudentStatus from
StudentsC1 as c1
left join 
StudentsC2 as c2
on c1.StudentID = c2.StudentID
where c2.StudentID is null
--Se actualizan los registros que han tenidomalgun cambio en la tabla source (StudentC1) y
--se cambian en la tabla target(StudentC2)
delete StudentsC2(StudentName, c2.StudentStatus)
from
StudentsC1 as c1
inner join 
StudentsC2 as c2
on c1.StudentID = c2.StudentID
--Vamos a confirmar la transaccion
commit transaction
end try
begin catch
rollback transaction
declare @mensajeError varchar(100)
set @mensajeError = ERROR_MESSAGE()
print @mensajeError
end catch
end
go

exec spu_carga_delta_s1_s2_d