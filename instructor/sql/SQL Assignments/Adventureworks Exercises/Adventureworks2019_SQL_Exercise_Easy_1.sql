--How many items with ListPrice more than $1000 have been sold? --
SELECT
	[ListPrice]
FROM 
	Production.ProductListPriceHistory
WHERE 
	LISTPRICE > 1000
