--correlated subquery nesting
SELECT
x.Department
,SUM(x.[SUM_RATE]) [SUM_RATE]
FROM
(
	SELECT
		--sum(
		HumanResources.EmployeePayHistory.Rate
		 as [SUM_RATE]		,
		HumanResources.vEmployeeDepartment.Department  
	FROM
		HumanResources.vEmployeeDepartment
	JOIN
		HumanResources.EmployeePayHistory
	ON
		HumanResources.EmployeePayHistory.BusinessEntityID
		=
		HumanResources.vEmployeeDepartment.BusinessEntityID	
) 
	x
GROUP BY x.Department;

--Common Table Expression (CTE)
WITH
	d
		AS
		(
			SELECT
			*
			FROM
			HumanResources.vEmployeeDepartment
		)
,
	x
		AS
	(
		SELECT
			P.Rate
			 as [SUM_RATE]		,
			d.Department  
		FROM
			d
		JOIN
			HumanResources.EmployeePayHistory as P
		ON
			P.BusinessEntityID
			=
			d.BusinessEntityID	
	) 
SELECT
x.Department
,SUM(x.[SUM_RATE]) [SUM_RATE]
FROM x
GROUP BY x.Department

select * from rateSample


CREATE VIEW rateSample as
SELECT
x.Department
,SUM(x.[SUM_RATE]) [SUM_RATE]
FROM
(
	SELECT
		--sum(
		HumanResources.EmployeePayHistory.Rate
		 as [SUM_RATE]		,
		HumanResources.vEmployeeDepartment.Department  
	FROM
		HumanResources.vEmployeeDepartment
	JOIN
		HumanResources.EmployeePayHistory
	ON
		HumanResources.EmployeePayHistory.BusinessEntityID
		=
		HumanResources.vEmployeeDepartment.BusinessEntityID	
) 
	x
GROUP BY x.Department


select * from rateSample