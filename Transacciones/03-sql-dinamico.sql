use NORTHWND
go

--Crear un sp que reciba como parametro de entrada el nombre de una tabla y
--visualice todos sus registros (spu_mostrar_datos_tabla)

create or alter proc spu_mostrar_datos_tabla
@nombre varchar(100)
as 
begin
-- SQL Dinamico
declare @sql nvarchar(max)
set @sql = 'select * from ' + @nombre
exec(@sql)
end
go

exec spu_mostrar_datos_tabla 'products'
go

create or alter proc spu_mostrar_datos_tabla2
@nombre varchar(100)
as 
begin
-- SQL Dinamico
declare @sql nvarchar(max)
set @sql = 'select * from ' + @nombre
exec sp_executesql @sql
end
go

exec spu_mostrar_datos_tabla2 'products'
go