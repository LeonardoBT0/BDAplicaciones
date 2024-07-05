use NORTHWND;

--Lenguaje SQL-LMD
--Seleccionar todos los productos
select * from Products;

--Seleccionar todas las categorias
SELECT * FROM Categories;

--Seleccionar los proveedores
SELECT * FROM Suppliers;

--Seleccionar los clientes
SELECT * FROM Customers;

--Seleccionar los empleados
SELECT * FROM Employees;

--Seleccionar todas las paqueterias
SELECT * FROM Shippers;

--Seleccionar todas las ordenes
SELECT * FROM Orders;

--Seleccionar todos los detalles de ordenes
SELECT * FROM [Order Details];

--Consultas simples 

--Proyeccion
SELECT ProductID,ProductName,UnitsInStock,UnitPrice FROM Products;

--Alias de columna
SELECT ProductID as NumeroProducto,ProductName as 'Nombre Producto',UnitsInStock as Existencia,UnitPrice as 'Precio' FROM Products;

--Alias de tablas
SELECT ProductID as NumeroProducto,ProductName as 'Nombre Producto',UnitsInStock as Existencia,UnitPrice as 'Precio' FROM Products;

SELECT * FROM Products, Categories
WHERE Categories.CategoryID = Products.CategoryID

SELECT * FROM Products
SELECT * FROM Categories

--Campo calculado
--Seleccionar totos los productos mostrando el id del producto,
--el nombre del producto, la existencia, el precio y el importe

SELECT *, (UnitPrice * UnitsInStock) as 'Importe' from Products;

SELECT ProductID as 'Numero producto', ProductName as 'Nombre producto',
UnitsInStock as 'Existencia',UnitPrice as 'Precio',
(UnitPrice * UnitsInStock) as 'Importe' 
from Products;

select max(UnitPrice * UnitsInStock) as 'Importe maximo'
from Products

--Seleccionar las primeras 10 ordenes
select top 10 * from Orders;

--Seleccionar todos los clientes ordenados de forma ascendente  por el pais
select customerId as 'Numero del cliente', 
companyName as 'Nombre del cliente', 
address 'Direccion', 
city as 'Ciudad', 
country as 'Pais'
from Customers
order by country;

select customerId as 'Numero del cliente', 
companyName as 'Nombre del cliente', 
address 'Direccion', 
city as 'Ciudad', 
country as 'Pais'
from Customers
order by country asc;

select customerId as 'Numero del cliente', 
companyName as 'Nombre del cliente', 
address 'Direccion', 
city as 'Ciudad', 
country as 'Pais'
from Customers
order by 5 asc;

select customerId as 'Numero del cliente', 
companyName as 'Nombre del cliente', 
address 'Direccion', 
city as 'Ciudad', 
country as 'Pais'
from Customers
order by 'Pais' asc;

--Seleccionar todos los clientes de forma descendente

select customerId as 'Numero del cliente', 
companyName as 'Nombre del cliente', 
address 'Direccion', 
city as 'Ciudad', 
country as 'Pais'
from Customers
order by 5 desc;

select customerId as 'Numero del cliente', 
companyName as 'Nombre del cliente', 
address 'Direccion', 
city as 'Ciudad', 
country as 'Pais'
from Customers
order by 'Pais' desc;

--Selecciona todos los cliemtes ordenados de forma ascendente por pais y dentro de cada pais por ciudad de forma descentdente

select CustomerID, CompanyName, Country, City 
from Customers
order by Country,City desc;

--Operadores relacionales
--Son (<,>,<=,>=,==,<> o !=)

--Seleccionar todos los paises a los cuales se la a enviado las ordenes

select distinct ShipCountry from Orders
order by 1

--Seleccionar todas las ordenes enviadas a francia

select * from Orders
where ShipCountry = 'France'

--Seleccionar todas las ordenes realizadas a fancia mostrando el numero de orden, cliente al que se vendio, empleado que la realizo, pais al que se envio
--la ciudad a la que se envio

select OrderId as 'Numero de orden', 
CustomerID as 'Consumidor', 
EmployeeID as 'Empelado', 
ShipCountry as 'Pais',
ShipCity as 'Ciudad'  
from Orders
where ShipCountry ='France';

--Seleccionar las ordenes en donde no ha asignado una region de envio

select OrderId as 'Numero de orden', 
CustomerID as 'Consumidor', 
EmployeeID as 'Empelado', 
ShipCountry as 'Pais',
ShipCity as 'Ciudad',
ShipRegion as 'Region'
from Orders
where ShipRegion is Null

--Seleccionar los productos con un precio mayor a 50 dolares

select UnitPrice as 'Precio' from Products
where UnitPrice > 50

--Sleccionar los empleados contratados despues de 1 de enero de 1990

select HireDate from Employees
where HireDate > '1990-01-01'


--Seleccionar los clientes cuya pais sea alemania

select * from Customers
where Country > 'Alemania'

--Mostrar los productos con una cnatidad menos o igual a 100

select UnitsInStock from Products
where UnitsInStock <= 100

--Consultar todas las ordenes realizadas antes del 1 de enero de 1998

select * from Orders
where OrderDate < '1998-01-01'

--Seleccionar todas las ordenes realizadas por el empleado fuller

select * from Employees

select * from Orders
where EmployeeID = 2

--Seleccioanr todas las ordenes mostrando el numero de orden el cliente y la fecha de orden 
--dividida en año, mes y dia

select OrderID, CustomerID, OrderDate, YEAR(OrderDate) as 'Año', 
MONTH(OrderDate) as 'Mes', DAY(OrderDate) as 'Dia' 
from Orders

--Operdores Logicos
--Seleccionar los productos con un precio mayor a 50 y con una cantidad menor o igual a 100

select * from Products
where UnitPrice > 50 and UnitsInStock <=100

--Seleccionar todas las ordenes para francia y alemania
--where ShipCountry = 'France' or ShipCountry = 'Germany'
select * from Orders
where ShipCountry in ('France','Germany')

--Seleccionar todas las ordenes para francia,alemania y mexico

select * from Orders
where ShipCountry in('France','Germany','Mexico')