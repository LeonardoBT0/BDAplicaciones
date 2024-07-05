use NORTHWND

--vistas (Objeto de la base de datos )
Create view vista_ventas
as
select c.CustomerID as 'ClaveCliente', c.CompanyName as 'Cliente',
concat(e.FirstName,' ',e.LastName) as 'Nombre' ,
o.OrderDate as 'FechaDeLaOrden',
DATEPART(YEAR,o.OrderDate) as 'AñoDeCompra',
Datename(MM,o.OrderDate) as 'MesDeCompra',
DATEPART(QUARTER,o.OrderDate) as 'Trimestre',
upper(p.ProductName) as 'NombreDelProducto',
od.Quantity as 'CantidadVendida',
od.UnitPrice as 'PrecioDeVenta',
p.SupplierID as 'ProveedorId'
from
Orders as o
inner join Customers as c
on o.CustomerID = c.CustomerID
inner join Employees as e
on e.EmployeeID = o.EmployeeID
inner join [Order Details] as od
on od.OrderID = o.OrderID
inner join Products as p
on p.ProductID = od.ProductID

select ClaveCliente,Nombre,NombreDelProducto,FechaDeLaOrden, 
(CantidadVendida * PrecioDeVenta) as 'Importe'
from vista_ventas
where NombreDelProducto = 'Chai'
and (CantidadVendida * PrecioDeVenta) > 600
and DATEPART(year,FechaDeLaOrden) = 1996

drop view vista_ventas

--Inner join de la vista con la tabla suppliers
select * from
vista_ventas as vv
inner join Suppliers as s
on s.SupplierID = vv.ProveedorId