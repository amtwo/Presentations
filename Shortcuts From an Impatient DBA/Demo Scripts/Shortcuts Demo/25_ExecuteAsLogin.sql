--Drop & Re-create the demo login
IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'DemoAppLogin')
    DROP LOGIN DemoAppLogin;
GO
CREATE LOGIN DemoAppLogin WITH PASSWORD = 'DemoAppLogin', CHECK_POLICY=OFF;


--Try to select from AventureWorks table
EXECUTE AS LOGIN = 'DemoAppLogin'
SELECT TOP 10 *
FROM AdventureWorks2014.Person.Person;

REVERT;  --DON'T FORGET TO REVERT TO YOUR ORIGINAL SECURITY CONTEXT!
GO


--Grant SELECT on that table
USE AdventureWorks2014;
CREATE USER DemoAppLogin FROM LOGIN DemoAppLogin;
GO
GRANT SELECT ON AdventureWorks2014.Person.Person TO DemoAppLogin;
GO

--Try the SELECT again.
EXECUTE AS LOGIN = 'DemoAppLogin'
SELECT TOP 10 *
FROM AdventureWorks2014.Person.Person;

REVERT;  --DON'T FORGET TO REVERT TO YOUR ORIGINAL SECURITY CONTEXT!
GO