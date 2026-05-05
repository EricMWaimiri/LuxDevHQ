-- CREATE schema assignment
CREATE SCHEMA assignment;

-- CREATE Customers table in the assignment schema
CREATE TABLE assignment.customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(50),
    registration_date DATE,
    membership_status VARCHAR(10)
);
-- CREATE Products table in the assignment schema
CREATE TABLE assignment.products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    supplier VARCHAR(100),
    stock_quantity INT
);
-- CREATE Sales table in the assignment schema
CREATE TABLE assignment.sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity_sold INT,
    sale_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES assignment.customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES assignment.products(product_id)
);

-- CREATE Inventory table in the assignment schema
CREATE TABLE assignment.inventory (
    product_id INT PRIMARY KEY,
    stock_quantity INT,
    FOREIGN KEY (product_id) REFERENCES assignment.products(product_id)
);

-- Inserting data into assignment.Customers table
INSERT INTO assignment.Customers 
(customer_id, first_name, last_name, email, phone_number, registration_date, membership_status) 
VALUES
(1, 'Karen', 'Molina', 'gonzalezkimberly@glass.com', '(728)697-1206', '2020-08-27', 'Bronze'),
(2, 'Elizabeth', 'Archer', 'tramirez@gmail.com', '778.104.6553', '2023-08-28', 'Silver'),
(3, 'Roberta', 'Massey', 'davislori@gmail.com', '+1-365-606-7458x399', '2024-06-12', 'Bronze'),
(4, 'Jacob', 'Adams', 'andrew72@hotmail.com', '246-459-1425x462', '2023-02-10', 'Gold'),
(5, 'Cynthia', 'Lowery', 'suarezkiara@ramsey.com', '001-279-688-8177x4015', '2020-11-13', 'Silver'),
(6, 'Emily', 'King', 'igoodwin@howard.com', '(931)575-5422x5900', '2021-05-01', 'Silver'),
(7, 'Linda', 'Larsen', 'pware@yahoo.com', '289-050-2028x7673', '2021-08-20', 'Silver'),
(8, 'Angela', 'Hanson', 'zanderson@gmail.com', '+1-403-917-3585', '2023-03-17', 'Bronze'),
(9, 'Whitney', 'Wilson', 'norma70@yahoo.com', '001-594-317-6656', '2024-01-27', 'Bronze'),
(10, 'Angela', 'Atkins', 'burnsjorge@medina.org', '344.217.5788', '2025-02-05', 'Silver'),
(11, 'Gary', 'Lucero', 'ssnyder@hotmail.com', '001-842-595-7853', '2024-10-08', 'Silver'),
(12, 'Matthew', 'Romero', 'jennifer22@gmail.com', '556.328.91896', '2022-04-07', 'Bronze'),
(13, 'Ronald', 'Thompson', 'hramos@hayes.biz', '298-487-2483', '2023-07-31', 'Bronze'),
(14, 'Suzanne', 'Anderson', 'michaelcole@ruiz-ware.com', '+1-018-029-7257', '2023-11-02', 'Bronze'),
(15, 'Mary', 'Kelly', 'matthewmurphy@gmail.com', '(845)934-9x286', '2021-01-20', 'Bronze'),
(16, 'John', 'George', 'burnettlauren@gmail.com', '+1-708-200-4286', '2022-05-17', 'Bronze'),
(17, 'James', 'Rodriguez', 'brownbrian@blair-sanford.com', '8826047658', '2022-11-25', 'Gold'),
(18, 'Steven', 'Burnett', 'zblackburn@yahoo.com', '(055)912-6726x1246', '2020-01-28', 'Gold'),
(19, 'Jonathan', 'White', 'millsseth@choi-kelly.org', '755-979-1934x772', '2022-02-06', 'Bronze'),
(20, 'Christopher', 'Santiago', 'heidimaddox@hotmail.com', '118-589-6973x058', '2021-10-16', 'Silver'),
(21, 'John', 'Diaz', 'gsmith@hotmail.com', '369.915.4337', '2022-09-17', 'Gold'),
(22, 'Curtis', 'Rose', 'ryanmartinez@moore.com', '(921)461-2128', '2021-12-14', 'Bronze'),
(23, 'Charles', 'Hughes', 'jonesangela@frank-lynn.com', '(152)603-5387x8994', '2024-07-29', 'Silver'),
(24, 'Sarah', 'Cooke', 'whitedennis@tucker.org', '(641)830-6756x56741', '2024-12-15', 'Bronze'),
(25, 'Luis', 'Harrison', 'melvin70@gmail.com', '516.509.9493', '2021-08-19', 'Silver'),
(26, 'Annette', 'Greene', 'aaron68@hall.com', '(733)734-1847x1078', '2025-04-12', 'Bronze'),
(27, 'Melissa', 'Jacobson', 'becklarry@gmail.com', '562-245-7784x4729', '2023-04-28', 'Bronze'),
(28, 'Julie', 'Gardner', 'adamsrodney@hall.com', '+1-014-029-3206x188', '2024-03-31', 'Gold'),
(29, 'Margaret', 'Taylor', 'lfuller@hotmail.com', '(299)340-8900x297', '2021-09-06', 'Bronze'),
(30, 'Erika', 'Mckee', 'wsmith@gmail.com', '(160)040-7321', '2021-05-25', 'Silver'),
(31, 'Donna', 'Whitney', 'justinnicholson@gmail.com', '7086491657', '2022-08-07', 'Gold'),
(32, 'Kristina', 'Wade', 'ashley30@richards-young.com', '603-604-2831x303', '2024-03-16', 'Silver'),
(33, 'Joshua', 'Green', 'ihartman@yahoo.com', '988-232-8285x00933', '2024-05-14', 'Silver'),
(34, 'John', 'Leblanc', 'herickson@green.info', '229.016.2527x20209', '2022-12-24', 'Silver'),
(35, 'Nicholas', 'Campbell', 'ghernandez@hotmail.com', '(982)215-6626', '2022-06-06', 'Gold'),
(36, 'Christopher', 'Hicks', 'ryan48@gmail.com', '884.881.7758', '2021-04-03', 'Silver'),
(37, 'Craig', 'Miller', 'scampbell@johnson.net', '390-328-7286x021', '2024-04-30', 'Silver'),
(38, 'Jennifer', 'Bailey', 'dwright@hotmail.com', '001-992-011-9250', '2022-09-07', 'Silver'),
(39, 'Emma', 'Davis', 'lisalester@hotmail.com', '911.706.3025', '2021-06-04', 'Gold'),
(40, 'Michael', 'Wilson', 'lmerritt@wallace-wang.com', '462.021.3233', '2025-01-14', 'Bronze'),
(41, 'Sarah', 'Church', 'deniseramos@gmail.com', '(840)285-3653x61868', '2021-03-14', 'Silver'),
(42, 'Carolyn', 'Stevenson', 'george62@garrison.net', '040.179.1155', '2024-07-26', 'Silver'),
(43, 'Sarah', 'Cole', 'amandamartin@hotmail.com', '481-651-5206x4800', '2024-07-27', 'Silver'),
(44, 'Jeremiah', 'Lozano', 'bethany38@lopez.net', '846-327-7426', '2023-01-02', 'Bronze'),
(45, 'Leslie', 'Boyd', 'cartermorgan@scott-franco.com', '+1-583-786-3525', '2022-10-22', 'Silver'),
(46, 'Carrie', 'Anderson', 'stevenlivingston@yahoo.com', '+1-086-709-5530x6149', '2024-08-23', 'Gold'),
(47, 'Jared', 'Davis', 'mooretodd@cook.com', '001-069-544-8807x2397', '2022-08-29', 'Bronze'),
(48, 'James', 'Soto', 'patriciaburns@yahoo.com', '129.857.8193x421', '2023-01-27', 'Gold'),
(49, 'Cody', 'Kline', 'bradfordleslie@hotmail.com', '+1-710-706-3703x7998', '2022-06-28', 'Bronze'),
(50, 'Jennifer', 'Perkins', 'austinowens@hill.info', '762.009.1882', '2020-10-19', 'Silver');

