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