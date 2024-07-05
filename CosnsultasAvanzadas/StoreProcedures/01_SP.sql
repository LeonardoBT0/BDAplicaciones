use NORTHWND

--Declaracion de una variable

declare @numeroCal int
declare @calif decimal(10,2)

--Asignacion  de variables

set @numeroCal = 10

if @numeroCal<=0
begin
set @numeroCal = 1
end
declare @i = 1
while (@i <= @numeroCal)
begin
set  @calif = @calif + 10
set @i = @i + 1
end
set @calif = @calif/@numeroCal
print('El resultado es: ' + @calif)