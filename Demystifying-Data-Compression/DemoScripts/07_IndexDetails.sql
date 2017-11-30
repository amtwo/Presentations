USE AdventureWorks2014_PAGE

--HumanResources.JobCandidate
SELECT DbName             = db_name(database_id) 
      ,TableName          = object_name(object_id,database_id) 
      ,IndexID            = index_id
      ,IndexType          = index_type_desc
      ,AllocUnitType      = alloc_unit_type_desc
      ,IndexSizeKB        = page_count * 8
      ,CompressedPages    = compressed_page_count
      ,UncompressedPages  = page_count - compressed_page_count
      ,AvgRecordSizeBytes = avg_record_size_in_bytes
FROM sys.dm_db_index_physical_stats(db_id('AdventureWorks2014_PAGE'),
                                    object_id('HumanResources.JobCandidate'),
                                    NULL,NULL,'Detailed') -- Have to use Detailed mode to get compression info
WHERE index_level = 0 --Only the leaf level of the index
ORDER BY compressed_page_count DESC, 
         page_count DESC;

--^^^^^^^^^^^^^^^^^^^^^^^
-- Look at number of uncompressed pages
-- What explains that?

SELECT *
FROM HumanResources.JobCandidate






--Production.vProductAndDescription
SELECT DbName             = db_name(database_id) 
      ,TableName          = object_name(object_id,database_id) 
      ,IndexID            = index_id
      ,IndexType          = index_type_desc
      ,AllocUnitType      = alloc_unit_type_desc
      ,IndexSizeKB        = page_count * 8
      ,CompressedPages    = compressed_page_count
      ,UncompressedPages  = page_count - compressed_page_count
      ,AvgRecordSizeBytes = avg_record_size_in_bytes
FROM sys.dm_db_index_physical_stats(db_id('AdventureWorks2014_PAGE'),
                                    object_id('Production.vProductAndDescription'),
                                    NULL,NULL,'Detailed') -- Have to use Detailed mode to get compression info
WHERE index_level = 0 --Only the leaf level of the index
ORDER BY compressed_page_count DESC, 
         page_count DESC;

--^^^^^^^^^^^^^^^^^^^^^^^
-- Look at number of uncompressed pages
-- What explains that?

SELECT *
FROM Production.vProductAndDescription


--Person.Person
SELECT DbName             = db_name(database_id) 
      ,TableName          = object_name(object_id,database_id) 
      ,IndexID            = index_id
      ,IndexType          = index_type_desc
      ,AllocUnitType      = alloc_unit_type_desc
      ,IndexSizeKB        = page_count * 8
      ,CompressedPages    = compressed_page_count
      ,UncompressedPages  = page_count - compressed_page_count
      ,AvgRecordSizeBytes = avg_record_size_in_bytes
FROM sys.dm_db_index_physical_stats(db_id('AdventureWorks2014_PAGE'),
                                    object_id('Person.Person'),
                                    NULL,NULL,'Detailed') -- Have to use Detailed mode to get compression info
WHERE index_level = 0 --Only the leaf level of the index
ORDER BY compressed_page_count DESC, 
         page_count DESC;


exec sp_helpindex3 'Person.Person'

select rowguid
from Person.Person
ORDER BY rowguid

         
         
--Sales.SalesOrderDetail
SELECT DbName             = db_name(database_id) 
      ,TableName          = object_name(object_id,database_id) 
      ,IndexID            = index_id
      ,IndexType          = index_type_desc
      ,AllocUnitType      = alloc_unit_type_desc
      ,IndexSizeKB        = page_count * 8
      ,CompressedPages    = compressed_page_count
      ,UncompressedPages  = page_count - compressed_page_count
      ,AvgRecordSizeBytes = avg_record_size_in_bytes
FROM sys.dm_db_index_physical_stats(db_id('AdventureWorks2014_PAGE'),
                                    object_id('Sales.SalesOrderDetail'),
                                    NULL,NULL,'Detailed') -- Have to use Detailed mode to get compression info
WHERE index_level = 0 --Only the leaf level of the index
ORDER BY compressed_page_count DESC, 
         page_count DESC;




--two indexes are mostly compressed
--one index didn't compress at all  (Index ID = 2)
--Lets look at the data
USE AdventureWorks2014_PAGE
EXEC dbo.sp_helpindex 'Sales.SalesOrderDetail'


USE AdventureWorks2014_PAGE
EXEC sp_helpindex3 'Sales.SalesOrderDetail'




SELECT rowguid, SalesOrderID, SalesOrderDetailID
FROM Sales.SalesOrderDetail
ORDER BY rowguid

SELECT ProductID, SalesOrderID, SalesOrderDetailID
FROM Sales.SalesOrderDetail
ORDER BY ProductID


--Lets compare the indexes across compression levels
USE AdventureWorks2014
EXEC sp_helpindex3 'Sales.SalesOrderDetail'
USE AdventureWorks2014_ROW
EXEC sp_helpindex3 'Sales.SalesOrderDetail'
USE AdventureWorks2014_PAGE
EXEC sp_helpindex3 'Sales.SalesOrderDetail'














--Yep. Compression makes it bigger
SELECT 3.875/3.555
-- 9% bigger!












