SET DATEFORMAT YMD

SELECT
    CONVERT(VARCHAR, SOH.OrderDate, 23) AS OrderDate
    , SUM(SOD.OrderQty) AS OrderQty
    , SUM(SOD.LineTotal) AS LineTotal
FROM [AdventureWorks2019].[Sales].[SalesOrderDetail] SOD WITH(NOLOCK)
    INNER JOIN [AdventureWorks2019].[Production].[Product] PRD WITH(NOLOCK)
        ON (SOD.ProductID = PRD.ProductID)
    INNER JOIN [AdventureWorks2019].[Sales].[SalesOrderHeader] SOH WITH(NOLOCK)
        ON (SOD.SalesOrderID = SOH.SalesOrderID)
WHERE SOH.OrderDate >= '2011-06-01 00:00:00'
    AND SOH.OrderDate <= '2011-06-30 23:59:59'
GROUP BY SOH.OrderDate
ORDER BY SOH.OrderDate