--Consultas avanzadas

select c.CategoryName as 'Nombre Categoria', 
p.ProductName as 'Nombre Producto',
p.UnitPrice as 'Precio',
p.UnitsInStock as 'Existencia'
from
Categories as c
inner join Products as p
on c.CategoryID = p.CategoryID
where CategoryName in('Beverages', 'Produce');

--Seleccionar todas las ordenes que fueron emtidas por los
--empleados Nancy, Davolio, Anne, Dodsworth y Andrew Fuller 1,9,2

select * from Orders
where EmployeeID=1 or EmployeeID=9 or EmployeeID=2

select * from Orders
where EmployeeID in(1,9,2);

--Seleccionar todas las ordenes dividiendo la fecha de orden en, año, mes y dia 

select orderDate as 'Frecha de orden', 
year(OrderDate) as 'Año',
month(OrderDate) as 'Mes',
day(orderDate) as 'Dia'
from Orders

--Seleccionar todos los nombres de los empleados 

select concat(FirstName,' ' ,LastName) as 'Nombre Completo' 
from Employees;

--Seleccionar todos los productos donde la existencia sea mayor o igual a 40
-- y el precio sea menor a 19

select productName as 'Nombre del producto', 
UnitsInStock as 'Existencia', 
UnitPrice as 'Precio'
from Products
where UnitsInStock>=40 
and UnitPrice<19;

--Seleccionar todas las ordenes realizadas de abril a agosto de 1996

select OrderID as 'Numero de orden',
CustomerID as 'Creador',
EmployeeID as 'Empleado',
OrderDate as 'Fecha de orden' 
from Orders
where OrderDate between '1996-04-1' and '1996-08-31';

--Seleccionar todas las ordenes entre 1996 y 1998

select OrderID as 'Numero de orden',
CustomerID as 'Creador',
EmployeeID as 'Empleado',
OrderDate as 'Fecha de orden' 
from Orders
where OrderDate between '1996-01-1' and '1998-12-31';

select * from Orders
where year(OrderDate) between '1996' and '1998';

--Seleccionar todas las ordenes de 1996 y 1999

select OrderID as 'Numero de orden',
CustomerID as 'Creador',
EmployeeID as 'Empleado',
OrderDate as 'Fecha de orden' 
from Orders
where OrderDate between '1996-01-1' and '1999-12-31';

select * from Orders
where year(OrderDate)  in('1996','1999');

--Seleccionar todos los prodcutos que comiencen con  c

select * from Products
where ProductName like 'c%';

select * from Products
where ProductName like 'ca%';

--Seleccionar todos los prodcutos que terminen con s

select * from Products
where ProductName like '%s';

--Seleccionar todos los productos que el nombre del producto contenga la palabra no

select * from Products
where ProductName like '%no%';

--Seleccionar todos los productos que contegan las letas a n

select * from Products
where ProductName like '%[na]%';

--Seleccionar todos los productos que comiencen entre la leta a y n

select * from Products
where ProductName like '[a-n]%';

--Seleccionar todas las ordenes que fueron emtidas por los
--empleados Nancy Davolio, Anne Dodsworth y Andrew Fuller 1,9,2

select o.OrderID as 'Numero de orden',
o.OrderDate as 'Fecha de orden',
concat(FirstName,' ' ,LastName) as 'Nombre empleado'
from 
Employees as e
inner join 
orders as o
on e.EmployeeID= o.EmployeeID
where e.FirstName in('Nancy','Anne','Andrew')
and e.LastName in('Davolio','Dodsworth','Fuller');

--Crear base de datos 

create database pruebaxyz;

--Utilizar base de datos

use pruebaxyz;

--Crear una tabla a partir de una consulta cun cero registros

select top 0*
into pruebaxyz.dbo.products2
from NORTHWND.dbo.Products;

select * from products2

--Agrega un constraint a la tabla products2

alter table products2
add constraint pk_products2
primary key(productid)

alter table products2
drop constraint pk_products2

