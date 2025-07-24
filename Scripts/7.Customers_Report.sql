-- PURPOSE: Create a comprehensive customer overview view that aggregates
-- customer demographic data and purchase behavior.
-- This view summarizes each customer's total orders, sales, quantities, product diversity, order lifespan, recency, average order value,
-- monthly spending, and segments customers by purchase behavior and age group.

CREATE VIEW Customers_Overview AS
WITH main_table AS (
    SELECT
        c.customer_key,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        DATEDIFF(YEAR, c.birthdate, CURRENT_TIMESTAMP) AS age,
        s.order_number,
        s.order_date,
        s.sales,
        s.quantity,
        s.price,
        s.product_key
    FROM gold.dim_sales s
    LEFT JOIN gold.dim_customer c
        ON s.customer_key = c.customer_key
    WHERE s.order_date IS NOT NULL
),

aggregated_data AS (
    SELECT
        customer_key,
        customer_name,
        age,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales) AS total_sales,
        SUM(quantity) AS total_quantity_purchased,
        COUNT(DISTINCT product_key) AS total_products,
        MAX(order_date) AS last_order,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
        DATEDIFF(MONTH, MAX(order_date), CURRENT_TIMESTAMP) AS recency,
        SUM(sales) / COUNT(DISTINCT order_number) AS avg_order_value,
        CASE 
            WHEN DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) = 0 
                THEN SUM(sales)
            ELSE 
                SUM(sales) / NULLIF(DATEDIFF(MONTH, MIN(order_date), MAX(order_date)), 0)
        END AS monthly_spend
    FROM main_table
    GROUP BY customer_key, customer_name, age
)

SELECT
    customer_key,
    customer_name,
    age,
    total_orders,
    total_sales,
    total_quantity_purchased,
    total_products,
    last_order,
    lifespan,
    recency,
    avg_order_value,
    monthly_spend,
    -- Customer Segment based on lifespan and total sales
    CASE 
        WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN lifespan >= 12 THEN 'Regular'
        ELSE 'New'
    END AS segment,
    -- Age Group classification
    CASE
        WHEN age <= 24 THEN 'Gen Z'
        WHEN age <= 34 THEN 'Millennials'
        WHEN age <= 49 THEN 'Gen X'
        ELSE 'Boomers'
    END AS age_group
FROM aggregated_data;