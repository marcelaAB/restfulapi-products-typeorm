------Creacion de la tabla ejemplo1.Fact_Summary------------------------------
CREATE TABLE ejemplo1.Fact_Summary(
    CustomerID INT NULL,
    CustomerName NVARCHAR (200) NULL,
    SupplierID INT NULL,
    SupplierName nvarchar(200) NULL,
    Mes INT NULL,
    Anio INT NULL,
    Total INT NULL,
    SuperoPromedio INT,
    Porcentaje INT 
	)
	
Alter table ejemplo1.Fact_Summary
Alter COLUMN Porcentaje FLOAT NULL


----------Creacion de la tabla ejemplo.Settings------------ 

CREATE TABLE ejemplo1.Settings(
    Anio INT NULL
)




