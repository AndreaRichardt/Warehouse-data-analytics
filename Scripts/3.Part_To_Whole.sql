-- PURPOSE: Calculate the percentage contribution of each product category to the overall sales (Part-to-Whole analysis)

WITH category_sales AS (
    SELECT
        p.category,
        SUM(f.sales) AS total_sales
    FROM gold.dim_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key
    WHERE p.category IS NOT NULL
    GROUP BY p.category
)
SELECT
    category,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2) AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;