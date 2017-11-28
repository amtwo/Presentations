SELECT MAX(backup_finish_date)
FROM msdb.dbo.backupset
WHERE type = 'D'