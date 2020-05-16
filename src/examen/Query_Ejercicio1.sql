	SELECT 
		o.CustomerID,
		c.CustomerName,
		s.SupplierID,
		s.SupplierName,
		YEAR(o.OrderDate) as Anio,
		MONTH(o.OrderDate) as Mes,
		pro.Price * od.Quantity as Total
		AVG 

	FROM ejemplo1.OrderDetails as od
	INNER JOIN ejemplo1.Orders as o
	on od.OrderID = o.OrderID

	INNER JOIN ejemplo1.Products as pro
	on pro.ProductID = od.ProductID

	INNER JOIN ejemplo1.Suppliers as s
	on s.SupplierID = pro.SupplierID

	INNER JOIN ejemplo1.Customers as c
	on c.CustomerID = o.CustomerID
	ORDER BY c.CustomerID,s.SupplierID

