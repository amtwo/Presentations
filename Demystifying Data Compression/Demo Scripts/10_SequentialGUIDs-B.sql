/*
USE CompressGUIDs
GO
SET NOCOUNT ON

--Run everything together, except the final output

--Create two tables, identical except compression levels
--This time, a SINGLE GUID column
CREATE TABLE OneSequentialGUID (
    SomeID    tinyint,
    GUID1 uniqueidentifier DEFAULT NEWSEQUENTIALID(),
    CONSTRAINT PK_OneGUID PRIMARY KEY CLUSTERED (GUID1) WITH (DATA_COMPRESSION = NONE)
);
CREATE TABLE OneSequentialGUID_ROW (
    SomeID    tinyint,
    GUID1 uniqueidentifier DEFAULT NEWSEQUENTIALID(),
    CONSTRAINT PK_OneGUID_ROW PRIMARY KEY CLUSTERED (GUID1) WITH (DATA_COMPRESSION = ROW)
);
CREATE TABLE OneSequentialGUID_PAGE (
    SomeID    tinyint,
    GUID1 uniqueidentifier DEFAULT NEWSEQUENTIALID(),
    CONSTRAINT PK_OneGUID_PAGE PRIMARY KEY CLUSTERED (GUID1) WITH (DATA_COMPRESSION = PAGE)
);
GO

--insert a bunch of data
--note runtimes will vary
INSERT INTO OneSequentialGUID (SomeID)
SELECT 1
FROM AdventureWorks2014.sys.objects o1, AdventureWorks2014.sys.objects o2
GO 20

INSERT INTO OneSequentialGUID_ROW (SomeID)
SELECT 1
FROM AdventureWorks2014.sys.objects o1, AdventureWorks2014.sys.objects o2
GO 20

INSERT INTO OneSequentialGUID_PAGE (SomeID)
SELECT 1
FROM AdventureWorks2014.sys.objects o1, AdventureWorks2014.sys.objects o2
GO 20

--*/
USE CompressGUIDs
GO
SET NOCOUNT ON
SET STATISTICS TIME ON


--Rebuild the indexes
--Run statements separately a bunch of times for each table, and note the runtimes
ALTER INDEX PK_OneGUID      ON OneSequentialGUID      REBUILD WITH (DATA_COMPRESSION=NONE);
ALTER INDEX PK_OneGUID_ROW  ON OneSequentialGUID_ROW  REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX PK_OneGUID_PAGE ON OneSequentialGUID_PAGE REBUILD WITH (DATA_COMPRESSION=PAGE);




--Do you think SEQUENTIAL GUIDs will make a difference in Compressability?

EXEC sp_spaceused 'OneSequentialGUID'
EXEC sp_spaceused 'OneSequentialGUID_ROW'
EXEC sp_spaceused 'OneSequentialGUID_PAGE'

--
----
----
----


--SPOILER ALERT


----
----
----
--
--Row compression makes the rows larger
--This time, PAGE compression wins
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
                                    object_id('dbo.OneSequentialGUID'),
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
                                    object_id('dbo.OneSequentialGUID_ROW'),
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
                                    object_id('dbo.OneSequentialGUID_PAGE'),
                                    NULL,NULL,'Detailed') -- Have to use Detailed mode to get compression info
WHERE index_level = 0; --Only the leaf level of the index
