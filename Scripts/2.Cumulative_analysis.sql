-- PURPOSE: Perform cumulative (running total) analysis of sales over time

-- 1. Cumulative sales by year
SELECT
    Order_year,
    Total_sales,
    SUM(total_sales) OVER (ORDER BY Order_year) AS running_total_sales
FROM (
    SELECT 
        YEAR(order_date) AS Order_year,
        SUM(sales) AS Total_Sales
    FROM gold.dim_sales
    WHERE YEAR(order_date) IS NOT NULL
    GROUP BY YEAR(order_date)
) s;

-- 2. Cumulative sales by month across all years
SELECT
    Order_month,
    Total_sales,
    SUM(total_sales) OVER (ORDER BY Order_month) AS running_total_sales
FROM (
    SELECT 
        MONTH(order_date) AS Order_month,
        SUM(sales) AS Total_Sales
    FROM gold.dim_sales
    WHERE YEAR(order_date) IS NOT NULL
    GROUP BY MONTH(order_date)
) s;

-- 3. Cumulative sales by full month (year + month)
SELECT
    Order_date,
    Total_sales,
    SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales
FROM (
    SELECT 
        DATETRUNC(month, order_date) AS Order_date,
        SUM(sales) AS Total_Sales
    FROM gold.dim_sales
    WHERE DATETRUNC(month, order_date) IS NOT NULL
    GROUP BY DATETRUNC(month, order_date)
) s;

-- 4. Cumulative sales by month within each year
SELECT
    Order_date,
    Total_sales,
    SUM(Total_sales) OVER (PARTITION BY YEAR(Order_date) ORDER BY Order_date) AS running_total_sales
FROM (
    SELECT 
        DATETRUNC(month, order_date) AS Order_date,
        SUM(sales) AS Total_Sales
    FROM gold.dim_sales
    WHERE DATETRUNC(month, order_date) IS NOT NULL
    GROUP BY DATETRUNC(month, order_date)
) s;