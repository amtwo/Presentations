-- SQL 2016+ ONLY!

--More Reading: http://am2.co/2016/06/t-sql-tuesday-79/


--/*
---- Initial setup:
USE master
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'CompressLOBs')
	DROP DATABASE CompressLOBs;
GO
CREATE DATABASE CompressLOBs;
GO
USE CompressLOBs
GO
SET NOCOUNT ON

CREATE TABLE dbo.Documents (
	DocID   int identity(1,1) PRIMARY KEY CLUSTERED,
	Cols    nchar(4000) DEFAULT 'x',
	DocText nvarchar(max)
)
GO

INSERT INTO dbo.Documents(DocText)
SELECT REPLICATE(NEWID(),100000)
GO 50000

---------------------------------
-- End Setup
---------------------------------


--*/


--Look at how big it is  (about 1GB)
EXEC sp_spaceused Documents

--How much space does compression save?  (about 20%)
ALTER INDEX ALL ON dbo.Documents REBUILD WITH (DATA_COMPRESSION=PAGE);
EXEC sp_spaceused Documents


--Create new table, replacing nvarchar(max) with varbinary(max)
CREATE TABLE dbo.DocumentsBase (
	DocID   int identity(1,1) PRIMARY KEY CLUSTERED,
	Cols    nchar(4000) DEFAULT 'x',
	CompressedDocText varbinary(max)
);

--Use COMPRESS() function to populate
SET IDENTITY_INSERT dbo.DocumentsBase ON;
INSERT INTO dbo.DocumentsBase (DocID, Cols, CompressedDocText)
SELECT DocID, Cols, COMPRESS(DocText)
FROM dbo.Documents;
SET IDENTITY_INSERT dbo.DocumentsBase OFF;

EXEC sp_spaceused Documents
EXEC sp_spaceused DocumentsBase


--Replace dbo.Documents with a view
EXEC sp_rename 'dbo.Documents','Documents_old';
GO

CREATE VIEW dbo.Documents
AS
SELECT DocID, Cols, DECOMPRESS(CompressedDocText) AS DocText
FROM dbo.DocumentsBase
GO

--How much space did we save?
ALTER INDEX ALL ON dbo.DocumentsBase REBUILD WITH (DATA_COMPRESSION=PAGE);
EXEC sp_spaceused DocumentsBase
EXEC sp_spaceused 'dbo.Documents_old'

set statistics time on

select DocText from dbo.[dbo.Documents_old]
select DECOMPRESS(CompressedDocText) FROM dbo.DocumentsBase




select *
from dbo.Documents



