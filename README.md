# Kape Diaries PH: E-commerce Sales Analysis Using MySQL

## Project Overview

Kape Diaries PH is an online store that sells coffee equipment, accessories, and locally sourced coffee beans. The store owner wants to understand customer purchasing behaviour, identify provinces with strong sales, determine which products perform best, and find the month with the highest average order value.

In this project, I used MySQL to explore the store's customer and order data and answer these business questions with data.

## Business Questions

1. Who are the repeat buyers?
2. Which provinces should the business target with advertisements?
3. Which products generate the most sales?
4. Which month has the highest average order value?

## Tools Used

- **MySQL:** Data exploration, querying, aggregation, and analysis.
- **MySQL Workbench:** Writing and executing SQL queries.

## Dataset Overview

The project uses two tables:

**1. Customers**

Contains customer information, including:
- `customer_id`
- `customer_name`
- `province`
- `signup_date`

**2. Orders**

Contains order details, including:
- `order_id`
- `customer_id`
- `order_date`
- `product`
- `category`
- `qty`
- `unit_price`

## Analysis Process

### 1. Database Setup

I created the database and selected it for analysis.

```sql
CREATE DATABASE kape_diaries;
USE kape_diaries;
```

I then imported the two CSV files into MySQL Workbench as the `customers` and `orders` tables.

### 2. Understanding the Data

I checked the available tables and reviewed their structures.

```sql
SHOW TABLES;

DESCRIBE customers;

DESCRIBE orders;
```

I also checked the number of customer and order records.

```sql
SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_orders
FROM orders;
```

**Results:**
- Total customer records: 150
- Total order records: 363

### 3. Calculating Total Sales

To understand the store's overall sales value, I multiplied the quantity purchased by the unit price for each order record.

```sql
SELECT SUM(qty * unit_price) AS total_sales
FROM orders;
```

**Result:** 441,907 in the dataset's price units.

### 4. Identifying Repeat Buyers

I grouped the orders by customer and used `HAVING` to identify customers with more than one order record. I then joined the results to the customers table to retrieve their names and provinces.

```sql
SELECT
    c.customer_id,
    c.customer_name,
    c.province,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.province
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;
```

**Finding:** Cris Aquino from Iloilo had the highest number of order records, with 11. Peter Tan, Leo Ramos, and Juan Garcia each had 8.

This helps the business identify customers who may respond well to loyalty rewards and repeat-purchase offers.

### 5. Comparing Sales Across Provinces

I joined the customers and orders tables to calculate sales by province.

```sql
SELECT
    c.province,
    SUM(o.qty * o.unit_price) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.province
ORDER BY total_sales DESC;
```

**Findings:**

| Province | Total Sales |
|---|---:|
| Metro Manila | 130,758 |
| Cavite | 64,418 |
| Davao del Sur | 55,034 |
| Iloilo | 44,259 |
| Pampanga | 36,129 |

Metro Manila generated the highest sales, followed by Cavite and Davao del Sur. Bulacan and Rizal recorded the lowest sales in the dataset.

These results help identify provinces to consider when planning advertising campaigns. However, sales alone do not show whether a campaign will be profitable, so advertising costs and campaign performance should also be monitored.

### 6. Identifying the Best-Selling Products

I grouped the order records by product and calculated both the total quantity sold and total sales value.

```sql
SELECT
    product,
    SUM(qty) AS units_sold,
    SUM(qty * unit_price) AS total_sales
FROM orders
GROUP BY product
ORDER BY total_sales DESC;
```

**Findings:**

| Product | Units Sold | Total Sales |
|---|---:|---:|
| Gooseneck Kettle 1L | 80 | 100,000 |
| Manual Coffee Grinder | 81 | 72,819 |
| French Press 350ml | 92 | 50,508 |
| Insulated Tumbler 500ml | 73 | 49,640 |
| Digital Coffee Scale | 55 | 41,250 |
| Paper Filters 100pk | 44 | 7,920 |

The Gooseneck Kettle 1L generated the highest sales value, while the French Press 350ml recorded the highest quantity sold among the listed products.

This shows why it is useful to compare both revenue and units sold when evaluating product performance.

### 7. Finding the Month with the Highest Average Order Value

Before interpreting the results, I checked whether any `order_id` appeared more than once. The query returned no rows, confirming that each order ID appears only once in the dataset.

I then calculated the average order value for each month.

```sql
SELECT
    MONTHNAME(order_date) AS month_name,
    MONTH(order_date) AS month_number,
    AVG(qty * unit_price) AS average_order_value
FROM orders
GROUP BY
    MONTH(order_date),
    MONTHNAME(order_date)
ORDER BY average_order_value DESC;
```

**Findings:**

| Month | Average Order Value |
|---|---:|
| April | 1,336.10 |
| June | 1,288.82 |
| May | 1,253.73 |
| February | 1,208.58 |
| January | 1,113.72 |
| March | 1,096.45 |

April recorded the highest average order value at approximately 1,336.10, while March recorded the lowest at approximately 1,096.45.

This suggests that the average recorded purchase value was highest in April. Further analysis would be needed to understand what influenced this difference.

## Summary of Findings

The analysis provided answers to the four business questions:

1. **Repeat buyers:** Cris Aquino from Iloilo had the highest number of order records, with 11.
2. **Provinces to consider for advertising:** Metro Manila, Cavite, and Davao del Sur recorded the highest sales.
3. **Top product by sales value:** Gooseneck Kettle 1L generated 100,000 in sales.
4. **Highest average order value:** April recorded the highest average at 1,336.10.

## Recommendations

Based on the findings, I recommend that Kape Diaries PH:

- **Encourage repeat purchases:** Consider loyalty rewards and special offers for returning customers.
- **Plan targeted advertising:** Prioritise testing campaigns in Metro Manila, Cavite, and Davao del Sur, while monitoring campaign costs and results.
- **Monitor product performance:** Pay attention to the stock levels of high-revenue products such as the Gooseneck Kettle 1L and products with high sales volumes, such as the French Press 350ml.
- **Investigate monthly spending patterns:** Review April's sales and product mix to understand why its average order value was higher than in other months.

## Conclusion

This project helped me practise using MySQL to explore data, join tables, aggregate results, and answer practical business questions.

The analysis provided useful insights into repeat buyers, provincial sales performance, product revenue, and monthly average order value. These findings can support decisions about customer retention, product availability, and advertising priorities.

## Skills Demonstrated

- SQL querying and data exploration
- Database and table inspection
- Aggregate functions such as `COUNT()`, `SUM()`, and `AVG()`
- Filtering grouped results with `HAVING`
- Joining tables
- Grouping and sorting results
- Translating query results into business insights and recommendations
