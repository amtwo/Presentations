--Look at Space used for Entire DB
--You could use sp_spaceused, too.
SELECT DatabaseName,   
       TotalPages      = SUM(TotalPages), 
       TotalSizeKB     = SUM(TotalSizeKB)
FROM AdventureWorks2014.dbo.ObjectSize
GROUP BY DatabaseName
UNION ALL
SELECT DatabaseName,   
       TotalPages      = SUM(TotalPages), 
       TotalSizeKB     = SUM(TotalSizeKB)
FROM AdventureWorks2014_ROW.dbo.ObjectSize
GROUP BY DatabaseName
UNION ALL
SELECT DatabaseName,   
       TotalPages      = SUM(TotalPages), 
       TotalSizeKB     = SUM(TotalSizeKB)
FROM AdventureWorks2014_PAGE.dbo.ObjectSize
GROUP BY DatabaseName
ORDER BY TotalSizeKB DESC;



--Look at Space used for some specific tables
--
--Sales.SalesOrderDetail
--Person.Person
--HumanResources.JobCandidate
--Production.vProductAndDescription
SELECT DatabaseName, ObjectName, TotalSizeKB = SUM(TotalSizeKB)
FROM AdventureWorks2014.dbo.ObjectSize      
WHERE ObjectName IN ('SalesOrderDetail','Person','JobCandidate','vProductAndDescription')
GROUP BY DatabaseName, ObjectName
UNION
SELECT DatabaseName, ObjectName, TotalSizeKB = SUM(TotalSizeKB)
FROM AdventureWorks2014_ROW.dbo.ObjectSize      
WHERE ObjectName IN ('SalesOrderDetail','Person','JobCandidate','vProductAndDescription')
GROUP BY DatabaseName, ObjectName
UNION
SELECT DatabaseName, ObjectName, TotalSizeKB = SUM(TotalSizeKB)
FROM AdventureWorks2014_PAGE.dbo.ObjectSize      
WHERE ObjectName IN ('SalesOrderDetail','Person','JobCandidate','vProductAndDescription')
GROUP BY DatabaseName, ObjectName
ORDER BY ObjectName, TotalSizeKb DESC

