/*
USE CompressGUIDs
GO
SET NOCOUNT ON


--Create two tables, identical except compression levels
--Multiple GUID columns, this time with sequential values.
CREATE TABLE SequentialGUIDs (
    SomeID    tinyint,
    GUID1 uniqueidentifier DEFAULT NEWSEQUENTIALID(),
    GUID2 uniqueidentifier DEFAULT NEWSEQUENTIALID(),
    GUID3 uniqueidentifier DEFAULT NEWSEQUENTIALID(),
    CONSTRAINT PK_SeqGUIDs PRIMARY KEY CLUSTERED (GUID1) WITH (DATA_COMPRESSION = NONE)
);
CREATE TABLE SequentialGUIDs_ROW (
    SomeID    tinyint,
    GUID1 uniqueidentifier DEFAULT NEWSEQUENTIALID(),
    GUID2 uniqueidentifier DEFAULT NEWSEQUENTIALID(),
    GUID3 uniqueidentifier DEFAULT NEWSEQUENTIALID(),
    CONSTRAINT PK_SeqGUIDs_ROW PRIMARY KEY CLUSTERED (GUID1) WITH (DATA_COMPRESSION = ROW)
);
CREATE TABLE SequentialGUIDs_PAGE (
    SomeID    tinyint,
    GUID1 uniqueidentifier DEFAULT NEWSEQUENTIALID(),
    GUID2 uniqueidentifier DEFAULT NEWSEQUENTIALID(),
    GUID3 uniqueidentifier DEFAULT NEWSEQUENTIALID(),
    CONSTRAINT PK_SeqGUIDs_PAGE PRIMARY KEY CLUSTERED (GUID1) WITH (DATA_COMPRESSION = PAGE)
);
GO

--insert a bunch of data
--note runtimes will vary
INSERT INTO SequentialGUIDs (SomeID)
SELECT 1
FROM AdventureWorks2014.sys.objects o1, AdventureWorks2014.sys.objects o2
GO 20

INSERT INTO SequentialGUIDs_ROW (SomeID)
SELECT 1
FROM AdventureWorks2014.sys.objects o1, AdventureWorks2014.sys.objects o2
GO 20

INSERT INTO SequentialGUIDs_PAGE (SomeID)
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
--Run this in SentryOne Plan Explorer to get "actual plan" CPU & IO details  

--Do you think SEQUENTIAL GUIDs will make a difference in Compressability?

ALTER INDEX PK_SeqGUIDs      ON SequentialGUIDs      REBUILD WITH (DATA_COMPRESSION=NONE);
ALTER INDEX PK_SeqGUIDs_ROW  ON SequentialGUIDs_ROW  REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX PK_SeqGUIDs_PAGE ON SequentialGUIDs_PAGE REBUILD WITH (DATA_COMPRESSION=PAGE);


--Yes, the compressed index is bigger, and slower
EXEC sp_spaceused 'SequentialGUIDs'
EXEC sp_spaceused 'SequentialGUIDs_ROW'
EXEC sp_spaceused 'SequentialGUIDs_PAGE'


--Row compression makes the rows larger
--Page compression DOES save some space over ROW compression
--Uncompressed is still the smallest
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
                                    object_id('dbo.SequentialGUIDs'),
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
                                    object_id('dbo.SequentialGUIDs_ROW'),
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
                                    object_id('dbo.SequentialGUIDs_PAGE'),
                                    NULL,NULL,'Detailed') -- Have to use Detailed mode to get compression info
WHERE index_level = 0; --Only the leaf level of the index
