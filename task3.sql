--using select statement


select * from Ecomerces$

--using top

SELECT top 10 InvoiceNo, Description, Quantity FROM [Ecomerces$];

--where key

select top 10 * from Ecomerces$ where Country='united kingdom'

--orderby
select Description,unitprice from Ecomerces$ order by UnitPrice desc;

--group by

select country , SUM(quantity * unitprice) as totalRevenue from Ecomerces$ group by Country

--aggrigate functions

select customerid, AVG(quantity * unitprice) as avgspend from Ecomerces$ group by CustomerID

--joins- 
SELECT 
    e.StockCode,
    c.CleanDescription,
    e.Quantity,
    e.UnitPrice,
    e.Quantity * e.UnitPrice AS LineRevenue
FROM Ecomerces$ e
INNER JOIN CleanProducts c 
    ON e.StockCode = c.StockCode;

--Subquery
SELECT CustomerID, SUM(Quantity * UnitPrice) AS TotalSpent
FROM [Ecomerces$]
GROUP BY CustomerID
HAVING SUM(Quantity * UnitPrice) >
   (SELECT AVG(sub.TotalSpent) FROM (SELECT CustomerID, SUM(Quantity*UnitPrice) AS TotalSpent FROM [Ecomerces$] GROUP BY CustomerID) sub);


--invocie revenue

CREATE VIEW invoice_revenue AS
SELECT InvoiceNo, SUM(Quantity * UnitPrice) AS InvoiceRevenue
FROM [Ecomerces$]
GROUP BY InvoiceNo;

--index suggestion
CREATE INDEX idx_ecom_customer ON [Ecomerces$](CustomerID);
CREATE INDEX idx_ecom_stock ON [Ecomerces$](StockCode);