select * from products2

--Llenar una tabla a traves de una consulta

insert into pruebaxyz.dbo.products2 (ProductName, 
SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock,
UnitsOnOrder, ReorderLevel, Discontinued)
select ProductName, 
SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock,
UnitsOnOrder, ReorderLevel, Discontinued
from NORTHWND.dbo.Products;

--Obtener el nombre del cliente y el nombre del empleado
--del representante de ventas de cada pedido
use NORTHWND;

select o.customerID, o.Employeeid,o.OrderID, o.OrderDate  from 
orders as o;

select c.CompanyName as 'Nombre del cliente',
concat(e.FirstName, ' ' ,e.LastName) as 'Nombre del cliente',
o.OrderID, o.OrderDate,
(od.Quantity * od.UnitPrice) as 'Importe'
from Customers as c
inner join Orders as o
on o.CustomerID=c.CustomerID
inner join Employees as e
on o.EmployeeID=e.EmployeeID
inner join [Order Details] as od
on od.OrderID=o.OrderID
where year(OrderDate) in('1996','1998');

--Cuantas ordenes se han realizado en 1996 y 1998

use NORTHWND;

select o.customerID, o.Employeeid,o.OrderID, o.OrderDate  from 
orders as o;

select COUNT(*) as 'Total de ordenes'
from Customers as c
inner join Orders as o
on o.CustomerID=c.CustomerID
inner join Employees as e
on o.EmployeeID=e.EmployeeID
inner join [Order Details] as od
on od.OrderID=o.OrderID
where year(OrderDate) in('1996','1998');

--Mostrar el nombre del producto
--el nombre del proveedor 
--y precio unitario de cada producto

select p.ProductName 'Nombre producto',
p.UnitPrice 'Precio', 
s.CompanyName 'Nombre proveedor' 
from Products as p
inner join Suppliers as s
on p.SupplierID=s.SupplierID;

--Ejercicio 3: Listar el nombre del cliente, el ID del pedido y la fecha del pedido para cada pedido.

select c.CustomerID
from Customers as c
inner join Orders as o
on c.CustomerID=o.CustomerID

--Ejercicio 11: Seleccionar el total de ordenes hechas por cada uno de los proveedores

select s.CompanyName,count(od.OrderID) 'Total de ordenes'
from Suppliers as s
inner join Products as p
on s.SupplierID=p.SupplierID
inner join [Order Details] as od
on p.ProductID=od.ProductID
group by s.CompanyName

--Ejerccicio 12: Seleccionar el total de dinero que he vendido por proveedores del primer trimestre de 1996

select s.CompanyName as 'Proveedor',sum(od.UnitPrice*od.Quantity) as 'Total de ventas'
from Suppliers as s
inner join Products as p
on s.SupplierID = p.SupplierID
inner join [Order Details] as od
on p.ProductID = od.ProductID
inner join Orders as o
on od.OrderID = o.OrderID
where o.OrderDate between '1996-09-01' and '1996-12-31' 
group by s.CompanyName
order by 'Total de ventas' desc;

select * from Products

--Ejercicio 13: Seleccionar el total de dinero vendido por categoria

select c.CategoryName as 'Categoria',sum(od.UnitPrice*od.Quantity) as 'Total de dinero vendido'
from Categories as c
inner join Products as p
on c.CategoryID=p.CategoryID
inner join [Order Details] as od
on p.ProductID=od.ProductID
group by c.CategoryName
order by 2 desc;

--Ejerccicio 14: Seleccioanr el total de dinero vendido por categoria  y dentro producto

select c.CategoryName as 'Categoria',
p.ProductName 'Producto',
sum(od.UnitPrice*od.Quantity) as 'Total de dinero vendido'
from Categories as c
inner join Products as p
on c.CategoryID=p.CategoryID
inner join [Order Details] as od
on p.ProductID=od.ProductID
group by c.CategoryName, p.ProductName
order by 1 asc, 2 asc, 3 asc;

