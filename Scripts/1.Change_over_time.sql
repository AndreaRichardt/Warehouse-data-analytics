-- PURPOSE: Analyze changes in total customers, sales, and quantity over time

-- 1. Yearly summary
SELECT 
    YEAR(order_date) AS Year,                            
    COUNT(DISTINCT customer_key) AS Total_customers,     
    SUM(sales) AS Total_Sales,                           
    SUM(quantity) AS Total_quantity                      
FROM gold.dim_sales
WHERE YEAR(order_date) IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);

-- 2. Monthly summary (across all years)
SELECT 
    MONTH(order_date) AS Month,                          
    COUNT(DISTINCT customer_key) AS Total_customers,
    SUM(sales) AS Total_Sales,
    SUM(quantity) AS Total_quantity
FROM gold.dim_sales
WHERE YEAR(order_date) IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date);

-- 3. Year-Month summary
SELECT 
    YEAR(order_date) AS Year,
    MONTH(order_date) AS Month,
    COUNT(DISTINCT customer_key) AS Total_customers,
    SUM(sales) AS Total_Sales,
    SUM(quantity) AS Total_quantity
FROM gold.dim_sales
WHERE YEAR(order_date) IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);