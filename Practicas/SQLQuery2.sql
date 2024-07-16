create database etlempresa

use etlempresa 
create table cliente (
 clienteid int not null identity(1,1),
 clientebk nchar(5) not null,
 empresa nvarchar(40) not null,
 ciudad nvarchar(15) not null,
 region nvarchar(15) not null,
 pais nvarchar(15) not null,
constraint pk_cliente
primary key(clienteid),
CONSTRAINT uq_clientebk 
UNIQUE (clientebk)
 );


 go
 drop table cliente

 create proc sp_etl_carga_cliente
 as
 begin
 insert into etlempresa.dbo.cliente
 select CustomerID,UPPER(CompanyName) as 'Empresa',UPPER(City) as 'Ciudad',
 UPPER(ISNULL(nc.Region, 'Sin region')) as Region, 
 upper(Country) as 'Pais'
 from
 NORTHWND.dbo.Customers as nc
 left join etlempresa.dbo.cliente as etle
 on nc.CustomerID = etle.clientebk
 where etle.clientebk is null

 update cl
 set
 cl.empresa = UPPER(c.CompanyName),
 cl.ciudad = UPPER(c.City),
 cl.pais = UPPER(c.Country),
 cl.region = UPPER(isnull(c.Region,'Sin region'))
 from NORTHWND.dbo.Customers as c
 inner join etlempresa.dbo.cliente as cl
 on c.CustomerID = cl.clientebk
 end


 select * from NORTHWND.dbo.Customers
 where CustomerID = 'CLIB1'

 update NORTHWND.dbo.Customers
 set CompanyName = 'pepsi'
 where CustomerID = 'CLIB1'

  select * from etlempresa.dbo.cliente
 where clientebk = 'CLIB1'

 truncate table etlempresa.dbo.cliente

 exec sp_etl_carga_cliente
 select * from cliente

create table Producto(
productoid int not null identity(1,1),
productobk int not null,
nombreProducto nvarchar(40) not null,
categoria nvarchar(15) not null,
precio money not null,
existencia nvarchar(20) not null,
descontinuado bit not null,
constraint pk_producto
primary key(productoid)
)
go

create proc sp_etl_carga_producto
 as
 begin
 insert etlempresa.dbo.Producto
select  np.ProductID,np.ProductName as 'Nombre del producto',
nc.CategoryName as 'Categoria',np.UnitPrice as 'Precio',
np.UnitsInStock as 'Existencia',np.Discontinued as 'Descontinuado'
from NORTHWND.dbo.Products as np
inner join NORTHWND.dbo.Categories as nc
on np.CategoryID = nc.CategoryID
left join etlempresa.dbo.Producto as etlp
on nc.CategoryID = etlp.productobk
where etlp.productobk is null

 update pd
 set
pd.categoria = nc.CategoryName,
pd.descontinuado = np.Discontinued,
pd.existencia = np.UnitsInStock,
pd.nombreProducto = np.ProductName,
pd.precio = np.UnitPrice
from NORTHWND.dbo.Products as np
inner join NORTHWND.dbo.Categories as nc
on np.CategoryID = nc.CategoryID
left join etlempresa.dbo.Producto as pd
on nc.CategoryID = pd.productobk
end

exec sp_etl_carga_producto

select * from Producto

create table empleado(
empleadoid int not null identity(1,1),
empleadobk int not null,
nombrecompleto nvarchar(40) not null,
ciudad nvarchar(15) not null,
region nvarchar(15) not null,
pais nvarchar(15) not null,
constraint pk_empleado
primary key(empleadoid)
)


create proc sp_etl_carga_empleado
as 
begin
insert etlempresa.dbo.empleado
select ne.EmployeeID,CONCAT(ne.FirstName,' ',ne.LastName) as 'Nombre',
ne.City as 'Ciudad',ISNULL(ne.Region,'Sin region') as 'Region',ne.Country
from NORTHWND.dbo.Employees as ne
left join etlempresa.dbo.empleado as etle
on ne.EmployeeID = etle.empleadobk
where etle.empleadobk is null

 update em
 set
 em.ciudad = ne.City,
 em.nombrecompleto = CONCAT(ne.FirstName,' ',ne.LastName),
 em.pais = ne.Country,
 em.region = ISNULL(ne.Region,'Sin region')
from NORTHWND.dbo.Employees as ne
left join etlempresa.dbo.empleado as em
on ne.EmployeeID = em.empleadobk
end

exec sp_etl_carga_empleado

select * from empleado

create table proveedor(
proveedorid int not null identity(1,1),
provedorbk int not null,
empresa nvarchar(40) not null,
ciudad nvarchar(15) not null,
region nvarchar(15) not null,
pais nvarchar(15) not null,
homepage ntext not null,
constraint pk_proveedor
primary key(proveedorid)
)


