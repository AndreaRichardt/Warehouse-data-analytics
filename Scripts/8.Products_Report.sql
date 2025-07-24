-- PURPOSE: Create a product performance overview view that aggregates sales, orders,
-- quantities, customers, lifespan, recency, and revenue metrics for each product.
-- Products are segmented based on their revenue into Low, Mid, and High performers.

CREATE VIEW Products_Overview AS
WITH Product_report AS (
    SELECT
        p.product_key,
        p.product_name,
        p.category,
        p.subcategory,
        p.cost,
        s.customer_key,
        s.order_date,
        s.order_number,
        s.sales,
        s.quantity
    FROM gold.dim_sales s
    LEFT JOIN gold.dim_products p ON s.product_key = p.product_key
),

Agregates AS (
    SELECT 
        product_key,
        MAX(product_name) AS product_name,
        MAX(category) AS category,
        MAX(subcategory) AS subcategory,
        MAX(cost) AS cost,
        COUNT(DISTINCT order_number) AS Total_orders,
        SUM(sales) AS Total_sales,
        SUM(quantity) AS Total_quantity,
        COUNT(DISTINCT customer_key) AS Total_customers,
        DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan,
        DATEDIFF(month, MAX(order_date), CURRENT_TIMESTAMP) AS Recency,
        SUM(sales) - SUM(cost) AS Revenue
    FROM Product_report
    GROUP BY product_key
)

SELECT
    a.product_key,
    a.product_name,
    a.category,
    a.subcategory,
    a.cost,
    a.Total_orders,
    a.Total_sales,
    a.Total_quantity,
    a.Total_customers,
    a.lifespan,
    a.Recency,
    (a.Revenue / NULLIF(a.Total_orders, 0)) AS AOR, -- Average Order Revenue
    (a.Revenue / NULLIF(a.lifespan, 0)) AS Avg_monthly_revenue,
    CASE
        WHEN a.Revenue <= 200151 THEN 'Low - performers'
        WHEN a.Revenue <= 398682 THEN 'Mid - performers'
        ELSE 'High - performers'
    END AS Segment
FROM Agregates a;