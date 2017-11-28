/*
USE master
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'CompressGUIDs')
	DROP DATABASE CompressGUIDs;
GO
CREATE DATABASE CompressGUIDs;
GO
USE CompressGUIDs
GO
SET NOCOUNT ON


--Create two tables, identical except compression levels
--Multiple GUID columns, with all sorts of random values
CREATE TABLE GUIDs (
    GUID1 uniqueidentifier,
    GUID2 uniqueidentifier,
    GUID3 uniqueidentifier,
    CONSTRAINT PK_GUIDs PRIMARY KEY CLUSTERED (GUID1) WITH (DATA_COMPRESSION = NONE)
);
CREATE TABLE GUIDs_PAGE (
    GUID1 uniqueidentifier,
    GUID2 uniqueidentifier,
    GUID3 uniqueidentifier,
    CONSTRAINT PK_GUIDs_PAGE PRIMARY KEY CLUSTERED (GUID1) WITH (DATA_COMPRESSION = PAGE)
);

GO

--insert a bunch of data
--note runtimes will vary

INSERT INTO GUIDs (GUID1, GUID2, GUID3)
SELECT NEWID(), NEWID(), NEWID()
FROM AdventureWorks2014.sys.objects o1, AdventureWorks2014.sys.objects o2
GO 20

INSERT INTO GUIDs_PAGE (GUID1, GUID2, GUID3)
SELECT NEWID(), NEWID(), NEWID()
FROM AdventureWorks2014.sys.objects o1, AdventureWorks2014.sys.objects o2
GO 20

--*/

USE CompressGUIDs
GO
SET NOCOUNT ON
SET STATISTICS TIME ON

--Rebuild the indexes
--Run statements separately a bunch of times for each table, and note the runtimes

--Run this in SentryOne Plan Explorer to get "actual plan" CPU & IO details  
ALTER INDEX PK_GUIDs      ON GUIDs      REBUILD WITH (DATA_COMPRESSION=NONE);

ALTER INDEX PK_GUIDs_PAGE ON GUIDS_PAGE REBUILD WITH (DATA_COMPRESSION=PAGE);









--Yes, the compressed index is bigger, and slower
EXEC sp_spaceused 'GUIDs_PAGE'
EXEC sp_spaceused 'GUIDs'







SELECT 510920/460168.0

--Row compression makes the rows larger
--Page compression won't save room, so it doesn't compress pages
SELECT DbName             = db_name(database_id) 
      ,TableName          = object_name(object_id,database_id) 
      ,IndexID            = index_id
      ,IndexType          = index_type_desc
      ,AllocUnitType      = alloc_unit_type_desc
      ,IndexSizeKB        = page_count * 8
      ,CompressedPages    = compressed_page_count
      ,UncompressedPages  = page_count - compressed_page_count
      ,AvgRecordSizeBytes = avg_record_size_in_bytes
FROM sys.dm_db_index_physical_stats(db_id('CompressGUIDs'),
                                    object_id('dbo.GUIDs'),
                                    NULL,NULL,'Detailed') -- Have to use Detailed mode to get compression info
WHERE index_level = 0; --Only the leaf level of the index
--
SELECT DbName             = db_name(database_id) 
      ,TableName          = object_name(object_id,database_id) 
      ,IndexID            = index_id
      ,IndexType          = index_type_desc
      ,AllocUnitType      = alloc_unit_type_desc
      ,IndexSizeKB        = page_count * 8
      ,CompressedPages    = compressed_page_count
      ,UncompressedPages  = page_count - compressed_page_count
      ,AvgRecordSizeBytes = avg_record_size_in_bytes
FROM sys.dm_db_index_physical_stats(db_id('CompressGUIDs'),
                                    object_id('dbo.GUIDs_PAGE'),
                                    NULL,NULL,'Detailed') -- Have to use Detailed mode to get compression info
WHERE index_level = 0; --Only the leaf level of the index

