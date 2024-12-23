# **MySQL Views Tutorial (Including Materialized Views)**

## **1. Introduction to MySQL Views**

A **view** in MySQL is a virtual table based on the result set of a SQL query. It doesn't store data itself but displays data from one or more tables, allowing you to treat the result set as if it were a regular table. Views are especially useful for simplifying complex queries, enhancing security, and providing a convenient way to manage frequently used queries.

**Materialized Views** are not natively supported in MySQL but are often simulated using tables that are periodically refreshed. A materialized view is a persistent database object that stores the result of a query physically. It offers faster performance for certain types of queries, especially for complex or frequently accessed data, as the result is precomputed and stored.

### **Why Use Views?**
- **Simplify Complex Queries:** Encapsulate complex joins or aggregations.
- **Security:** Grant users access to specific parts of the database without revealing sensitive information.
- **Consistency:** Ensure the same query logic is used across different parts of the application.
- **Data Abstraction:** Abstract the underlying database schema from the user.

### **Why Use Materialized Views?**
- **Improved Performance:** Materialized views store the result of the query, so data retrieval is faster than recomputing the result set every time.
- **Reduced Load:** By storing the query result, you reduce the load on the underlying tables, especially for heavy aggregations or joins.

---

## **2. Basic Syntax for Creating a View**

The syntax to create a view is as follows:

```sql
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

- **`view_name`:** The name of the view.
- **`SELECT` statement:** The query that defines the data the view will represent.

---

## **3. Types of Views**

### **3.1 Simple Views**
A **simple view** is based on a single table or a straightforward `SELECT` statement. It does not contain complex operations like `JOIN`, `GROUP BY`, or `DISTINCT`.

#### Example: Simple View
Let's create a simple view that shows product names and their prices from the `products` table.

```sql
CREATE VIEW product_view AS
SELECT name, price
FROM products;
```

- This view represents a selection of columns (`name` and `price`) from the `products` table.

---

### **3.2 Complex Views**
A **complex view** can involve multiple tables and operations like `JOIN`, `GROUP BY`, or `ORDER BY`. These views allow you to combine data from different tables into a single, simplified view.

#### Example: Complex View
Let's create a view that joins the `orders` and `products` tables to display detailed order information.

```sql
CREATE VIEW order_details AS
SELECT o.id AS order_id, o.product_id, p.name AS product_name, o.quantity, o.order_date
FROM orders o
JOIN products p ON o.product_id = p.id;
```

- This view combines data from two tables (`orders` and `products`) using a `JOIN` operation, providing a detailed list of orders.

---

### **3.3 Updatable Views**
An **updatable view** is one that allows you to modify data in the underlying table(s) through the view itself. In general, views are updatable if they meet certain conditions:
- The view selects from a single table.
- The view doesn't involve aggregation functions like `COUNT`, `SUM`, etc.
- The view doesn't use `DISTINCT`, `GROUP BY`, or `JOIN`.

#### Example: Updatable View
Create a view that allows updates to product prices:

```sql
CREATE VIEW product_prices AS
SELECT id, name, price
FROM products;
```

- This view can be used to update the prices of products, as it maps directly to the `products` table.

You can now perform updates on the `product_prices` view:

```sql
UPDATE product_prices
SET price = 950
WHERE id = 1;
```

This will update the `price` of the product with `id = 1` in the underlying `products` table.

---

### **3.4 Non-Updatable Views**
A **non-updatable view** is one where you cannot perform `INSERT`, `UPDATE`, or `DELETE` operations through the view. These views typically involve complex queries, such as joins, aggregations, or unions, which prevent modifications.

#### Example: Non-Updatable View
Create a view that calculates the total sales for each product, which is non-updatable:

```sql
CREATE VIEW total_sales AS
SELECT p.id AS product_id, p.name, SUM(o.quantity * p.price) AS total_sales
FROM orders o
JOIN products p ON o.product_id = p.id
GROUP BY p.id;
```

- This view aggregates data and cannot be used to modify the `orders` or `products` tables directly.

---

### **3.5 Materialized Views (Simulated in MySQL)**

A **materialized view** stores the result of the query physically, which can then be queried like a regular table. In MySQL, there is no native support for materialized views, so we simulate them using a regular table to store the query results and periodically refresh the data.

#### Example: Simulating a Materialized View

Let’s create a materialized view that shows the total sales for each product. Instead of using a view, we’ll use a table to store the result.

```sql
CREATE TABLE materialized_total_sales AS
SELECT p.id AS product_id, p.name, SUM(o.quantity * p.price) AS total_sales
FROM orders o
JOIN products p ON o.product_id = p.id
GROUP BY p.id;
```

Now, `materialized_total_sales` acts like a materialized view. You can query it directly:

```sql
SELECT * FROM materialized_total_sales;
```

To refresh the materialized view, you can drop and recreate the table or use an `UPDATE` operation, depending on your needs.

```sql
TRUNCATE TABLE materialized_total_sales;

