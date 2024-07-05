create database puebacargadinamica

use puebacargadinamica

select EmployeeID,FirstName,LastName,[Address],homephone,Country 
into puebacargadinamica.dbo.empleado
from NORTHWND.dbo.Employees

insert into puebacargadinamica.dbo.empleado (FirstName,LastName,[Address],
HomePhone,Country)
select EmployeeID,FirstName,LastName,[Address],homephone,Country 
from NORTHWND.dbo.Employees
where EmployeeID is null


select * from empleado 

select top 0 EmployeeID,
concat(FirstName,' ',LastName) as 'Nombre',
[Address],
homephone,
Country 
into puebacargadinamica.dbo.[Dim_Empleado]
from puebacargadinamica.dbo.Empleado;


insert into puebacargadinamica.dbo.[Dim_Empleado] (Nombre, Address, homephone, Country)
select concat(e.FirstName,' ',e.LastName) as 'Nombre',
e.[Address],
e.homephone,
e.Country 
from empleado as e
left join Dim_Empleado as de
on e.EmployeeID = de.EmployeeID
where de.EmployeeID is null;




select * from Dim_Empleado

truncate table Dim_Empleado


select *
from empleado as e
full join Dim_Empleado as de
on e.EmployeeID = de.EmployeeID;