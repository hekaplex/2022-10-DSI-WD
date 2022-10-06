--identify vendor from CA
/*select
VendorID, InvoiceTotal, BalanceDue
from
OutstandingInvoices
where InvoiceTotal<100
and BalanceDue<100*/

select
VendorID,VendorState
from
dbo.VendorCopy
where
VendorState = 'CA'

select
*
from
dbo.InvoiceCopy

select
VendorID, InvoiceNumber
from
dbo.InvoiceCopy
where InvoiceDueDate='2016-01-16 00:00:00'
order by VendorID asc

