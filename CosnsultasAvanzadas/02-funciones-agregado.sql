--Funciones de agregado y agrupacion

--Utilizar base de datos
use NORTHWND;

--Funciones de agregado

--Seleccionar el numero total de ordenes de compra

--count(*)

select COUNT(*) as 'Numero de ordenes' from orders;

select COUNT(*) from Customers;

--Count(campo)

select COUNT(Region) from Customers;

--Seleccionar el maximo numero de productos pedidos

select MAX(Quantity) as 'Cantidad' from [Order Details]

--Seleccionar el minimo numero de productos pedidos

select MIN(Quantity) as 'Cantidad' from [Order Details]

--Seleccionar el total de la cantidad de los productos pedidios

select sum(UnitPrice) from [Order Details]

--Seleccionar el total de dinero que he vendido

select sum(Quantity * od.UnitPrice) as 'Importe' 
from [Order Details] as od
inner join Products as p
on od.ProductID=p.ProductID
where p.ProductName='Aniseed Syrup';

select * from Products
where ProductID=3;

--Seleccionar el promedio de las ventas del producto 3

select avg(Quantity * od.UnitPrice) as 'Promedio' 
from [Order Details] as od
inner join Products as p
on od.ProductID=p.ProductID
where p.ProductName='Aniseed Syrup';

--Seleccionar el numero de productos por categoria

select CategoryID,COUNT(*) as 'Numero de producto' 
from Products

select CategoryID, COUNT(*) as 'Total de productos' 
from Products
group by CategoryID;

--Seleccionar el numero de produtos por nombre de categoria

select c.CategoryName,count(ProductID) as 'Total de productos'
from Categories as c
inner join Products as p
on c.CategoryID=p.CategoryID
where c.CategoryName in('Beverages','Confections')
group by c.CategoryName