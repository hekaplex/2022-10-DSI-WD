SELECT 
	DISTINCT
	V.VendorState
	,KS.[VendorID]
	,KS.[InvoiceNumber]
	--base table with a table alias
  FROM 
	[dbo].[Vendors] AS V
RIGHT OUTER JOIN
  -- box for query called [AP].[dbo].[KS_InvoiceArchive] 
  (
  --correlated table subquery
  --inline nested query in the middle
	  SELECT 
	[InvoiceID], [VendorID], [InvoiceNumber]
	FROM [dbo].[InvoiceArchive]
	WHERE InvoiceID BETWEEN 3 AND 8
  )
  AS KS
	--join criteria
	ON KS.VendorID = V. VendorID