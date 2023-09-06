SET DATEFORMAT YMD

SELECT [DatabaseLogID]
      ,[PostTime]
      ,[Event]
      ,[Schema]
      ,[Object]
      ,[XmlEvent]
FROM [AdventureWorks2019].[dbo].[DatabaseLog] DBL
WHERE DBL.[XmlEvent].exist('//EVENT_INSTANCE/ObjectType/text()[contains(.,"PROCEDURE")]') = 1
    AND [PostTime] >= '2017-10-01 00:00:00'
    AND [PostTime] <= '2017-10-31 23:59:59'
ORDER BY [PostTime] 
 