/*
SELECT o.name AS ObjectName
     , c.name AS ColumnName
FROM msdb.sys.objects o
JOIN msdb.sys.columns c
    ON c.object_id = o.object_id
WHERE o.name = 'sysjobs'
--*/