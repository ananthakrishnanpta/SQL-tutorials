# **MySQL Functions Tutorial**

## **1. Introduction to MySQL Functions**

A function in MySQL is a reusable routine that performs a specific operation and returns a value. Unlike stored procedures, functions must return a value and are used in SQL queries, making them ideal for calculations, transformations, and validations.

### **Why Use Functions?**
- **Reusability:** Define once, use across multiple queries.
- **Simplified Queries:** Encapsulate logic for cleaner SQL.
- **Flexibility:** Integrate with SELECT, WHERE, and other SQL clauses.

---

## **2. Syntax of a Function**

The general syntax for creating a function is:

```sql
DELIMITER $$

CREATE FUNCTION function_name (parameter_name datatype, ...)
RETURNS return_datatype
DETERMINISTIC|NOT DETERMINISTIC
BEGIN
   -- SQL logic
   RETURN value;
END$$

DELIMITER ;
```

- **`function_name`:** Name of the function.
- **Parameters:** Input parameters, must be explicitly typed.
- **`RETURNS`:** Specifies the data type of the return value.
- **Determinism:**
  - **DETERMINISTIC:** The function always returns the same result for the same inputs.
  - **NOT DETERMINISTIC:** The function might return different results for the same inputs (e.g., functions using random or time-based logic).
- **`RETURN`:** Specifies the value to return.

---

## **3. Using Functions in SQL**

Once created, functions can be used directly in SQL queries:

- **In SELECT Statements:**
  ```sql
  SELECT function_name(arguments) FROM table_name;
  ```
- **In WHERE Clauses:**
  ```sql
  SELECT * FROM table_name WHERE function_name(arguments) = value;
  ```

---

## **4. Examples of Functions**
- For the tables utilized in the examples:
- [Go to DDL and DML](#7-example-database-ddl-and-dml)
  
### **4.1 Scalar Functions**
A function that returns a single value.

#### Example: Add Two Numbers
```sql
CREATE FUNCTION add_numbers(a INT, b INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN a + b;
END;
```

Usage:
```sql
SELECT add_numbers(10, 20) AS sum;
```

---

### **4.2 String Manipulation Functions**
Custom functions for operations on strings.

#### Example: Reverse a String
```sql
CREATE FUNCTION reverse_string(input_str VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    RETURN REVERSE(input_str);
END;
```

Usage:
```sql
SELECT reverse_string('Hello') AS reversed;
```

---

### **4.3 Date Functions**
Work with date and time values.

#### Example: Calculate Age
```sql
CREATE FUNCTION calculate_age(birth_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, birth_date, CURDATE());
END;
```

Usage:
```sql
SELECT calculate_age('1990-01-01') AS age;
```

---

### **4.4 Conditional Logic in Functions**
Perform conditional checks within functions.

#### Example: Check Account Balance
```sql
CREATE FUNCTION is_balance_sufficient(account_id INT, required_balance DOUBLE)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE current_balance DOUBLE;

    SELECT account_balance INTO current_balance FROM accounts WHERE id = account_id;

    RETURN current_balance >= required_balance;
END;
```

Usage:
```sql
SELECT is_balance_sufficient(1, 1000) AS sufficient;
```

---

## **5. Return Data Types**

MySQL functions can return values of the following data types:

### **5.1 Numeric Data Types**
- **INT, TINYINT, SMALLINT, BIGINT**
- **FLOAT, DOUBLE, DECIMAL**

Example:
```sql
CREATE FUNCTION square_number(n DOUBLE)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    RETURN n * n;
END;
```

### **5.2 String Data Types**
- **CHAR, VARCHAR, TEXT**

Example:
```sql
CREATE FUNCTION uppercase_string(input_str VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    RETURN UPPER(input_str);
END;
```

### **5.3 Date and Time Data Types**
- **DATE, DATETIME, TIMESTAMP, TIME, YEAR**

Example:
```sql
CREATE FUNCTION next_weekday(date_value DATE)
RETURNS DATE
DETERMINISTIC
BEGIN
    RETURN DATE_ADD(date_value, INTERVAL 1 DAY);
END;
```

### **5.4 JSON Data Types**
- **JSON**

Example:
```sql
CREATE FUNCTION extract_json_value(json_data JSON, key_name VARCHAR(50))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    RETURN JSON_UNQUOTE(JSON_EXTRACT(json_data, CONCAT('$.', key_name)));
END;
```

---

## **6. Managing Functions**

### **6.1 Viewing Functions**
List all functions in the current database:
```sql
SHOW FUNCTION STATUS WHERE Db = 'database_name';
```

### **6.2 Dropping Functions**
Delete a function:
```sql
DROP FUNCTION IF EXISTS function_name;
```

---

## **7. Example Database DDL and DML**

### **DDL Statements**

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
    order_date DATE
);
```

### **DML Statements**

```sql
INSERT INTO products (name, price, stock) VALUES
('Laptop', 1000.00, 10),
('Smartphone', 500.00, 20),
('Tablet', 300.00, 15);

INSERT INTO orders (product_id, quantity, order_date) VALUES
(1, 2, '2024-12-01'),
(2, 1, '2024-12-02'),
(3, 3, '2024-12-03');
```
---

- [Back to Top](#mysql-functions-tutorial)
- [Go to DDL and DML](#7-example-database-ddl-and-dml)

---
