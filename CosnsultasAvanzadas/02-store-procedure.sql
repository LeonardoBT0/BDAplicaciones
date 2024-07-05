use NORTHWND

--Store procedures

create procedure sp_prueba_g1
as
begin
print 'Hola mundo';
end

--Ejecutar un store procedure

exec sp_prueba_g1

--Declaracion de variables

Declare @n int
Declare @i int

set @n = 5
set @i = 1

print ('El valor de n es: ' + cast(@n as varchar))
print ('El valor de i es: ' + cast(@i as varchar))

create database prueba_sp

use prueba_sp

create proc sp_1
as
begin
Declare @n int
Declare @i int
set @n = 5
set @i = 1
print ('El valor de n es: ' + cast(@n as varchar))
print ('El valor de i es: ' + cast(@i as varchar))
end

--Ejecutar 10 veces un sp_1 solamente si el sentinela es 1

Declare @n as int = 10, @i int = 1

while @i<=@n
begin
print(@i);
set @i+=1
end

exec sp_1


alter proc sp_2
as
begin
Declare @n as int = 10, @i int = 1

while @i<=@n
begin
print(@i);
set @i+=1
end
end

exec sp_2

--Store procedure con parametros de entrada
create proc sp_3
@n int
as
begin
Declare @i int = 1
if @n > 0
begin

while @i<=@n
begin
print(@i);
set @i+=1
end
end
else 
begin
print('El valor de n debe ser mayor a 0')
end
end

exec sp_3 100

--Sumas de i
create proc sp_4
@n int
as
begin
Declare @i int = 1
Declare @acum int = 0
if @n > 0
begin

while @i<=@n
begin
set @acum += @i
print(@i);
set @i+=1
end
print('La suma de los numeros es: ' + cast(@acum as varchar))
end
else 
begin
print('El valor de n debe ser mayor a 0')
end
end

exec sp_4 3

--Seleccionar de la base de datos northwind todas las ordenes de compra para un año determinado

use NORTHWND

alter proc ordenesano
@f int
as
begin
select count(*) from Orders
where year(OrderDate) = @f
end

exec ordenesano 1996

select * from Orders

--crear un store procedure, que muestre el total de ventas($) para cada cliente por un rango de años 

alter proc ordenesano2
@f int,
@g int
as
begin
select c.CompanyName ,YEAR(o.OrderDate),sum(od.Quantity * od.UnitPrice) 
from [Order Details] as od
inner join Orders as o
on od.OrderID = o.OrderID
inner join Customers as c
on o.CustomerID = c.CustomerID
where year(OrderDate) between @f and @g
group by year(o.OrderDate),c.CompanyName
end



exec ordenesano2 1996, 1998

select * from customers