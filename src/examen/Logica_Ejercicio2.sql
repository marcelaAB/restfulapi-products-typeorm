
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE ejemplo1.SP_Ejercicio2
AS
BEGIN
DECLARE @Anio INT


If @Anio= NULL  BEGIN
SET @Anio = (SELECT Anio from ejemplo1.Settings); 

INSERT INTO ejemplo1.Fact_Summary

SELECT 
	c.CustomerID,
	c.CustomerName,
	s.SupplierID,
	s.SupplierName,
	month(o.OrderDate) AS mes,
	year(o.OrderDate) AS Anio,
	(od.Quantity*p.Price) AS Total,
CASE
    WHEN  (od.Quantity*p.Price) > spm.Prom_Avg THEN '1'
    WHEN  (od.Quantity*p.Price) < spm.Prom_Avg THEN '0'
	END AS SuperoPromedio,
	((od.Quantity)*(p.Price))/cm.totalfacturadomes AS PorcentajeVentaMensual
	--cm.totalfacturadomes

FROM ejemplo1.OrderDetails AS od
INNER JOIN ejemplo1.Orders AS o 
on od.OrderID = o.OrderID
INNER JOIN ejemplo1.Products AS p
on p.ProductID = od.ProductID
INNER JOIN ejemplo1.Suppliers AS s
on s.SupplierID = p.SupplierID
INNER JOIN ejemplo1.Customers AS c
on c.CustomerID = o.CustomerID
INNER JOIN Suppxmes AS spm
ON s.SupplierID=spm.SupplierID
INNER JOIN Cxmes AS cm
ON c.CustomerID=cm.CustomerID
ORDER BY c.CustomerName, s.SupplierID


ORDER BY c.CustomerName, s.SupplierID,Anio

END
GO
