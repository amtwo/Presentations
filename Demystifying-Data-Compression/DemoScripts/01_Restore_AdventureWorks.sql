USE master
GO
--Restore AdventureWorks three from the same backups
--We're going to compress two copies (ROW & PAGE), and leave one uncompressed

RESTORE DATABASE AdventureWorks2014
FROM DISK = 'C:\SQL\AdventureWorks2014.bak'
WITH MOVE 'AdventureWorks2014_Data' TO 'C:\SQL\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorks2014_Data.mdf'
    ,MOVE 'AdventureWorks2014_Log' TO 'C:\SQL\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorks2014_Log.ldf'
    ,REPLACE;

RESTORE DATABASE AdventureWorks2014_ROW
FROM DISK = 'C:\SQL\AdventureWorks2014.bak'
WITH MOVE 'AdventureWorks2014_Data' TO 'C:\SQL\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorks2014_ROW_Data.mdf'
    ,MOVE 'AdventureWorks2014_Log' TO 'C:\SQL\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorks2014_ROW_Log.ldf'
    ,REPLACE;


RESTORE DATABASE AdventureWorks2014_PAGE
FROM DISK = 'C:\SQL\AdventureWorks2014.bak'
WITH MOVE 'AdventureWorks2014_Data' TO 'C:\SQL\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorks2014_PAGE_Data.mdf'
    ,MOVE 'AdventureWorks2014_Log' TO 'C:\SQL\MSSQL13.MSSQLSERVER\MSSQL\DATA\AdventureWorks2014_PAGE_Log.ldf'
    ,REPLACE;

