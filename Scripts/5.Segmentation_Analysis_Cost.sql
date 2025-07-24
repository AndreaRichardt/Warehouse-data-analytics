-- PURPOSE: Perform product segmentation based on cost, categorizing products into Low, Medium, High, and Premium segments.
-- This query counts the total number of products in each cost segment.

WITH Product_segments AS (
    SELECT 
        Product_name,
        cost,
        CASE 
            WHEN cost <= 542 THEN 'Low'
            WHEN cost <= 1085 THEN 'Medium'
            WHEN cost <= 1626 THEN 'High'
            ELSE 'Premium'
        END AS Segments
    FROM Gold.dim_products
    WHERE category IS NOT NULL
)

SELECT 
    Segments,
    COUNT(Product_name) AS Total_products
FROM Product_segments
GROUP BY Segments
ORDER BY Segments;