USE kape_diaries;
SHOW TABLES;
# Inspect the customers table
DESCRIBE customers;

# Inspect the orders table
DESCRIBE orders;

# Preview the orders data
SELECT *
FROM orders
LIMIT 5;

# Preview the customers data
SELECT *
FROM customers
LIMIT 5;

# Find out how many customers we have
SELECT DISTINCT(COUNT(customer_name)) AS total_customers
FROM customers;

# Find the total number of orders
SELECT COUNT(*) AS total_orders
FROM orders;

# Calculate the store's total sales
SELECT
SUM(qty * unit_price) AS total_sales
FROM orders;

# Calculate the store's total sales
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY total_orders DESC;

# Show repeat buyers by name
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

# Find which provinces to target with ads
SELECT c.province, SUM(o.qty * o.unit_price) AS total_sales
FROM customers c 
JOIN orders o
	ON c.customer_id = o.customer_id
GROUP BY c.province
ORDER BY total_sales DESC;

# Check the number of orders from each province

SELECT
    c.province,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.province
ORDER BY total_orders DESC;


# Find the products that carry the store
SELECT
    product,
    SUM(qty) AS units_sold,
    SUM(qty * unit_price) AS total_sales
FROM orders
GROUP BY product
ORDER BY total_sales DESC;

# Find the month with the highest average order value
SELECT
    MONTHNAME(order_date) AS month_name,
    MONTH(order_date) AS month_number,
    AVG(qty * unit_price) AS average_order_value
FROM orders
GROUP BY
    MONTH(order_date),
    MONTHNAME(order_date)
ORDER BY average_order_value DESC;



