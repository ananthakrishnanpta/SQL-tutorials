# **MySQL Cursors Tutorial**

## **1. Introduction to MySQL Cursors**

In MySQL, a **cursor** is a database object used to retrieve, manipulate, and navigate through a result set row-by-row. Unlike typical SQL queries that return a whole result set at once, cursors allow you to fetch individual rows one at a time, enabling more control over the data during processing. Cursors are typically used in stored procedures or functions when you need to process query results row by row.

### **Why Use Cursors?**
- **Row-by-row processing:** Useful when you need to process each row of a result set individually.
- **Complex logic:** Allows for more advanced logic, such as conditional processing or looping through rows, that is not easily achievable using regular SQL.
- **Iterative processing:** Often used in situations where the logic requires iterations over the result set (e.g., performing operations on each row based on its data).

---

## **2. Cursor Syntax**

The basic steps to create and use a cursor in MySQL involve declaring the cursor, opening it, fetching rows, and closing it. Here’s the syntax for working with a cursor:

```sql
DECLARE cursor_name CURSOR FOR select_statement;
OPEN cursor_name;
FETCH cursor_name INTO variable_name;
CLOSE cursor_name;
```

### **Steps in Using a Cursor:**
1. **DECLARE:** Define a cursor with a SELECT statement.
2. **OPEN:** Initialize the cursor and start fetching data.
3. **FETCH:** Retrieve a row from the result set into a variable.
4. **CLOSE:** Close the cursor when done.

---

## **3. Example: Using a Cursor to Process Data**

Let’s walk through an example that demonstrates how to use a cursor to process rows one at a time. Consider a scenario where we want to calculate the total sales for each product in an `orders` table.

### **3.1 Create the Necessary Tables**

```sql
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DOUBLE
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);
```

### **3.2 Insert Sample Data**

```sql
INSERT INTO products (name, price) VALUES
('Laptop', 1000),
('Smartphone', 500),
('Tablet', 300);

INSERT INTO orders (product_id, quantity, order_date) VALUES
(1, 2, '2024-12-01'),
(2, 5, '2024-12-02'),
(3, 3, '2024-12-03');
```

### **3.3 Declaring and Using a Cursor**

Now, let's declare a cursor to calculate the total sales for each product.

```sql
DELIMITER $$

CREATE PROCEDURE calculate_sales()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE prod_id INT;
    DECLARE prod_price DOUBLE;
    DECLARE total_sales DOUBLE;

    -- Declare a cursor for product sales data
    DECLARE sales_cursor CURSOR FOR
        SELECT p.id, p.price
        FROM products p;

    -- Declare a handler to handle the end of the cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN sales_cursor;

    -- Loop through the rows of the cursor
    read_loop: LOOP
        FETCH sales_cursor INTO prod_id, prod_price;

        -- Exit the loop if no more rows are fetched
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Calculate total sales for the product
        SELECT SUM(o.quantity * prod_price) INTO total_sales
        FROM orders o
        WHERE o.product_id = prod_id;

        -- Output the total sales for the product
        SELECT prod_id AS product_id, total_sales;
    END LOOP;

    -- Close the cursor
    CLOSE sales_cursor;
END$$

DELIMITER ;
```

### **Explanation:**
- **DECLARE done INT DEFAULT FALSE;**: A variable to track whether all rows have been fetched from the cursor.
- **DECLARE prod_id, prod_price:** Variables to hold the product ID and price for each row returned by the cursor.
- **DECLARE sales_cursor CURSOR FOR SELECT ...;**: Defines the cursor to select the product ID and price from the `products` table.
- **DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;**: A handler to set the `done` flag when the cursor reaches the end of the result set.
- **OPEN sales_cursor;**: Opens the cursor to start fetching data.
- **FETCH sales_cursor INTO prod_id, prod_price;**: Fetches a row from the cursor into the specified variables.
- **SELECT SUM(o.quantity * prod_price) INTO total_sales;**: Calculates the total sales for each product by multiplying the quantity in `orders` by the product price.
- **LEAVE read_loop;**: Exits the loop when all rows have been processed.
- **CLOSE sales_cursor;**: Closes the cursor after use.

### **3.4 Execute the Procedure**

To run the procedure and calculate total sales for each product:

```sql
CALL calculate_sales();
```

This will output the total sales for each product in the database.

---

## **4. Cursor with Multiple FETCH Statements**

If your cursor needs to handle multiple rows per iteration, you can use `FETCH` to iterate over each row. Here’s an example that demonstrates how to process the `orders` table and output order details:

```sql
DELIMITER $$

CREATE PROCEDURE fetch_order_details()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE order_id INT;
    DECLARE prod_id INT;
    DECLARE quantity INT;
    DECLARE order_date DATE;

    -- Declare a cursor for fetching orders
    DECLARE order_cursor CURSOR FOR
        SELECT id, product_id, quantity, order_date
        FROM orders;

    -- Declare a handler to handle the end of the cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN order_cursor;

    -- Loop through the rows of the cursor
    order_loop: LOOP
        FETCH order_cursor INTO order_id, prod_id, quantity, order_date;

        -- Exit the loop if no more rows are fetched
        IF done THEN
            LEAVE order_loop;
        END IF;

        -- Output order details
        SELECT order_id, prod_id, quantity, order_date;
    END LOOP;

    -- Close the cursor
    CLOSE order_cursor;
END$$

DELIMITER ;
```

### **Explanation:**
- **DECLARE order_cursor CURSOR FOR SELECT ...;**: Defines the cursor to fetch order details.
- **FETCH order_cursor INTO order_id, prod_id, quantity, order_date;**: Fetches each row into the respective variables.
- **LEAVE order_loop;**: Exits the loop when all rows are processed.
- **CLOSE order_cursor;**: Closes the cursor.

---

## **5. Cursor Limitations and Best Practices**

While cursors provide a powerful mechanism for row-by-row processing, they also come with certain limitations:

### **5.1 Performance Considerations**
- **Inefficiency:** Cursors can be less efficient compared to set-based operations, as they require more server resources and time.
- **Memory Usage:** Each cursor consumes server memory. Keep the result set small if possible to avoid excessive memory usage.

### **5.2 Use Cases for Cursors**
- **Complex logic:** When the task requires logic that cannot be easily expressed in a single SQL query.
- **Batch processing:** Iterating over result sets for complex batch updates or inserts.

### **5.3 Alternatives**
- **Set-based operations:** Whenever possible, prefer set-based SQL operations over cursors for better performance.
- **Temporary tables:** Use temporary tables to hold intermediate results and avoid using cursors.

---

## **6. Example Database DDL and DML**

### **DDL Statements for the `shop` Database**

```sql
CREATE DATABASE shop;
USE shop;

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DOUBLE
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
INSERT INTO products (name, price) VALUES
('Laptop', 1000),
('Smartphone', 500),
('Tablet', 300);

INSERT INTO orders (product_id, quantity, order_date) VALUES
(1, 2, '2024-12-01'),
(2, 5, '2024-12-02'),
(3, 3, '2024-12-03');
```

---

## **7. Navigation**

- [Back to Top](#mysql-cursors-tutorial)

---
