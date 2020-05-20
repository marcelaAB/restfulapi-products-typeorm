; WITH Suppxmes AS(
SELECT DISTINCT
s.SupplierID,
AVG(p.Price*od.Quantity) AS Prom_Avg
	
FROM ejemplo1.OrderDetails AS od
INNER JOIN ejemplo1.Orders AS o ON od.OrderID = o.OrderID
INNER JOIN ejemplo1.Products AS p ON p.ProductID = od.ProductID
INNER JOIN ejemplo1.Suppliers AS s ON s.SupplierID = p.SupplierID
GROUP BY
s.SupplierID
	)
--Fin CTE

--Consulta original
SELECT 
    o.CustomerID,
    c.CustomerName,
    s.SupplierID,
    s.SupplierName,
	month(o.OrderDate) as mes,
    year(o.OrderDate) as Anio,
    p.Price*od.Quantity as total,
	CASE
		WHEN  p.Price*od.Quantity > spm.Prom_Avg THEN '1'
		WHEN  p.Price*od.Quantity < spm.Prom_Avg THEN '0'
	END AS SuperoPromedio,
	(p.Price*od.Quantity/
		(
			SELECT 
				SUM(odt.Quantity*pd.Price) totalfacturadomes
			FROM ejemplo1.OrderDetails AS odt 
			INNER JOIN ejemplo1.Orders AS o1
			on odt.OrderID = o1.OrderID
			INNER JOIN ejemplo1.Products AS pd
			on pd.ProductID = odt.ProductID
			INNER JOIN ejemplo1.Customers AS c1
			on c1.CustomerID = o1.CustomerID
			WHERE
				c1.CustomerID=o.CustomerID 
				AND
				MONTH(o.OrderDate)=MONTH(o1.OrderDate)
		)
	) AS PorcentajeVentaMensual	

FROM ejemplo1.OrderDetails as od
INNER JOIN ejemplo1.Orders as o
on od.OrderID = o.OrderID
INNER JOIN ejemplo1.Products as p
on p.ProductID = od.ProductID
INNER JOIN ejemplo1.Suppliers as s
on s.SupplierID = p.SupplierID
INNER JOIN ejemplo1.Customers as c
on c.CustomerID = o.CustomerID
INNER JOIN Suppxmes AS spm
ON s.SupplierID=spm.SupplierID
ORDER BY 
    o.CustomerID,s.SupplierID