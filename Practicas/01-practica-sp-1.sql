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

