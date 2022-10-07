SELECT 
VendorName
--, VendorAddress1, VendorCity, VendorState, InvoiceNumber, InvoiceDate, InvoiceTotal, PaymentTotal
,Count (*)
From
Vendors Inner Join Invoices
on Vendors.VendorID = Invoices.VendorID
--Where InvoiceDate >= '2022-01-01'
group by VendorName 
order by vendorname--, invoicetotal asc;
