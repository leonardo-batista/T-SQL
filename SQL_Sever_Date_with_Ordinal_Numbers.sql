/*
Date with Ordinal Numbers (st, nd, rd and th).
*/
SELECT
    FORMAT(SOH.[OrderDate],'d'
        + IIF(DAY(SOH.[OrderDate]) IN (1,21,31),'''st'''
        , IIF(DAY(SOH.[OrderDate]) IN (2,22),'''nd'''
        , IIF(DAY(SOH.[OrderDate]) IN (3,23),'''rd''','''th''')))
        + ' MMMM yyyy') AS OrderDate
    , SOH.[SalesOrderNumber]
    , SOH.[AccountNumber]
    , [OrderQty]
    , PRD.[ProductID]
    , PRD.[Name]
    , PRD.[ProductNumber]
    , [UnitPrice]
    , [UnitPriceDiscount]
    , [LineTotal]
  FROM [AdventureWorks2019].[Sales].[SalesOrderDetail] AS SOD WITH(NOLOCK)
    INNER JOIN [AdventureWorks2019].[Production].[Product] AS PRD WITH(NOLOCK)
        ON (SOD.[ProductID] = PRD.[ProductID])
    INNER JOIN [AdventureWorks2019].[Sales].[SalesOrderHeader] AS SOH WITH(NOLOCK)
        ON (SOD.[SalesOrderID] = SOH.[SalesOrderID])
  WHERE FORMAT(SOH.[OrderDate],'yyyy-MM-dd') >= '2011-06-01'
  AND FORMAT(SOH.[OrderDate],'yyyy-MM-dd') <= '2011-06-30'