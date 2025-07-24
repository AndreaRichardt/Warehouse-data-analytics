# Business Intelligence & Analytics 

A comprehensive collection of SQL queries and views for business intelligence analysis, focusing on customer behavior, product performance, and sales analytics.

## 📊 Overview

This repository contains SQL scripts designed for comprehensive business intelligence analysis. The repository is structured into two main components:

1. **Final Reports (Views)**: Production-ready views that aggregate key metrics for `Products_Overview` and `Customers_Overview`, designed specifically for dashboard visualizations and reporting tools.

2. **Standalone Analysis Queries**: Individual analytical queries that provide specific business insights across customer behavior, product performance, and sales trends.

## 🗂️ Repository Structure

### 📊 Final Reports (Views)
- **Products_Overview**: Final comprehensive product performance report ready for visualization
- **Customers_Overview**: Final customer demographic and behavioral report ready for visualization

### 📈 Standalone Analysis Queries
Individual analysis queries organized by category for specific business insights:

#### 1. Customer Analytics
- Customer segmentation by purchase behavior and sales volume
- Age group classification and analysis
- Customer lifetime value insights

#### 2. Product Analytics
- Product cost-based segmentation analysis
- Year-over-year product performance comparison
- Category contribution (part-to-whole) analysis

#### 3. Sales Analytics
- Cumulative sales analysis (running totals)
- Time-series trend analysis (yearly, monthly)
- Sales performance tracking over time

## 📈 Key Metrics & KPIs

### Customer Metrics
- **Total Orders**: Number of distinct orders per customer
- **Total Sales**: Cumulative sales amount per customer
- **Lifespan**: Duration between first and last purchase (months)
- **Recency**: Time since last purchase (months)
- **Average Order Value (AOV)**: Average revenue per order
- **Monthly Spend**: Average monthly spending per customer

### Product Metrics
- **Total Orders**: Number of orders containing the product
- **Total Sales**: Cumulative sales amount per product
- **Revenue**: Sales minus cost
- **Average Order Revenue (AOR)**: Revenue per order
- **Average Monthly Revenue**: Revenue divided by product lifespan

## 🎯 Segmentation Logic

### Customer Segments
- **VIP**: Customers with ≥12 months lifespan AND >$5,000 total sales
- **Regular**: Customers with ≥12 months lifespan
- **New**: Customers with <12 months lifespan

### Product Segments (by Revenue)
- **Low Performers**: Revenue ≤ $200,151
- **Mid Performers**: Revenue ≤ $398,682
- **High Performers**: Revenue > $398,682

### Product Segments (by Cost)
- **Low**: Cost ≤ $542
- **Medium**: Cost ≤ $1,085
- **High**: Cost ≤ $1,626
- **Premium**: Cost > $1,626

### Age Groups
- **Gen Z**: Age ≤ 24
- **Millennials**: Age 25-34
- **Gen X**: Age 35-49
- **Boomers**: Age 50+

## 🔧 Technical Requirements

### Database Schema
The queries assume a star schema with the following tables:
- `gold.dim_sales` - Fact table containing sales transactions
- `gold.dim_products` - Product dimension table
- `gold.dim_customer` - Customer dimension table

### Required Fields

#### Sales Table (`gold.dim_sales`)
- `customer_key` - Customer identifier
- `product_key` - Product identifier
- `order_number` - Order identifier
- `order_date` - Transaction date
- `sales` - Sales amount
- `quantity` - Quantity sold
- `price` - Unit price

#### Products Table (`gold.dim_products`)
- `product_key` - Product identifier
- `product_name` - Product name
- `category` - Product category
- `subcategory` - Product subcategory
- `cost` - Product cost

#### Customer Table (`gold.dim_customer`)
- `customer_key` - Customer identifier
- `first_name` - Customer first name
- `last_name` - Customer last name
- `birthdate` - Customer birth date

## 📋 Usage Instructions

### 1. Final Reports for Visualizations
Use the views as data sources for your BI tools and dashboards:
```sql
-- Use for product performance dashboards
SELECT * FROM Products_Overview;

-- Use for customer analytics dashboards  
SELECT * FROM Customers_Overview;
```

### 2. Standalone Analysis Queries
Execute individual analysis queries for specific business questions:
- Run customer segmentation analysis for targeted marketing
- Execute product performance queries for inventory decisions
- Use time-series analysis for trend identification
- Run cumulative analysis for growth tracking

### 3. Setting Up Views
Execute the view creation scripts to establish the reporting foundation:
```sql
-- Create Products Overview for visualizations
CREATE VIEW Products_Overview AS ...

-- Create Customers Overview for visualizations
CREATE VIEW Customers_Overview AS ...
```

### 4. Customizing Analysis
Modify the standalone query parameters based on your specific business needs:
- Adjust segmentation thresholds in analysis queries
- Modify time periods for trend analysis
- Update criteria for performance comparisons

## 📊 Analysis Types

### 1. **Final Reports (Views)**
- **Products_Overview**: Production-ready product metrics for dashboards
- **Customers_Overview**: Production-ready customer metrics for visualizations
- Ready for integration with BI tools (Tableau, Power BI, etc.)

### 2. **Standalone Analytical Queries**
- **Descriptive Analytics**: Current state analysis and segmentation
- **Trend Analysis**: Year-over-year comparisons and time-series tracking
- **Comparative Analysis**: Performance comparison and contribution analysis

## 🚀 Getting Started

1. **Prerequisites**: Ensure your database contains the required tables with proper schema
2. **Data Validation**: Verify data quality and completeness
3. **Views for Dashboards**: Execute view creation scripts for reporting infrastructure
4. **Standalone Analysis**: Run individual queries for specific business insights
5. **Dashboard Integration**: Connect views to your visualization tools
6. **Results Interpretation**: Use the segmentation logic and metrics to drive business decisions

## 📝 Notes

- All date calculations use `CURRENT_TIMESTAMP` for real-time analysis
- NULL values are handled using `NULLIF()` to prevent division by zero errors
- Window functions are used for advanced analytics (running totals, comparisons)
- Results are ordered for better readability and analysis
