--Crear un sp que solicite un id de una categoria
--y devuelva el promedio de los precios de sus productos

create or alter proc sp_solicitar_promedio_proc
@catego int --Pareametro de entrada
as 
begin
select AVG(UnitPrice) as 'Promedio precios de los prodcutos'
from Products
where CategoryID = @catego
end
go

exec sp_solicitar_promedio_proc 5

--Crear un store procedure que reciba dos fechas y devuelva una lista de empleados
--que fueron contratados en esa fecha
create or alter proc sp_obtener_empleados_con_rango_de_fechas_de_contratacion
@fecha1 datetime,
@fecha2 datetime
as
begin
select CONCAT(FirstName,' ',LastName),HireDate 
from Employees
where HireDate between @fecha1 and @fecha2
end

exec sp_obtener_empleados_con_rango_de_fechas_de_contratacion '1992-04-01','1992-08-14'