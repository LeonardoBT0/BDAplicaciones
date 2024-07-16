--E	jerccio 2:Insertar una venta

create or alter proc spu_agregar_venta
 @CustomerID nchar(5),
           @EmployeeID int,
           @OrderDate datetime,
           @RequiredDate datetime,
           @ShippedDate datetime,
           @ShipVia int,
           @Freight money =null,
           @ShipName nvarchar(40)=null,
           @ShipAddress nvarchar(60)=null,
           @ShipCity nvarchar(15)=null,
           @ShipRegion nvarchar(15)=null,
           @ShipPostalCode nvarchar(10)=null,
           @ShipCountry nvarchar(15) =null,
           @ProductID int,
           @Quantity smallint,
           @Discount real = 0

		   as
		   begin
		   begin transaction
			begin try
			INSERT INTO [dbo].[Orders]
           ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry])
     VALUES
          (@CustomerID,     
		   @EmployeeID,
           @OrderDate ,
           @RequiredDate ,
           @ShippedDate,
           @ShipVia,
           @Freight,
           @ShipName,
           @ShipAddress,
           @ShipCity,
           @ShipRegion,
           @ShipPostalCode,
           @ShipCountry)

		   --Obtener el id insertado en orders
		   declare @orderID int
		   set @orderID = SCOPE_IDENTITY()

		   --Obtener el rpecio del producto
		   declare @precioVenta money
		   select unitprice from Products
		   where ProductID = @ProductID

		   --Insertar en order details
		   INSERT INTO [dbo].[Order Details]
           ([OrderID]
		   ,[ProductID]
           ,[UnitPrice]
           ,[Quantity]
           ,[Discount])
     VALUES
           (@orderID,
		   @ProductID,
           @precioVenta,
           @Quantity,
           @Discount)
		   --Actualizaf la tabla products en el campo unitSrock
		   update Products
		   set UnitsInStock = UnitsInStock - @Quantity
		   where ProductID = @ProductID
		   commit transaction;
			end try

			begin catch
			rollback transaction
			declare @mensajeError nvarchar(4000)
			set @mensajeError = ERROR_MESSAGE();
			print @mensajeError
			end catch
			end





		   INSERT INTO [dbo].[Orders]
           ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry])
     VALUES
           (<CustomerID, nchar(5),>
           ,<EmployeeID, int,>
           ,<OrderDate, datetime,>
           ,<RequiredDate, datetime,>
           ,<ShippedDate, datetime,>
           ,<ShipVia, int,>
           ,<Freight, money,>
           ,<ShipName, nvarchar(40),>
           ,<ShipAddress, nvarchar(60),>
           ,<ShipCity, nvarchar(15),>
           ,<ShipRegion, nvarchar(15),>
           ,<ShipPostalCode, nvarchar(10),>
           ,<ShipCountry, nvarchar(15),>)
GO

INSERT INTO [dbo].[Order Details]
           ([OrderID]
           ,[ProductID]
           ,[UnitPrice]
           ,[Quantity]
           ,[Discount])
     VALUES
           (<OrderID, int,>
           ,<ProductID, int,>
           ,<UnitPrice, money,>
           ,<Quantity, smallint,>
           ,<Discount, real,>)
GO