select * from assignment.customers;

-- Inserting data into assignment.Products table
INSERT INTO assignment.Products 
(product_id, product_name, category, price, supplier, stock_quantity) 
VALUES
(1, 'Laptop', 'Electronics', 999.99, 'Dell', 50),
(2, 'Smartphone', 'Electronics', 799.99, 'Samsung', 150),
(3, 'Washing Machine', 'Appliances', 499.99, 'LG', 30),
(4, 'Headphones', 'Accessories', 199.99, 'Sony', 100),
(5, 'Refrigerator', 'Appliances', 1200.00, 'Whirlpool', 40),
(6, 'Smart TV', 'Electronics', 1500.00, 'Samsung', 20),
(7, 'Microwave', 'Appliances', 180.00, 'Panasonic', 75),
(8, 'Blender', 'Appliances', 50.00, 'Ninja', 200),
(9, 'Gaming Console', 'Electronics', 350.00, 'Sony', 60),
(10, 'Wireless Mouse', 'Accessories', 25.00, 'Logitech', 300),
(11, 'Keyboard', 'Accessories', 49.99, 'Logitech', 250),
(12, 'Monitor', 'Electronics', 250.00, 'Acer', 120),
(13, 'External Hard Drive', 'Electronics', 80.00, 'Seagate', 90),
(14, 'Tablet', 'Electronics', 400.00, 'Apple', 70),
(15, 'Smartwatch', 'Electronics', 199.99, 'Apple', 120);

