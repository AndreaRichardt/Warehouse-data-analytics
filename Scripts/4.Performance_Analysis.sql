-- PURPOSE: Perform product performance analysis across years using average and year-over-year comparisons

WITH Product_performance AS (
    SELECT 
        YEAR(order_date) AS Order_year,
        product_key,
        SUM(sales) AS Total_sales
    FROM Gold.dim_sales
    WHERE YEAR(order_date) IS NOT NULL
    GROUP BY YEAR(order_date), product_key
)

SELECT 
    p.Product_key,
    p.Order_year,
    pr.product_name,
    Total_sales,
    AVG(Total_sales) OVER (PARTITION BY p.product_key) AS Product_avg_sales,
    CASE
        WHEN AVG(Total_sales) OVER (PARTITION BY p.product_key) > Total_sales THEN 'Below-Avg'
        WHEN AVG(Total_sales) OVER (PARTITION BY p.product_key) = Total_sales THEN 'Avg'
        WHEN AVG(Total_sales) OVER (PARTITION BY p.product_key) < Total_sales THEN 'Above-Avg'
    END AS Avg_flag,
    LAG(Total_sales, 1) OVER (PARTITION BY p.Product_key ORDER BY Order_year) AS Last_years_sales,
    CASE
        WHEN LAG(Total_sales, 1) OVER (PARTITION BY p.Product_key ORDER BY Order_year) > Total_sales THEN 'Decrease'
        WHEN LAG(Total_sales, 1) OVER (PARTITION BY p.Product_key ORDER BY Order_year) = Total_sales THEN '-'
        WHEN LAG(Total_sales, 1) OVER (PARTITION BY p.Product_key ORDER BY Order_year) < Total_sales THEN 'Increase'
    END AS YoY_flag
FROM Product_performance p
LEFT JOIN Gold.dim_products pr
    ON p.product_key = pr.product_key
ORDER BY p.product_key, Order_year;