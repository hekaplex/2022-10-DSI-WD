--DML = Data Mnipulation Language
/*
INSERT
UPDATE
DELETE
SELECT...INTO
*/
CREATE VIEW sample_view AS 
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
	;
	SELECT * from sample_view
	;

SELECT 
	DISTINCT
	V.VendorState
	,KS.[VendorID]
	,KS.[InvoiceNumber]
	--base table with a table alias
INTO sample_copy
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

select * from sample_copy

SELECT * INTO PaidInvoices_Drew from PaidInvoices where 1 =2
--INSERT all invoices that have numbers for InvoiceNumbers
SET IDENTITY_INSERT PaidInvoices_Drew OFF

INSERT
INTO PaidInvoices_Drew
(
--InvoiceID
--,
VendorID
,InvoiceNumber
,InvoiceDate
,InvoiceTotal
,PaymentTotal
,CreditTotal
,TermsID
,InvoiceDueDate
,PaymentDate
)
--VALUES((...),(...),...) OR
SELECT 
--InvoiceID
--,
VendorID
,InvoiceNumber
,InvoiceDate
,InvoiceTotal
,PaymentTotal
,CreditTotal
,TermsID
,InvoiceDueDate
,PaymentDate
from
--ALt-F1 in SSMS give you tabular view of the object
	PaidInvoices
	--shift -F1 in SSSMS take you to documentation
WHERE ISNUMERIC(InvoiceNumber) = 1


--DELETE FROM PaidInvoices_Drew
SELECT * FROM PaidInvoices_Drew

SET IDENTITY_INSERT PaidInvoices_Drew OFF

--REMOVE from PaidInvoices_Drew the "extra rows" = second set
-- the easy way that doesn;t always logically work: WHERE InvoiceID >= 115
--WHERE INvoiceID IN 
--(
--114
--,115
--,116
--,117
--,118
--,119
--)

DELETE 
FROM P
--SELECT
--*
FROM
PaidInvoices_Drew P
LEFT OUTER JOIN
PaidInvoices I
On P.InvoiceID = I.InvoiceID
WHERE I.InvoiceID IS NULL
--sanity check
SELECT * FROM PaidInvoices_Drew I
WHERE InvoiceID = 140

--UPDATE Dates 6 yr ahead for ones with identity preserved
UPDATE
P
--SELECT for sanity check
SET
 InvoiceDueDate = DATEADD(YEAR,6,P.InvoiceDueDate)
,PaymentDate =   DATEADD(YEAR,6,P.PaymentDate)
FROM
PaidInvoices_Drew P
LEFT OUTER JOIN
PaidInvoices I
On P.InvoiceID = I.InvoiceID
WHERE I.InvoiceID IS NOT NULL

SELECT * from PaidInvoices_Drew 

--USE AP

SELECT 
ia.InvoiceNumber 
,ic.InvoiceNumber
,ia.[PaymentDate]
FROM 
InvoiceArchive ia
FULL OUTER JOIN
InvoiceCopy ic
--exactly like ...FROM InvoiceCopy LEFT OUTER JOIN InvoiceArchive
ON ia.InvoiceNumber = ic.InvoiceNumber

DELETE InvoiceArchive  WHERE ISNUMERIC(InvoiceNumber) = 1

MERGE 
INTO 
--a lot like ...FROM   InvoiceCopy LEFT OUTER JOIN InvoiceArchive
--Master Copy for Analysis
InvoiceArchive ia
--Latest version from Production/Staging
USING InvoiceCopy ic
--exactly like ...FROM InvoiceCopy LEFT OUTER JOIN InvoiceArchive
ON ia.InvoiceNumber = ic.InvoiceNumber
--INNER JOIN = UPDATE
WHEN MATCHED 
--WHERE ON ia.InvoiceID IS NOT NULL AND  ic.InvoiceID IS NOT NULL 
	--AND ic.PaymentDate IS NOT NULL
	--AND ic.PaymentTotal > ia.PaymentTotal
	THEN 
		UPDATE SET
		ia.PaymentTotal = ic.PaymentTotal
		,ia.PaymentDate = GETDATE()
		,ia.CreditTotal = ic.CreditTotal
--LEFT OUTER JOIN WITH NULL FROM SOURCE = INSERT
WHEN NOT MATCHED 
--WHERE ON ia.InvoiceID IS NULL AND  ic.InvoiceID IS NOT NULL 
	THEN
		INSERT ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate])
		VALUES(ic.[InvoiceID], ic.[VendorID], ic.[InvoiceNumber], '10-07-22', ic.[InvoiceTotal], ic.[PaymentTotal], ic.[CreditTotal], ic.[TermsID], ic.[InvoiceDueDate])
--RIGHT OUTER JOIN = DELETE
;