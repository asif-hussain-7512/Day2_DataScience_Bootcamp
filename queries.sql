-- ===========================================
-- Northwind Database SQL Analysis
-- Epochs '26 - Assignment 2
-- ===========================================


------------------------------------------------
-- 1. Top 10 Selling Products
------------------------------------------------

SELECT
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS TotalSold
FROM Products p
JOIN "Order Details" od
ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSold DESC
LIMIT 10;


------------------------------------------------
-- 2. Top 10 Customers by Revenue
------------------------------------------------

SELECT
    c.CustomerID,
    c.CompanyName,
    ROUND(
        SUM(
            od.UnitPrice *
            od.Quantity *
            (1 - od.Discount)
        ),
        2
    ) AS Revenue
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
JOIN "Order Details" od
ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY Revenue DESC
LIMIT 10;


------------------------------------------------
-- 3. Monthly Sales Trend
------------------------------------------------

SELECT
    strftime('%Y-%m', o.OrderDate) AS Month,
    ROUND(
        SUM(
            od.UnitPrice *
            od.Quantity *
            (1 - od.Discount)
        ),
        2
    ) AS MonthlySales
FROM Orders o
JOIN "Order Details" od
ON o.OrderID = od.OrderID
GROUP BY Month
ORDER BY Month;


------------------------------------------------
-- 4. Best Performing Categories
------------------------------------------------

SELECT
    c.CategoryName,
    ROUND(
        SUM(
            od.UnitPrice *
            od.Quantity *
            (1 - od.Discount)
        ),
        2
    ) AS Revenue
FROM Categories c
JOIN Products p
ON c.CategoryID = p.CategoryID
JOIN "Order Details" od
ON p.ProductID = od.ProductID
GROUP BY c.CategoryName
ORDER BY Revenue DESC;


------------------------------------------------
-- 5. Customer Purchase Frequency
------------------------------------------------

SELECT
    c.CustomerID,
    c.CompanyName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY TotalOrders DESC;


------------------------------------------------
-- 6. Total Revenue
------------------------------------------------

SELECT
ROUND(
SUM(
od.UnitPrice *
od.Quantity *
(1-od.Discount)
),2
) AS TotalRevenue
FROM "Order Details" od;


------------------------------------------------
-- 7. Total Orders
------------------------------------------------

SELECT
COUNT(*) AS TotalOrders
FROM Orders;


------------------------------------------------
-- 8. Average Order Value
------------------------------------------------

SELECT
ROUND(
AVG(OrderTotal),
2
) AS AverageOrderValue
FROM
(
SELECT
o.OrderID,
SUM(
od.UnitPrice *
od.Quantity *
(1-od.Discount)
) AS OrderTotal
FROM Orders o
JOIN "Order Details" od
ON o.OrderID=od.OrderID
GROUP BY o.OrderID
);


------------------------------------------------
-- 9. Top 10 Employees by Sales
------------------------------------------------

SELECT
e.FirstName || ' ' || e.LastName AS Employee,
ROUND(
SUM(
od.UnitPrice *
od.Quantity *
(1-od.Discount)
),
2
) AS Revenue
FROM Employees e
JOIN Orders o
ON e.EmployeeID=o.EmployeeID
JOIN "Order Details" od
ON o.OrderID=od.OrderID
GROUP BY Employee
ORDER BY Revenue DESC
LIMIT 10;


------------------------------------------------
-- 10. Top 10 Suppliers by Revenue
------------------------------------------------

SELECT
s.CompanyName,
ROUND(
SUM(
od.UnitPrice *
od.Quantity *
(1-od.Discount)
),
2
) AS Revenue
FROM Suppliers s
JOIN Products p
ON s.SupplierID=p.SupplierID
JOIN "Order Details" od
ON p.ProductID=od.ProductID
GROUP BY s.CompanyName
ORDER BY Revenue DESC
LIMIT 10;