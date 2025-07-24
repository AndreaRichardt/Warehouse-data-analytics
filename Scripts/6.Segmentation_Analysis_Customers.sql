-- PURPOSE: Segment customers based on their purchase lifespan and total sales.
-- Customers are classified as 'VIP', 'Regular', or 'New' depending on how long they have been purchasing (in months) and their total sales amount.
-- The query counts how many customers fall into each segment.

SELECT 
    Segment,
    COUNT(s.customer_key) AS Total_customers
FROM (
    SELECT 
        s.customer_key,
        SUM(sales) AS total_sales,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
        CASE 
            WHEN DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) >= 12 AND SUM(sales) > 5000 THEN 'VIP'
            WHEN DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) >= 12 THEN 'Regular'
            ELSE 'New'
        END AS Segment
    FROM gold.dim_sales s
    LEFT JOIN gold.dim_customer c
        ON s.customer_key = c.customer_key
    WHERE s.order_date IS NOT NULL
    GROUP BY s.customer_key
) s
GROUP BY Segment
ORDER BY Segment;