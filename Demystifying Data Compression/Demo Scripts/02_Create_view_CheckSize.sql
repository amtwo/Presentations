USE AdventureWorks2014
GO
CREATE VIEW dbo.ObjectSize
AS
SELECT DatabaseName    = 'AdventureWorks2014',
       ObjectName      = o.name, 
       IndexName       = i.name,
       PageType        = au.type_desc,
       CompressionType = p.data_compression_desc, 
       NumberRows      = p.rows, 
       TotalPages      = au.total_pages, 
       TotalSizeKB     = au.total_pages*8
FROM sys.objects o
JOIN sys.indexes i ON i.object_id = o.object_id
JOIN sys.partitions p ON o.object_id = p.object_id AND i.index_id = p.index_id
JOIN sys.allocation_units au ON p.hobt_id = au.container_id;
GO
--
--
USE AdventureWorks2014_ROW
GO
CREATE VIEW dbo.ObjectSize
AS
SELECT DatabaseName    = 'AdventureWorks2014_ROW',
       ObjectName      = o.name, 
       IndexName       = i.name,
       PageType        = au.type_desc,
       CompressionType = p.data_compression_desc, 
       NumberRows      = p.rows, 
       TotalPages      = au.total_pages, 
       TotalSizeKB     = au.total_pages*8
FROM sys.objects o
JOIN sys.indexes i ON i.object_id = o.object_id
JOIN sys.partitions p ON o.object_id = p.object_id AND i.index_id = p.index_id
JOIN sys.allocation_units au ON p.hobt_id = au.container_id;
GO
--
--
USE AdventureWorks2014_PAGE
GO
CREATE VIEW dbo.ObjectSize
AS
SELECT DatabaseName    = 'AdventureWorks2014_PAGE',
       ObjectName      = o.name, 
       IndexName       = i.name,
       PageType        = au.type_desc,
       CompressionType = p.data_compression_desc, 
       NumberRows      = p.rows, 
       TotalPages      = au.total_pages, 
       TotalSizeKB     = au.total_pages*8
FROM sys.objects o
JOIN sys.indexes i ON i.object_id = o.object_id
JOIN sys.partitions p ON o.object_id = p.object_id AND i.index_id = p.index_id
JOIN sys.allocation_units au ON p.hobt_id = au.container_id;
GO
--
--
--Look at Space used for Entire DB
--You could use sp_spaceused, too.
SELECT DatabaseName,   
       NumberRows      = SUM(NumberRows), 
       TotalPages      = SUM(TotalPages), 
       TotalSizeKB     = SUM(TotalSizeKB)
FROM AdventureWorks2014.dbo.ObjectSize
GROUP BY DatabaseName
UNION ALL
SELECT DatabaseName,   
       NumberRows      = SUM(NumberRows), 
       TotalPages      = SUM(TotalPages), 
       TotalSizeKB     = SUM(TotalSizeKB)
FROM AdventureWorks2014_ROW.dbo.ObjectSize
GROUP BY DatabaseName
UNION ALL
SELECT DatabaseName,   
       NumberRows      = SUM(NumberRows), 
       TotalPages      = SUM(TotalPages), 
       TotalSizeKB     = SUM(TotalSizeKB)
FROM AdventureWorks2014_PAGE.dbo.ObjectSize
GROUP BY DatabaseName
ORDER BY TotalSizeKB DESC;
