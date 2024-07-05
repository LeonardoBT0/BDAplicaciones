create database pruebajoins;

use pruebajoins;

create table proveedor (
provid int not null identity(1,1),
nombre varchar(50) not null,
limite_credito money not null,
constraint pk_proveedor
primary key(provid),
constraint unico_nombrepro
unique(nombre)
);

create table producto(
productoid int not null identity(1,1),
nombre varchar(50) not null,
precio money not null,
existencia int not null,
proveedor int,
constraint pk_producto
primary key(productoid),
constraint unico_nombre_proveedor
unique(nombre),
constraint fk_proveedor_producto
foreign key(proveedor)
references proveedor(provid)
);

--Agregar registros a las tablas proveedor y producto

insert into proveedor(nombre,limite_credito)
values
('Proveedor1',5000),
('Proveedor2',6778),
('Proveedor3',6788),
('Proveedor4',6666);

select * from proveedor;

insert into producto(nombre,precio,existencia,proveedor)
values
('Producto1',56,34,1),
('Producto2',56,56,1),
('Producto3',45.6,33,2),
('Producto4',22.34,666,3);

select * from producto

select * from 
proveedor as p
inner join producto as pr
on pr.proveedor = p.provid

use NORTHWND

select s.CompanyName as 'Proveedor',sum(od.UnitPrice*od.Quantity) as 'Total de ventas'
from (select CompanyName,SupplierID from Suppliers
) as s
inner join (select * from Products
) as p
on s.SupplierID = p.SupplierID
inner join (select UnitPrice,Quantity,ProductID,OrderID from [Order Details] 
) as od
on p.ProductID = od.ProductID
inner join (select OrderID,OrderDate from Orders
) as o
on od.OrderID = o.OrderID
where o.OrderDate between '1996-09-01' and '1996-12-31' 
group by s.CompanyName
order by 'Total de ventas' desc;

use NORTHWND;

select c.CategoryName,p.ProductName,p.UnitsInStock,p.UnitPrice,p.Discontinued
from(
select CategoryName,CategoryID from Categories
) as c
inner join
(
select ProductName,UnitsInStock,CategoryID,UnitPrice,Discontinued from Products
)as p
on c.CategoryID = p.CategoryID;

--left join
use pruebajoins
select * from 
proveedor as p
left join producto as pr
on pr.proveedor = p.provid
where pr.proveedor is Null

--Crear dos tablas una llamada empleados y otra dmi_empleados database prueba carga dinamica