select * from assignment.products;

-- Inserting data into assignment.Sales table
INSERT INTO assignment.Sales 
(sale_id, customer_id, product_id, quantity_sold, sale_date, total_amount) 
VALUES
(1, 1, 1, 1, '2023-07-15', 999.99),
(2, 2, 2, 2, '2023-08-20', 1599.98),
(3, 3, 3, 1, '2023-09-10', 499.99),
(4, 4, 4, 3, '2023-07-25', 599.97),
(5, 5, 5, 1, '2023-06-18', 1200.00),
(6, 6, 6, 1, '2023-10-05', 1500.00),
(7, 7, 7, 1, '2023-08-01', 180.00),
(8, 8, 8, 2, '2023-09-02', 100.00),
(9, 9, 9, 1, '2023-10-10', 350.00),
(10, 10, 10, 3, '2023-11-12', 75.00),
(11, 11, 11, 2, '2023-12-01', 100.00),
(12, 12, 12, 1, '2023-12-07', 250.00),
(13, 13, 13, 1, '2024-01-15', 80.00),
(14, 14, 14, 1, '2024-02-05', 400.00),
(15, 15, 15, 1, '2024-01-05', 199.99);

-- Inserting data into assignment.Inventory table
INSERT INTO assignment.inventory 
(product_id, stock_quantity) 
VALUES
(1, 50),
(2, 150),
(3, 30),
(4, 100),
(5, 40),
(6, 20),
(7, 75),
(8, 200),
(9, 60),
(10, 300),
(11, 250),
(12, 120),
(13, 90),
(14, 70),
(15, 120);

-- Select all data from assignment.Customers table
SELECT * FROM assignment.Customers;

-- Select all data from assignment.Products table
SELECT * FROM assignment.Products;

-- Select all data from assignment.Sales table
SELECT * FROM assignment.Sales;

-- Select all data from assignment.Inventory table
SELECT * FROM assignment.Inventory;

-- SALES & INVENTORY SQL ASSIGNMENT - ANSWERS
-- =====================================================

-- BASIC QUERIES (1–50)

-- 1. Select all data from the Customers table.
SELECT * FROM assignment.customers;

-- 2. Select the total number of products from the Products table.
SELECT COUNT(*) AS total_products FROM assignment.products;

