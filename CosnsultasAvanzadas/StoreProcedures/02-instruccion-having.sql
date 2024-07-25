use NORTHWND
go

select o.OrderID, o. OrderDate, c.CompanyName,
c.City,od.Quantity, od.UnitPrice
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Customers as c
on c.CustomerID =  o.CustomerID
where c.City in('San Cristóbal','México D.f.')
go

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select c.CompanyName, count(o.OrderID) as [Numero de ordenes]
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Customers as c
on c.CustomerID =  o.CustomerID
where c.City in('San Cristóbal','México D.f.')
group by c.CompanyName
having count(*)>18
go

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Obtener los nombres de los prodcutos y sus categorias dosnde el precio promedio de los productos en los prodcutos en la misma categoria sea mayor a 20
--Aquellos donde el precio unitario se mayor a 40

select p.ProductName,c.CategoryName,
AVG(p.UnitPrice)
from
Products  as p
inner join Categories as c
on p.CategoryID = c.CategoryID
group by p.ProductName,c.CategoryName
having MAX(p.UnitPrice) > 100