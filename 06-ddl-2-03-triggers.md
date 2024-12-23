# **MySQL Triggers Tutorial**

## **1. Introduction to MySQL Triggers**

A trigger is a set of SQL statements that automatically execute or fire when a specified event occurs on a specified table. Triggers are particularly useful for enforcing business rules, maintaining data integrity, and performing automatic updates.

### **Why Use Triggers?**
- **Data Integrity:** Automatically update related data or enforce constraints.
- **Auditing:** Track changes to data over time for auditing purposes.
- **Business Logic:** Automatically apply changes, such as updating stock or generating logs.

---

## **2. Syntax of a Trigger**

The general syntax for creating a trigger is as follows:

```sql
DELIMITER $$

CREATE TRIGGER trigger_name
{BEFORE|AFTER} {INSERT|UPDATE|DELETE}
ON table_name
FOR EACH ROW
BEGIN
   -- SQL logic
END$$

DELIMITER ;
```

- **`trigger_name`:** The name of the trigger.
- **`{BEFORE|AFTER}`:** Specifies whether the trigger fires before or after the event.
- **`{INSERT|UPDATE|DELETE}`:** The event that triggers the action.
- **`table_name`:** The table to which the trigger is associated.
- **`FOR EACH ROW`:** Ensures the trigger fires for each affected row.
- **`BEGIN...END`:** Encapsulates the SQL statements to be executed when the trigger is fired.

---

## **3. Types of Triggers**

### **3.1 BEFORE Triggers**
- **Fires before the event** (e.g., `INSERT`, `UPDATE`, `DELETE`).
- **Use Cases:**
  - Validating data before insertion or update.
  - Preventing invalid operations (e.g., negative prices or out-of-stock updates).
  
#### Example: BEFORE INSERT
Ensure that a product has a positive price before being inserted into the `products` table:

```sql
DELIMITER $$

CREATE TRIGGER validate_product_price
BEFORE INSERT
ON products
FOR EACH ROW
BEGIN
    IF NEW.price <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Price must be greater than zero';
    END IF;
END$$

DELIMITER ;
```

---

### **3.2 AFTER Triggers**
- **Fires after the event** (e.g., `INSERT`, `UPDATE`, `DELETE`).
- **Use Cases:**
  - Updating related tables after a change.
  - Logging actions for auditing.

#### Example: AFTER INSERT
Automatically update stock levels after an order is placed:

```sql
DELIMITER $$

CREATE TRIGGER update_product_stock
AFTER INSERT
ON orders
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE id = NEW.product_id;
END$$

DELIMITER ;
```

---

### **3.3 BEFORE UPDATE Triggers**
- **Fires before an update** is performed on a row.
- **Use Cases:**
  - Preventing updates that would lead to invalid data.
  - Validating new data before it's committed.

#### Example: BEFORE UPDATE
Prevent setting the product price to a negative value:

```sql
DELIMITER $$

CREATE TRIGGER prevent_negative_price
BEFORE UPDATE
ON products
FOR EACH ROW
BEGIN
    IF NEW.price < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Price cannot be negative';
    END IF;
END$$

DELIMITER ;
```

---

### **3.4 AFTER UPDATE Triggers**
- **Fires after an update** is performed on a row.
- **Use Cases:**
  - Logging changes made to data.
  - Performing additional actions after a data update.

#### Example: AFTER UPDATE
Log changes to product prices:

```sql
DELIMITER $$

CREATE TRIGGER track_price_change
AFTER UPDATE
ON products
FOR EACH ROW
BEGIN
    IF OLD.price <> NEW.price THEN
        INSERT INTO price_audit (product_id, old_price, new_price, changed_at)
        VALUES (NEW.id, OLD.price, NEW.price, NOW());
    END IF;
END$$

DELIMITER ;
```

#### Creating the `price_audit` Table:

```sql
CREATE TABLE price_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    old_price DOUBLE,
    new_price DOUBLE,
    changed_at DATETIME
);
```

---

### **3.5 BEFORE DELETE Triggers**
- **Fires before a row is deleted**.
- **Use Cases:**
  - Preventing deletion based on conditions (e.g., if a product is linked to orders).
  - Logging deletions.

#### Example: BEFORE DELETE
Prevent deleting a product if it’s associated with existing orders:

```sql
DELIMITER $$

CREATE TRIGGER prevent_product_deletion
BEFORE DELETE
ON products
FOR EACH ROW
BEGIN
    DECLARE order_count INT;
    
    SELECT COUNT(*) INTO order_count
    FROM orders
    WHERE product_id = OLD.id;

    IF order_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete product with existing orders';
    END IF;
END$$

DELIMITER ;
```

---

### **3.6 AFTER DELETE Triggers**
- **Fires after a row is deleted**.
- **Use Cases:**
  - Auditing or logging deleted data.
  - Cleaning up related data after deletion.

#### Example: AFTER DELETE
Log deleted orders in an audit table:

```sql
DELIMITER $$

CREATE TRIGGER audit_order_deletion
AFTER DELETE
ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_audit (order_id, product_id, quantity, deleted_at)
    VALUES (OLD.id, OLD.product_id, OLD.quantity, NOW());
END$$

DELIMITER ;
```

#### Creating the `order_audit` Table:

```sql
CREATE TABLE order_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    deleted_at DATETIME
);
```

---

## **4. Row-Level Triggers**

A **row-level trigger** executes once for each row affected by the operation. In MySQL, all triggers are by default **row-level** triggers, meaning the trigger runs once for each affected row in a multi-row operation.

### Example: Row-Level Trigger for Logging Order Deletion

Whenever an order is deleted, log the order's details to an audit table. This operation occurs for each affected row.

```sql
DELIMITER $$

CREATE TRIGGER log_order_deletion
AFTER DELETE
ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_audit (order_id, product_id, quantity, deleted_at)
    VALUES (OLD.id, OLD.product_id, OLD.quantity, NOW());
END$$

DELIMITER ;
```

- **Explanation:** This trigger is executed for each row in the `orders` table that is deleted. If multiple rows are deleted at once, the trigger will fire once per row, logging the relevant data.

---

## **5. Managing Triggers**

### **5.1 Viewing Triggers**
To see all triggers in the current database:
```sql
SHOW TRIGGERS;
```

### **5.2 Dropping Triggers**
To delete a trigger, use the `DROP TRIGGER` command:

```sql
DROP TRIGGER IF EXISTS trigger_name;
```

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
    order_date DATE
);

CREATE TABLE price_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    old_price DOUBLE,
    new_price DOUBLE,
    changed_at DATETIME
);

CREATE TABLE order_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    deleted_at DATETIME
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

## **7. Navigation**

- [Back to Top](#mysql-triggers-tutorial)

---