-- 3. Select the product name and price where price > 500.
SELECT product_name, price
FROM assignment.products
WHERE price > 500;

-- 4. Find the average price of all products.
SELECT AVG(price) AS avg_price FROM assignment.products;

-- 5. Find the total sales amount across all records.
SELECT SUM(total_amount) AS total_sales FROM assignment.sales;

-- 6. Select distinct membership statuses.
SELECT DISTINCT membership_status FROM assignment.customers;

-- 7. Concatenate first and last names as full_name.
SELECT first_name || ' ' || last_name AS full_name FROM assignment.customers;

-- 8. Find all products where category = 'Electronics'.
SELECT * FROM assignment.products WHERE category = 'Electronics';

-- 9. Find the highest price from the Products table.
SELECT MAX(price) AS highest_price FROM assignment.products;

-- 10. Count the number of sales for each product.
SELECT product_id, COUNT(*) AS number_of_sales
FROM assignment.sales
GROUP BY product_id;

-- 11. Find the total quantity sold for each product.
SELECT product_id, SUM(quantity_sold) AS total_quantity_sold
FROM assignment.sales
GROUP BY product_id;

-- 12. Find the lowest price of products.
SELECT MIN(price) AS lowest_price FROM assignment.products;

-- 13. Find customers who have purchased products with a price > 1000.
SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
JOIN assignment.products p ON s.product_id = p.product_id
WHERE p.price > 1000;

-- 14. Join Sales and Products; show product name and total sales amount per product.
SELECT p.product_name, SUM(s.total_amount) AS total_sales_amount
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- 15. Join Customers and Sales; find the total amount spent by each customer.
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.total_amount) AS total_spent
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 16. Join Customers, Sales, and Products; show name, product name, and quantity sold.
SELECT c.first_name, c.last_name, p.product_name, s.quantity_sold
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
JOIN assignment.products p ON s.product_id = p.product_id;

-- 17. Self-join on Customers to find pairs with the same membership status.
SELECT a.customer_id AS customer_1, b.customer_id AS customer_2,
       a.first_name || ' ' || a.last_name AS name_1,
       b.first_name || ' ' || b.last_name AS name_2,
       a.membership_status
FROM assignment.customers a
JOIN assignment.customers b
  ON a.membership_status = b.membership_status
 AND a.customer_id < b.customer_id;

-- 18. Join Sales and Products; calculate total number of sales for each product.
SELECT p.product_name, COUNT(s.sale_id) AS total_sales_count
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- 19. Find products where stock quantity < 10.
SELECT * FROM assignment.products WHERE stock_quantity < 10;

-- 20. Join Sales and Products; find products with total sales quantity > 5.
SELECT p.product_name, SUM(s.quantity_sold) AS total_qty_sold
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(s.quantity_sold) > 5;

-- 21. Select customers who purchased 'Electronics' or 'Appliances' category products.
SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
JOIN assignment.products p ON s.product_id = p.product_id
WHERE p.category IN ('Electronics', 'Appliances');

-- 22. Calculate total sales amount per product, grouped by product name.
SELECT p.product_name, SUM(s.total_amount) AS total_sales_amount
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- 23. Join Sales and Customers; select customers who made a purchase in 2023.
SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
WHERE EXTRACT(YEAR FROM s.sale_date) = 2023;

-- 24. Find customers with the highest total sales in 2023.
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.total_amount) AS total_2023
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
WHERE EXTRACT(YEAR FROM s.sale_date) = 2023
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_2023 DESC
LIMIT 1;

-- 25. Join Products and Sales; select the most expensive product sold.
SELECT p.product_name, p.price
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
ORDER BY p.price DESC
LIMIT 1;

-- 26. Find the total number of customers who purchased products worth > 500.
SELECT COUNT(DISTINCT s.customer_id) AS customer_count
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
WHERE p.price > 500;

-- 27. Join Products, Sales, and Customers; total number of sales by 'Gold' membership customers.
SELECT COUNT(s.sale_id) AS gold_sales_count
FROM assignment.sales s
JOIN assignment.customers c ON s.customer_id = c.customer_id
WHERE c.membership_status = 'Gold';

