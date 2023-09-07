SET DATEFORMAT YMD

 SELECT
    ROW_NUMBER()OVER(ORDER BY SUM(SOD.LineTotal) DESC) Rank
    , PRD.Name
    , SUM(SOD.LineTotal) AS LineTotal
    , SUM(SOD.OrderQty) AS OrderQty
FROM [AdventureWorks2019].[Sales].[SalesOrderDetail] SOD WITH(NOLOCK)
    INNER JOIN [AdventureWorks2019].[Sales].[SalesOrderHeader] SOH WITH(NOLOCK)
        ON (SOD.SalesOrderID = SOH.SalesOrderID)
    INNER JOIN [AdventureWorks2019].[Production].[Product] PRD WITH(NOLOCK)
        ON (SOD.ProductID = PRD.ProductID)
WHERE SOH.OrderDate >= '2011-06-01 00:00:00'
    AND SOH.OrderDate <= '2011-06-30 23:59:59'
GROUP BY SOD.ProductID, PRD.Name