INSERT INTO materialized_total_sales
SELECT p.id AS product_id, p.name, SUM(o.quantity * p.price) AS total_sales
FROM orders o
JOIN products p ON o.product_id = p.id
GROUP BY p.id;
```

- This simulates refreshing the materialized view by clearing the existing data and inserting the latest data.

---

## **4. Operations on Views**

### **4.1 Creating Views**

The basic syntax to create a view is shown earlier. Views can be created using `SELECT` statements, joining multiple tables, filtering rows, or performing aggregations.

#### Example: Creating a View with a Filter
Create a view that shows only products with stock greater than 10:

```sql
CREATE VIEW available_products AS
SELECT name, price, stock
FROM products
WHERE stock > 10;
```

---

### **4.2 Viewing All Views**

To view all views in the current database, you can run the following command:

```sql
SHOW FULL TABLES WHERE Table_type = 'VIEW';
```

This will list all views defined in the current database.

---

### **4.3 Altering Views**

If you need to modify an existing view, you can use the `ALTER VIEW` statement, but in MySQL, it's more common to drop the old view and create a new one.

#### Example: Altering a View
To alter the `available_products` view to show products with a stock greater than 20:

1. Drop the existing view:

```sql
DROP VIEW IF EXISTS available_products;
```

2. Create the new view:

```sql
CREATE VIEW available_products AS
SELECT name, price, stock
FROM products
WHERE stock > 20;
```

---

### **4.4 Dropping Views**

To remove a view from the database, you can use the `DROP VIEW` statement:

```sql
DROP VIEW IF EXISTS view_name;
```

For example, to drop the `available_products` view:

```sql
DROP VIEW IF EXISTS available_products;
```

---

### **4.5 Selecting from Views**

You can select data from a view just like selecting from a table:

```sql
SELECT * FROM order_details;
```

This retrieves the data from the `order_details` view.

---

### **4.6 Updating Views**

If the view is **updatable**, you can perform `INSERT`, `UPDATE`, or `DELETE` operations through it:

#### Example: Updating Data through a View
To update a product price through the `product_prices` view:

```sql
UPDATE product_prices
SET price = 1200
WHERE id = 2;
```

This will update the price of the product with `id = 2` in the underlying `products` table.

---

## **5. Best Practices for Using Views**

- **Performance Considerations:** Views can simplify queries, but they can also add overhead. If a view is complex and queried frequently, it can degrade performance.
- **Avoid Overuse:** Use views when necessary, but avoid creating too many layers of views that complicate debugging and understanding of the database schema.
- **Security:** Use views to restrict access to sensitive data. For example, a view can provide limited access to certain columns of a table while hiding others.

---

## **6. Example Database DDL and DML**

### **DDL Statements for the `shop` Database**

```sql
CREATE DATABASE shop;
USE shop;

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DOUBLE,
    stock INT
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);
```

### **DML Statements**

```sql
INSERT INTO products (name, price, stock) VALUES
('Laptop', 1000, 10),
('Smartphone', 500, 20),
('Tablet', 300, 15);

INSERT INTO orders (product_id, quantity, order_date) VALUES
(1, 2, '2024-12-01'),
(2, 5, '2024-12-02'),
(3, 3, '2024-12-03');
```

---

## **7. Navigation**

- [Back to Top](#mysql-views-tutorial)

---
