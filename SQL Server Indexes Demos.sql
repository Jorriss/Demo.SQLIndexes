
USE StackOverflow_201401
GO

/*
IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ndx_Posts__Tags') DROP INDEX Posts.ndx_Posts__Tags;
IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ndx_Posts__Tags_OwnerUserId') DROP INDEX Posts.ndx_Posts__Tags_OwnerUserId;
IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ndx_Posts__OwnerUserId_Tags') DROP INDEX Posts.ndx_Posts__OwnerUserId_Tags;
IF EXISTS (SELECT name FROM sysindexes WHERE name = 'ndx_Posts__OwnerUserId__Tags') DROP INDEX Posts.ndx_Posts__OwnerUserId__Tags;

*/

DBCC DROPCLEANBUFFERS -- Removes all clean buffers from the buffer pool.
DBCC FREEPROCCACHE -- Removes all elements from the plan cache
GO

-- Posts table is 18 million rows
SELECT  p.Tags, p.Id
FROM    Posts p
WHERE   Tags = N'<sql-server>'
GO

-- Create Index on Tags
CREATE NONCLUSTERED INDEX ndx_Posts__Tags
 ON Posts (Tags) ON [PRIMARY]
GO

DBCC DROPCLEANBUFFERS 
GO

SELECT  p.Tags, p.Id
FROM    Posts p 
WHERE   Tags = N'<sql-server>'
GO


-------------------------------------------- 2
-- Key Lookups

DBCC DROPCLEANBUFFERS 
GO

-- Suggested Index
SELECT  p.Tags, p.Id, u.DisplayName
FROM    Posts    p
JOIN    Users    u ON p.OwnerUserId = u.Id
WHERE   Tags = N'<sql-server>'
GO

-- Create Index on Tags and OwnerUserId
CREATE NONCLUSTERED INDEX ndx_Posts__Tags_OwnerUserId
 ON Posts (Tags, OwnerUserId) ON [PRIMARY]
GO

SELECT  p.Tags, p.Id, u.DisplayName
FROM    Posts    p
JOIN    Users    u ON p.OwnerUserId = u.Id
WHERE   Tags = N'<sql-server>'
GO

-- Does Order Matter?
SELECT  p.Tags, p.Id, u.DisplayName
FROM    Posts    p
JOIN    Users    u ON p.OwnerUserId = u.Id
WHERE   OwnerUserId = 333082  -- cecilphillip
GO

CREATE NONCLUSTERED INDEX ndx_Posts__OwnerUserId
 ON Posts (OwnerUserId) ON [PRIMARY]
GO

-- Lookup
SELECT  p.Tags, p.Id, u.DisplayName
FROM    Posts    p
JOIN    Users    u ON p.OwnerUserId = u.Id
WHERE   OwnerUserId = 333082  -- cecilphillip
GO

DROP INDEX Posts.ndx_Posts__OwnerUserId
GO

-- Add Tags to the Index Key
CREATE NONCLUSTERED INDEX ndx_Posts__OwnerUserId_Tags
 ON Posts (OwnerUserId, Tags) ON [PRIMARY]
GO

SELECT  p.Tags, p.Id, u.DisplayName
FROM    Posts    p
JOIN    Users    u ON p.OwnerUserId = u.Id
WHERE   OwnerUserId = 333082  -- cecilphillip
GO

-- If not searching...

-- Use Includes
CREATE NONCLUSTERED INDEX ndx_Posts__OwnerUserId__Tags
 ON Posts (OwnerUserId) 
 INCLUDE (Tags) ON [PRIMARY]
GO

SELECT  p.Tags, p.Id, u.DisplayName
FROM    Posts    p
JOIN    Users    u ON p.OwnerUserId = u.Id
WHERE   OwnerUserId = 333082  -- cecilphillip
GO

-- Show depth difference
sp_SQLskills_SQL2012_helpindex Posts

SELECT index_id, index_type_desc, alloc_unit_type_desc, index_depth, index_level, page_count 
FROM sys.dm_db_index_physical_stats(DB_ID(), OBJECT_ID('Posts'), NULL, NULL, NULL)
WHERE index_id IN (6,7)

