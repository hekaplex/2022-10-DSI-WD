--- A "Single Item Order"is a customer order when only one item --
-- is ordered. Show the SalesOrderID and the UnitPrice for 
--every Single Item Order.

SELECT
	DISTINCT
	OrderQTY AS SingleItemOrder
	,SalesOrderID 
	,UnitPrice
FROM
	Sales.SalesOrderDetail
WHERE 
	OrderQTY = 1
--RESULTS --
