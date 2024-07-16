--procedimiento almacenado para actualizar los precios de los productos y registrar el cambio
--proceso
--Crear un procedimiento actualizado llamado actualizar precio producto
--Crear una tabla que se llame cambio de pecios campso(cambioid int identity pk,productoid int,precioanterior money,precionuevo money,fechadecambio datetime)
--El procedimiento almacenado debe aceptar dos parametros el produto a cambiar y el nuevo precio
--El procedimiento debe actualizar el precio en la tabla products
--Y el procedimiento debe de insertar un registro en la tabla con los detalles del cambio
create database cambio
go

use cambio
go

create table cambio_precios(
cambioid int not null identity(1,1),
productoid int not null,
precioanterior money,
precionuevo money
constraint pk_cambio
primary key(cambioid)
);
go


create or alter proc sp_cambio_precio
@producto int,
@nuevoprecio money
as 
begin

declare @precioAnterior money

select @precioAnterior = UnitPrice
from NORTHWND.dbo.products
where productid = @producto

update NORTHWND.dbo.Products
set UnitPrice = @nuevoprecio
where ProductID = @producto

 INSERT INTO cambio_precios (productoid, precioanterior, precionuevo)
    VALUES (@producto, @precioAnterior, @nuevoprecio);
end

select * from NORTHWND.dbo.Products
select * from NORTHWND.dbo.cambio_precios

exec sp_cambio_precio 1,10