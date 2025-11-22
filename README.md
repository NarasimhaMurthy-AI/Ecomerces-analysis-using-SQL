# 📊 Task 3 – SQL for Data Analysis

This README describes the SQL work completed using the **Ecomerces.xlsx** dataset, including data cleaning, joins, aggregations, and creation of a clean product table.

## 🧰 Tools Used
- SQL Server Management Studio (SSMS)
- SQL Server Express
- Excel (raw dataset)

## 📁 Dataset Columns
- InvoiceNo  
- StockCode  
- Description  
- Quantity  
- InvoiceDate  
- UnitPrice  
- CustomerID  
- Country  

## 🧹 Data Cleaning
A clean product catalog was created by removing invalid descriptions such as `?`, NULL, and empty strings.

```sql
SELECT 
    StockCode,
    MAX(CASE 
            WHEN Description <> '?' 
             AND Description IS NOT NULL
             AND Description <> ''
         THEN Description  
        END) AS CleanDescription
INTO CleanProducts
FROM Ecomerces$
GROUP BY StockCode;
```

Total clean products created: **3456**

## 🔗 SQL Joins
```sql
SELECT 
    e.StockCode,
    c.CleanDescription AS ProductName,
    e.Quantity,
    e.UnitPrice,
    (e.Quantity * e.UnitPrice) AS LineRevenue
FROM Ecomerces$ e
INNER JOIN CleanProducts c
    ON e.StockCode = c.StockCode;
```

## 📊 Aggregations
### Average spend per customer:
```sql
SELECT CustomerID,
       AVG(Quantity * UnitPrice) AS AvgSpend
FROM Ecomerces$
GROUP BY CustomerID;
```

### Revenue by country:
```sql
SELECT Country, SUM(Quantity * UnitPrice) AS TotalRevenue
FROM Ecomerces$
GROUP BY Country;
```

## 👁 Views
```sql
CREATE VIEW InvoiceRevenue AS
SELECT InvoiceNo, SUM(Quantity*UnitPrice) AS Revenue
FROM Ecomerces$
GROUP BY InvoiceNo;
```

## ⚡ Indexing
```sql
CREATE INDEX idx_customer ON Ecomerces$(CustomerID);
CREATE INDEX idx_stockcode ON Ecomerces$(StockCode);
```

## 📌 Summary
This task demonstrates:
- SQL data cleaning
- Aggregations & grouping
- Joining cleaned tables
- View creation
- Query performance optimization
