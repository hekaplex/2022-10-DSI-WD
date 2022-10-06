SELECT
v.VendorCity
,SUM(I.InvoiceTotal)
FROM
Vendors V
join Invoices I
on v.VendorID = i.InvoiceID
group by v.VendorCity
