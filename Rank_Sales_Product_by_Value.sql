SET DATEFORMAT YMD

SELECT
    RANK() OVER (ORDER BY Sales.Sequence_) AS Rank
    , PRD.Name
    , Sales.LineTotal
    , Sales.OrderQty
FROM (
        SELECT
            SOD.ProductID
            , ROW_NUMBER()OVER(ORDER BY SUM(SOD.LineTotal) DESC) Sequence_
            , SUM(SOD.LineTotal) AS LineTotal
            , SUM(SOD.OrderQty) AS OrderQty
        FROM [AdventureWorks2019].[Sales].[SalesOrderDetail] SOD WITH(NOLOCK)
            INNER JOIN [AdventureWorks2019].[Sales].[SalesOrderHeader] SOH WITH(NOLOCK)
                ON (SOD.SalesOrderID = SOH.SalesOrderID)
        WHERE SOH.OrderDate >= '2011-06-01 00:00:00'
            AND SOH.OrderDate <= '2011-06-30 23:59:59'
        GROUP BY SOD.ProductID
) Sales
INNER JOIN [AdventureWorks2019].[Production].[Product] PRD WITH(NOLOCK)
    ON (Sales.ProductID = PRD.ProductID)