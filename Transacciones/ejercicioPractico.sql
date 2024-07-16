--Actualizar los precios de un producto y posteriormnte que guarde esa modificacion en una tabla de historicos

use NORTHWND
go

create table preciohistoricos (
IdPrec int not null identity(1,1),
precioAnterior money not null,
precioNuevo money not null,
fechaModificacion date default getdate(),
constraint pk_precioHistorico
primary key(IdPrec)
)
go


create or alter proc sp_actualizacion
@productoId int,
@nuevoPrecio money
as 
begin
begin transaction
begin try
declare @precioAnterior money

select @precioAnterior = UnitPrice
from NORTHWND.dbo.Products
where ProductID = @productoId 

update NORTHWND.dbo.Products
set UnitPrice = @nuevoPrecio
where ProductID = @productoId

insert into preciohistoricos (precioAnterior,precioNuevo)
values (@precioAnterior,@nuevoPrecio)

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

select * from preciohistoricos
select * from NORTHWND.dbo.Products
go

exec sp_actualizacion 1,20
go

--Realizsr un store procedure que elimine una orden de compra completa y debe actualizar los unitsInStock

create or alter proc sp_eliminar 
@orderID int
as 
begin transaction
begin
begin try
update p
set
p.UnitsInStock = p.UnitsInStock + od.Quantity
from [Order Details] as od
inner join Products as p
on od.ProductID = p.ProductID
where OrderID = @orderID


delete from [Order Details]
where OrderID = @orderID

delete from Orders
where OrderID = @orderID

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

exec sp_eliminar 10349

select * from Products
where ProductID = 54
select * from [Order Details]
where OrderID = 10349
select * from orders
where OrderID = 10349