-- 28. Join Products and Inventory; find products with stock < 10.
SELECT p.product_name, i.stock_quantity
FROM assignment.products p
JOIN assignment.inventory i ON p.product_id = i.product_id
WHERE i.stock_quantity < 10;

-- 29. Find customers who purchased more than 5 products; show total quantity bought.
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.quantity_sold) AS total_qty
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(s.quantity_sold) > 5;

-- 30. Find the average quantity sold per product.
SELECT product_id, AVG(quantity_sold) AS avg_qty_sold
FROM assignment.sales
GROUP BY product_id;

-- 31. Find the number of sales made in December 2023.
SELECT COUNT(*) AS dec_2023_sales
FROM assignment.sales
WHERE EXTRACT(YEAR FROM sale_date) = 2023
  AND EXTRACT(MONTH FROM sale_date) = 12;

-- 32. Find total amount spent per customer in 2023; order by descending.
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.total_amount) AS total_spent_2023
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
WHERE EXTRACT(YEAR FROM s.sale_date) = 2023
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent_2023 DESC;

-- 33. Find products that have been sold but have less than 5 units left in stock.
SELECT p.product_name, i.stock_quantity
FROM assignment.products p
JOIN assignment.inventory i ON p.product_id = i.product_id
WHERE i.stock_quantity < 5
  AND p.product_id IN (SELECT DISTINCT product_id FROM assignment.sales);

-- 34. Find total sales per product; order by highest sales.
SELECT p.product_name, SUM(s.total_amount) AS total_sales
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC;

-- 35. Find customers who bought products within 7 days of their registration date.
SELECT DISTINCT c.customer_id, c.first_name, c.last_name, c.registration_date, s.sale_date
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
WHERE s.sale_date BETWEEN c.registration_date AND c.registration_date + INTERVAL '7 days';

-- 36. Join Sales and Products; filter by products priced between 100 and 500.
SELECT p.product_name, p.price, s.sale_id, s.total_amount
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
WHERE p.price BETWEEN 100 AND 500;

-- 37. Find the most frequent customer who made purchases.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(s.sale_id) AS purchase_count
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY purchase_count DESC
LIMIT 1;

-- 38. Find total quantity of products sold per customer.
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.quantity_sold) AS total_qty_sold
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 39. Find products with highest and lowest stock; display together in one result set.
(SELECT product_name, stock_quantity, 'Highest Stock' AS stock_label
 FROM assignment.products
 ORDER BY stock_quantity DESC
 LIMIT 1)
UNION ALL
(SELECT product_name, stock_quantity, 'Lowest Stock' AS stock_label
 FROM assignment.products
 ORDER BY stock_quantity ASC
 LIMIT 1);

-- 40. Find products whose names contain 'Phone' and their total sales.
SELECT p.product_name, SUM(s.total_amount) AS total_sales
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
WHERE p.product_name ILIKE '%phone%'
GROUP BY p.product_name;

-- 41. INNER JOIN Customers and Sales; show total sales and product names for 'Gold' customers.
SELECT c.first_name, c.last_name, p.product_name, SUM(s.total_amount) AS total_sales_amount
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
JOIN assignment.products p ON s.product_id = p.product_id
WHERE c.membership_status = 'Gold'
GROUP BY c.first_name, c.last_name, p.product_name;

-- 42. Find total sales of products by category.
SELECT p.category, SUM(s.total_amount) AS total_sales
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY p.category;

-- 43. Join Products and Sales; calculate total sales per product grouped by month and year.
SELECT p.product_name,
       EXTRACT(YEAR FROM s.sale_date) AS sale_year,
       EXTRACT(MONTH FROM s.sale_date) AS sale_month,
       SUM(s.total_amount) AS total_sales
FROM assignment.sales s
JOIN assignment.products p ON s.product_id = p.product_id
GROUP BY p.product_name, sale_year, sale_month
ORDER BY sale_year, sale_month;

