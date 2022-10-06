SELECT
	VendorID
	,  SUM(i.InvoiceTotal) SUM_InvoiceTotal
	,  AVG(i.InvoiceTotal) AVG_InvoiceTotal
	,  MIN(i.InvoiceTotal) MIN_InvoiceTotal
	,  MAX(i.InvoiceTotal) MAX_InvoiceTotal
	,  COUNT(*) QTY_InvoiceTotal
FROM
--table alias
	Vendors v
--inner join is default type of join
JOIN
	Invoices i
ON
	v.VendorID = i.VendorID
WHERE Vendorstate != 'TX'
GROUP BY 	
	VendorID
HAVING SUM(i.InvoiceTotal) >1000
ORDER BY
	2 DESC