SELECT 
VendorName
--, VendorAddress1, VendorCity, VendorState, InvoiceNumber, InvoiceDate, InvoiceTotal, PaymentTotal
,Count (*) InvoiceQTY
,Sum (InvoiceTotal) TotalSales 
,round (
Sum (InvoiceTotal) 
/
Count (*) 
,2)AvgInvoice
From
Vendors Inner Join Invoices
on Vendors.VendorID = Invoices.VendorID
--Where InvoiceDate >= '2022-01-01'
group by VendorName 
order by 4--, invoicetotal asc;