create or alter proc sp_etl_carga_proveedor
as 
begin 
insert etlempresa.dbo.proveedor
select ns.SupplierID,ns.CompanyName as 'Empresa',
ns.City as 'Ciudad',ISNULL(ns.Region,'Sin region') as 'Region',
ns.Country as 'Pais',ISNULL(ns.HomePage,'No hay pagina de incio') as 'Pagina de inicio'
from NORTHWND.dbo.Suppliers as ns
left join etlempresa.dbo.proveedor as etlpr
on ns.SupplierID = etlpr.provedorbk
where etlpr.provedorbk is null

 update pr
 set
 pr.ciudad = ns.City,
pr.empresa = ns.CompanyName,
 pr.pais = ns.Country,
 pr.region = ISNULL(ns.Region,'Sin region'),
  pr.homepage = ISNULL(ns.HomePage,'No hay pagina de incio')
from NORTHWND.dbo.Suppliers as ns
left join etlempresa.dbo.proveedor as pr
on ns.SupplierID = pr.provedorbk
end

exec sp_etl_carga_proveedor

select * from proveedor

create table ventas(
clienteid nchar(5) not null,
productoid int not null,
empleadoid int not null,
proveedorid int not null,
cantidad smallint not null,
precio money not null,
primary key(clienteid,productoid,empleadoid,proveedorid),
foreign key(clienteid) references cliente(clientebk),
foreign key(productoid) references producto(productoid),
foreign key(empleadoid) references empleado(empleadoid),
foreign key(proveedorid) references proveedor(proveedorid)
)

drop table ventas

create or alter proc sp_etl_carga_ventas
as 
begin 

insert into etlempresa.dbo.ventas
select 
nc.CustomerID,
np.ProductID,
ne.EmployeeID,
ns.SupplierID,
nod.UnitPrice as 'Precio',
nod.Quantity as 'Cantidad'

from NORTHWND.dbo.Suppliers as ns
inner join NORTHWND.dbo.Products as np
on ns.SupplierID = np.SupplierID
inner join NORTHWND.dbo.Categories as nca
on np.CategoryID = nca.CategoryID
inner join NORTHWND.dbo.[Order Details] as nod
on np.ProductID = nod.ProductID
inner join NORTHWND.dbo.Orders as nor
on nod.OrderID = nor.OrderID
inner join NORTHWND.dbo.Customers as nc
on nor.CustomerID = nc.CustomerID
inner join NORTHWND.dbo.Employees as ne
on nor.EmployeeID = ne.EmployeeID
left join etlempresa.dbo.ventas as etlv
on ne.EmployeeID = etlv.empleadoid
left join etlempresa.dbo.ventas as etlv2
on nc.CustomerID = etlv2.clienteid
left join etlempresa.dbo.ventas as etlv3
on np.ProductID = etlv3.productoid
left join etlempresa.dbo.ventas as etlv4
on ns.SupplierID = etlv4.proveedorid
where 
etlv.empleadoid is null 
or etlv2.clienteid is null 
or etlv3.productoid is null
or etlv4.proveedorid is null

update etlv
set 
etlv.cantidad = nod.Quantity,
etlv.precio = nod.UnitPrice

from NORTHWND.dbo.Suppliers as ns
inner join NORTHWND.dbo.Products as np
on ns.SupplierID = np.SupplierID
inner join NORTHWND.dbo.Categories as nca
on np.CategoryID = nca.CategoryID
inner join NORTHWND.dbo.[Order Details] as nod
on np.ProductID = nod.ProductID
inner join NORTHWND.dbo.Orders as nor
on nod.OrderID = nor.OrderID
inner join NORTHWND.dbo.Customers as nc
on nor.CustomerID = nc.CustomerID
inner join NORTHWND.dbo.Employees as ne
on nor.EmployeeID = ne.EmployeeID
left join etlempresa.dbo.ventas as etlv
on ne.EmployeeID = etlv.empleadoid
left join etlempresa.dbo.ventas as etlv2
on nc.CustomerID = etlv2.clienteid
left join etlempresa.dbo.ventas as etlv3
on np.ProductID = etlv3.productoid
left join etlempresa.dbo.ventas as etlv4
on ns.SupplierID = etlv4.proveedorid
end

exec sp_etl_carga_ventas


--select od.UnitPrice,Quantity 
--from 
--NORTHWND.dbo.[Order Details] as od



--UPPER(nc.CompanyName) as 'Empresa',
--UPPER(nc.City) as 'Ciudad',
--UPPER(ISNULL(nc.Region, 'Sin region')) as Region, 
--upper(nc.Country) as 'Pais',
--ne.EmployeeID,
--CONCAT(ne.FirstName,' ',ne.LastName) as 'Nombre',
--ne.City as 'Ciudad',
--ISNULL(ne.Region,'Sin region') as 'Region',
--ne.Country as 'Pais'

--np.ProductName as 'Nombre del producto',
--nca.CategoryName as 'Categoria',
--np.UnitPrice as 'Precio',
--np.UnitsInStock as 'Existencia',
--np.Discontinued as 'Descontinuado',


--ns.CompanyName as 'Empresa',
--ns.City as 'Ciudad',
--ISNULL(ns.Region,'Sin region') as 'Region',
--ns.Country as 'Pais',
--ISNULL(ns.HomePage,'No hay pagina de incio') as 'Pagina de inicio',