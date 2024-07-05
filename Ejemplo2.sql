select ProductName,UnitPrice,UnitsInStock,
case Discontinued
when 0 then 'No disponoble'
when 1 then 'Disponible'
else 'No existente'
end as 'Disponibilidad'
from Products

select ProductName, UnitsInStock, UnitPrice,
case
when UnitPrice >=1 and UnitPrice <18 then 'Producto barato'
when UnitPrice >=18 and UnitPrice <=50 then 'Producto medio barato'
when UnitPrice between 51 and 100 then 'Producto caro'
else 'Crisimo'
end as 'Categoria de precios'
from Products
where ProductID in(29,31)

USE AdventureWorks2019

select BusinessEntityID,SalariedFlag 
from HumanResources.Employee
order by 
case SalariedFlag 
when 1 then BusinessEntityID
end desc,
case 
when SalariedFlag = 0 then BusinessEntityID
end asc;

select BusinessEntityID,
LastName,
TerritoryName,
CountryRegionName
from Sales.vSalesPerson
where TerritoryGroup is not null
order by 
case CountryRegionName
when 'United States' then TerritoryName
else CountryRegionName
end

--ISNULL
select v.AccountNumber,
v.Name,
v.PurchasingWebServiceURL as 'PurchasingWebServiceURL'
from [Purchasing].[Vendor] as v

select v.AccountNumber,
v.Name,
ISNULL(v.PurchasingWebServiceURL, 'No URL') as 'PurchasingWebServiceURL'
from [Purchasing].[Vendor] as v

select v.AccountNumber,
v.Name,
case 
when v.PurchasingWebServiceURL is null then 'No URL'
end
as 'PurchasingWebServiceURL'
from [Purchasing].[Vendor] as v

use AdventureWorks2019

--Funcion IIF

select iif(1=1,'Verdadero','Falso') as 'Resultado'
create view vista_genero
as
select e.LoginID,e.JobTitle,e.Gender,
iif(e.gender='F','Mujer','Hombre') as 'Sexo'
from
HumanResources.Employee as e;

select lower(JobTitle) as 'Titulo' from vista_genero
where Sexo='Mujer'

--Merge

select OBJECT_ID(N'tempdb..#StudentsC1')

IF OBJECT_ID (N'tempdb..#StudentsC1') is not NULL
begin
    drop table #StudentsC1;
end

CREATE TABLE #StudentsC1(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);

INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)




IF OBJECT_ID(N'tempdb..#StudentsC2') is not NULL
begin
drop table #StudentsC2
END


CREATE TABLE #StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);


INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1)

select * from #StudentsC1
select * from #StudentsC2

select * from #StudentsC1 as c1
inner join #StudentsC2 as c2
on c1.StudentID =c2.StudentID

select * from #StudentsC1 as c1
left join #StudentsC2 as c2
on c1.StudentID =c2.StudentID

select * from #StudentsC1 as c1
right join #StudentsC2 as c2
on c1.StudentID =c2.StudentID

insert into #StudentsC2(StudentID,StudentName,StudentStatus)
select c1.StudentID,c1.StudentName,c1.StudentStatus
from #StudentsC1 as c1
left join #StudentsC2 as c2
on c1.StudentID =c2.StudentID
where c2.StudentID is null

update c2
set c2.StudentName = c1.StudentName,
c2.StudentStatus = c1.StudentStatus
from #StudentsC1 as c1
inner join #StudentsC2 as c2
on c1.StudentID =c2.StudentID