-- 44. Join Sales and Inventory; find products that have been sold but still have stock remaining.
SELECT p.product_name, i.stock_quantity
FROM assignment.sales s
JOIN assignment.inventory i ON s.product_id = i.product_id
JOIN assignment.products p ON p.product_id = i.product_id
WHERE i.stock_quantity > 0
GROUP BY p.product_name, i.stock_quantity;

-- 45. Find the top 5 customers with the highest purchases.
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.total_amount) AS total_spent
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 5;

-- 46. Calculate total number of unique products sold in 2023.
SELECT COUNT(DISTINCT product_id) AS unique_products_sold_2023
FROM assignment.sales
WHERE EXTRACT(YEAR FROM sale_date) = 2023;

-- 47. Find products that have not been sold in the last 6 months.
SELECT p.product_name
FROM assignment.products p
WHERE p.product_id NOT IN (
    SELECT DISTINCT product_id
    FROM assignment.sales
    WHERE sale_date >= CURRENT_DATE - INTERVAL '6 months'
);

-- 48. Select products priced between $200 and $800; find total quantity sold for each.
SELECT p.product_name, p.price, SUM(s.quantity_sold) AS total_qty_sold
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
WHERE p.price BETWEEN 200 AND 800
GROUP BY p.product_name, p.price;

-- 49. Find customers who spent the most money in 2023.
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.total_amount) AS total_spent_2023
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
WHERE EXTRACT(YEAR FROM s.sale_date) = 2023
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent_2023 DESC;

-- 50. Find products sold more than 100 times with a price > 200.
SELECT p.product_name, p.price, SUM(s.quantity_sold) AS total_qty_sold
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
WHERE p.price > 200
GROUP BY p.product_name, p.price
HAVING SUM(s.quantity_sold) > 100;


-- =====================================================
-- SUBQUERY QUESTIONS (51–60)
-- =====================================================

-- 51. Which customers have spent more than the average spending of all customers?
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.total_amount) AS total_spent
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(s.total_amount) > (
    SELECT AVG(total_per_customer)
    FROM (
        SELECT SUM(total_amount) AS total_per_customer
        FROM assignment.sales
        GROUP BY customer_id
    ) sub
);

-- 52. Which products are priced higher than the average price of all products?
SELECT product_name, price
FROM assignment.products
WHERE price > (SELECT AVG(price) FROM assignment.products);

-- 53. Which customers have never made a purchase?
SELECT customer_id, first_name, last_name
FROM assignment.customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM assignment.sales);

-- 54. Which products have never been sold?
SELECT product_id, product_name
FROM assignment.products
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM assignment.sales);

-- 55. Which customer made the single most expensive purchase (total amount)?
SELECT c.customer_id, c.first_name, c.last_name, s.total_amount
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
WHERE s.total_amount = (SELECT MAX(total_amount) FROM assignment.sales);

-- 56. Which products have total sales greater than the average total sales across all products?
SELECT p.product_name, SUM(s.total_amount) AS product_total_sales
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
GROUP BY p.product_name
HAVING SUM(s.total_amount) > (
    SELECT AVG(total_per_product)
    FROM (
        SELECT SUM(total_amount) AS total_per_product
        FROM assignment.sales
        GROUP BY product_id
    ) sub
);

-- 57. Which customers registered earlier than the average registration date?
SELECT customer_id, first_name, last_name, registration_date
FROM assignment.customers
WHERE registration_date < (
    SELECT TO_TIMESTAMP(AVG(EXTRACT(EPOCH FROM registration_date)))::DATE
    FROM assignment.customers
);

-- 58. Which products have a price higher than the average price within their own category?
SELECT product_name, category, price
FROM assignment.products p
WHERE price > (
    SELECT AVG(price)
    FROM assignment.products
    WHERE category = p.category
);

-- 59. Which customers have spent more than the customer with ID = 10?
SELECT c.customer_id, c.first_name, c.last_name, SUM(s.total_amount) AS total_spent
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(s.total_amount) > (
    SELECT SUM(total_amount) FROM assignment.sales WHERE customer_id = 10
);

