# **MySQL Procedures Tutorial**

## **1. Introduction to MySQL Procedures**

A procedure in MySQL is a set of SQL statements that perform a specific task. Stored procedures are stored in the database and can be executed repeatedly. They help improve code reusability, maintainability, and reduce redundancy.

### **Why Use Procedures?**
- **Code Reusability:** Encapsulate frequently used logic.
- **Improved Performance:** Reduce network overhead by sending a single procedure call instead of multiple queries.
- **Security:** Users can execute procedures without direct access to the underlying tables.

---

## **2. Syntax of a Procedure**

The general syntax for creating a procedure is:

```sql
DELIMITER $$

CREATE PROCEDURE procedure_name ([IN|OUT|INOUT] parameter_name datatype, ...)
BEGIN
   -- SQL statements;
END$$

DELIMITER ;
```

- **`DELIMITER`:** Changes the default statement delimiter (`;`) to avoid conflicts within the procedure.
- **`procedure_name`:** The name of the procedure.
- **Parameters:**
  - **IN:** Input parameter (default).
  - **OUT:** Output parameter, used to return values.
  - **INOUT:** Acts as both input and output.
- **`BEGIN...END`:** Encapsulates the SQL block.

---
- For the Tables utilized in the given examples:
- [Back to Top](#mysql-procedures-tutorial)
---

## **3. Declaring Parameters in Procedures**

### **3.1 IN Parameters**

Pass data to the procedure. Example:

```sql
CREATE PROCEDURE greet_user(IN username VARCHAR(50))
BEGIN
    SELECT CONCAT('Hello, ', username, '!') AS greeting;
END;
```

### **3.2 OUT Parameters**

Return data from the procedure. Example:

```sql
CREATE PROCEDURE get_total_users(OUT total_users INT)
BEGIN
    SELECT COUNT(*) INTO total_users FROM users;
END;
```

### **3.3 INOUT Parameters**

Both input and output data. Example:

```sql
CREATE PROCEDURE update_and_return_salary(INOUT salary DOUBLE)
BEGIN
    SET salary = salary * 1.10; -- Increase by 10%
END;
```

---

## **4. Calling Procedures**

Use the `CALL` statement to execute a procedure.

```sql
CALL procedure_name(parameters...);
```

Examples:
- **IN:** `CALL greet_user('Alice');`
- **OUT:** 
  ```sql
  CALL get_total_users(@user_count);
  SELECT @user_count;
  ```
- **INOUT:** 
  ```sql
  SET @salary = 5000;
  CALL update_and_return_salary(@salary);
  SELECT @salary;
  ```

---

## **5. Control Structures in Procedures**

### **5.1 Conditional Statements**
- **IF-ELSE:**

```sql
CREATE PROCEDURE check_balance(IN account_id INT)
BEGIN
    DECLARE balance DOUBLE;
    SELECT account_balance INTO balance FROM accounts WHERE id = account_id;

    IF balance > 1000 THEN
        SELECT 'Sufficient balance';
    ELSE
        SELECT 'Insufficient balance';
    END IF;
END;
```

### **5.2 Loops**
- **WHILE Loop:**

```sql
CREATE PROCEDURE print_numbers()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 10 DO
        SELECT i;
        SET i = i + 1;
    END WHILE;
END;
```

- **REPEAT Loop:**

```sql
CREATE PROCEDURE repeat_example()
BEGIN
    DECLARE i INT DEFAULT 1;

    REPEAT
        SELECT i;
        SET i = i + 1;
    UNTIL i > 10 END REPEAT;
END;
```

---

## **6. Use Cases for Procedures**

### **6.1 Data Validation**
Automate validation of inputs before performing operations.

```sql
CREATE PROCEDURE validate_user_login(IN username VARCHAR(50), IN password VARCHAR(50), OUT is_valid BOOLEAN)
BEGIN
    SELECT EXISTS(SELECT 1 FROM users WHERE username = username AND password = password) INTO is_valid;
END;
```

### **6.2 Complex Operations**
Encapsulate multi-step operations.

```sql
CREATE PROCEDURE transfer_funds(IN sender_id INT, IN receiver_id INT, IN amount DOUBLE)
BEGIN
    START TRANSACTION;

    UPDATE accounts SET balance = balance - amount WHERE id = sender_id;
    UPDATE accounts SET balance = balance + amount WHERE id = receiver_id;

    COMMIT;
END;
```

---

## **7. Managing Procedures**

### **7.1 Viewing Procedures**
List all procedures in the current database:
```sql
SHOW PROCEDURE STATUS WHERE Db = 'database_name';
```

### **7.2 Dropping Procedures**
Delete a procedure:
```sql
DROP PROCEDURE IF EXISTS procedure_name;
```

---

## **8. Example Database DDL and DML**
### **DDL Statements**

```sql
CREATE DATABASE bank;
USE bank;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(50)
);

CREATE TABLE accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    account_balance DOUBLE
);
```

### **DML Statements**

```sql
INSERT INTO users (username, password) VALUES 
('Alice', 'pass123'), 
('Bob', 'secure456');

INSERT INTO accounts (user_id, account_balance) VALUES 
(1, 2000), 
(2, 1500);
```

---

- [Go to DDL and DML](#8-example-database-ddl-and-dml)

---