-- 60. Which products have total quantity sold greater than the overall average quantity sold?
SELECT p.product_name, SUM(s.quantity_sold) AS total_qty_sold
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
GROUP BY p.product_name
HAVING SUM(s.quantity_sold) > (
    SELECT AVG(qty_per_product)
    FROM (
        SELECT SUM(quantity_sold) AS qty_per_product
        FROM assignment.sales
        GROUP BY product_id
    ) sub
);


-- =====================================================
-- COMMON TABLE EXPRESSIONS (CTEs) (61–70)
-- =====================================================

-- 61. Top 5 highest spenders using CTE.
WITH customer_spending AS (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM assignment.sales
    GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, cs.total_spent
FROM customer_spending cs
JOIN assignment.customers c ON cs.customer_id = c.customer_id
ORDER BY cs.total_spent DESC
LIMIT 5;

-- 62. Top 3 most sold products using CTE.
WITH product_sales AS (
    SELECT product_id, SUM(quantity_sold) AS total_qty_sold
    FROM assignment.sales
    GROUP BY product_id
)
SELECT p.product_name, ps.total_qty_sold
FROM product_sales ps
JOIN assignment.products p ON ps.product_id = p.product_id
ORDER BY ps.total_qty_sold DESC
LIMIT 3;

-- 63. Which category generates the highest revenue using CTE.
WITH category_revenue AS (
    SELECT p.category, SUM(s.total_amount) AS total_revenue
    FROM assignment.sales s
    JOIN assignment.products p ON s.product_id = p.product_id
    GROUP BY p.category
)
SELECT category, total_revenue
FROM category_revenue
ORDER BY total_revenue DESC
LIMIT 1;

-- 64. Customers who purchased more than twice using CTE.
WITH purchase_counts AS (
    SELECT customer_id, COUNT(*) AS purchase_count
    FROM assignment.sales
    GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, pc.purchase_count
FROM purchase_counts pc
JOIN assignment.customers c ON pc.customer_id = c.customer_id
WHERE pc.purchase_count > 2;

-- 65. Products that sold more than the average quantity sold using CTE.
WITH product_qty AS (
    SELECT product_id, SUM(quantity_sold) AS total_qty_sold
    FROM assignment.sales
    GROUP BY product_id
),
avg_qty AS (
    SELECT AVG(total_qty_sold) AS avg_sold FROM product_qty
)
SELECT p.product_name, pq.total_qty_sold
FROM product_qty pq
JOIN assignment.products p ON pq.product_id = p.product_id
CROSS JOIN avg_qty
WHERE pq.total_qty_sold > avg_qty.avg_sold;

-- 66. Customers who spent more than the average spending using CTE.
WITH customer_totals AS (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM assignment.sales
    GROUP BY customer_id
),
avg_spending AS (
    SELECT AVG(total_spent) AS avg_spent FROM customer_totals
)
SELECT c.customer_id, c.first_name, c.last_name, ct.total_spent
FROM customer_totals ct
JOIN assignment.customers c ON ct.customer_id = c.customer_id
CROSS JOIN avg_spending
WHERE ct.total_spent > avg_spending.avg_spent;

-- 67. Products ordered from highest to lowest revenue using CTE.
WITH product_revenue AS (
    SELECT product_id, SUM(total_amount) AS total_revenue
    FROM assignment.sales
    GROUP BY product_id
)
SELECT p.product_name, pr.total_revenue
FROM product_revenue pr
JOIN assignment.products p ON pr.product_id = p.product_id
ORDER BY pr.total_revenue DESC;

-- 68. Month with the highest revenue using CTE.
WITH monthly_sales AS (
    SELECT
        EXTRACT(YEAR FROM sale_date) AS sale_year,
        EXTRACT(MONTH FROM sale_date) AS sale_month,
        SUM(total_amount) AS monthly_total
    FROM assignment.sales
    GROUP BY sale_year, sale_month
)
SELECT sale_year, sale_month, monthly_total
FROM monthly_sales
ORDER BY monthly_total DESC
LIMIT 1;

-- 69. Products purchased by more than three customers using CTE.
WITH sales_per_product AS (
    SELECT product_id, COUNT(DISTINCT customer_id) AS unique_customers
    FROM assignment.sales
    GROUP BY product_id
)
SELECT p.product_name, spp.unique_customers
FROM sales_per_product spp
JOIN assignment.products p ON spp.product_id = p.product_id
WHERE spp.unique_customers > 3;

-- 70. Products that sold less than the average quantity sold using CTE.
WITH product_qty AS (
    SELECT product_id, SUM(quantity_sold) AS total_qty_sold
    FROM assignment.sales
    GROUP BY product_id
),
avg_qty AS (
    SELECT AVG(total_qty_sold) AS avg_sold FROM product_qty
)
SELECT p.product_name, pq.total_qty_sold
FROM product_qty pq
JOIN assignment.products p ON pq.product_id = p.product_id
CROSS JOIN avg_qty
WHERE pq.total_qty_sold < avg_qty.avg_sold;


-- =====================================================
-- WINDOW FUNCTION QUESTIONS (71–80)
-- =====================================================

-- 71. Rank customers based on total amount spent.
SELECT c.customer_id, c.first_name, c.last_name,
       SUM(s.total_amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(s.total_amount) DESC) AS spending_rank
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 72. Rank products based on total quantity sold.
SELECT p.product_name,
       SUM(s.quantity_sold) AS total_qty_sold,
       RANK() OVER (ORDER BY SUM(s.quantity_sold) DESC) AS qty_rank
FROM assignment.products p
JOIN assignment.sales s ON p.product_id = s.product_id
GROUP BY p.product_name;

-- 73. Identify the 3rd highest spending customer.
SELECT customer_id, first_name, last_name, total_spent, spending_rank
FROM (
    SELECT c.customer_id, c.first_name, c.last_name,
           SUM(s.total_amount) AS total_spent,
           DENSE_RANK() OVER (ORDER BY SUM(s.total_amount) DESC) AS spending_rank
    FROM assignment.customers c
    JOIN assignment.sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
) ranked
WHERE spending_rank = 3;

-- 74. Identify the 2nd most expensive product.
SELECT product_name, price, price_rank
FROM (
    SELECT product_name, price,
           DENSE_RANK() OVER (ORDER BY price DESC) AS price_rank
    FROM assignment.products
) ranked
WHERE price_rank = 2;

-- 75. Rank products within each category based on price.
SELECT product_name, category, price,
       RANK() OVER (PARTITION BY category ORDER BY price DESC) AS category_price_rank
FROM assignment.products;

-- 76. Rank customers based on the number of purchases they made.
SELECT c.customer_id, c.first_name, c.last_name,
       COUNT(s.sale_id) AS purchase_count,
       RANK() OVER (ORDER BY COUNT(s.sale_id) DESC) AS purchase_rank
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 77. Show the running total of sales amounts ordered by sale_date.
SELECT sale_id, sale_date, total_amount,
       SUM(total_amount) OVER (ORDER BY sale_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM assignment.sales;

-- 78. Show the previous sale amount for each sale ordered by sale_date.
SELECT sale_id, sale_date, total_amount,
       LAG(total_amount) OVER (ORDER BY sale_date) AS previous_sale_amount
FROM assignment.sales;

-- 79. Show the next sale amount for each sale ordered by sale_date.
SELECT sale_id, sale_date, total_amount,
       LEAD(total_amount) OVER (ORDER BY sale_date) AS next_sale_amount
FROM assignment.sales;

-- 80. Divide customers into 4 groups based on total spending.
SELECT c.customer_id, c.first_name, c.last_name,
       SUM(s.total_amount) AS total_spent,
       NTILE(4) OVER (ORDER BY SUM(s.total_amount) DESC) AS spending_group
FROM assignment.customers c
JOIN assignment.sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;