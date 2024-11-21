**Procedures**, **Functions**, **Triggers**, and **Cursors** in MySQL, with all keywords explained. (Training documentation)
  - **Anantha Krishnan PTA**
  -  Research Engineer, Centre for Networked Intelligence, IISc Bengaluru 

---

# **MySQL Notes: Procedures, Functions, Triggers, and Cursors**

---

## **1. Stored Procedures**

### **Definition**
A stored procedure is a precompiled SQL code that you can store and reuse. It allows developers to encapsulate frequently used queries into a single procedure, which can be executed with a simple command.

---

### **Key Concepts and Keywords**
1. **`CREATE PROCEDURE`**: Defines a new procedure.
2. **`IN`**: Indicates an input parameter, which is passed to the procedure when called.
3. **`OUT`**: Indicates an output parameter, which is returned to the caller.
4. **`INOUT`**: Acts as both input and output for the procedure.
5. **`DELIMITER`**: Changes the default statement delimiter (usually `;`) to a custom one, allowing us to write compound statements.
6. **`BEGIN ... END`**: Defines the block of code that makes up the procedure.

---

### **Syntax**
```sql
DELIMITER //
CREATE PROCEDURE procedure_name ([IN | OUT | INOUT] parameter_name datatype, ...)
BEGIN
    -- SQL statements
END;
DELIMITER ;
```

---

### **Example: Procedure to Retrieve Department-Wise Average Salary**
- The procedure GetAvgSalaryByDept calculates the average salary for each department.
- It groups the Salaries table by dept_id and computes the average salary using the AVG() function.

```sql
DELIMITER //
CREATE PROCEDURE GetAvgSalaryByDept()
BEGIN
    SELECT d.dept_name, AVG(s.salary) AS avg_salary
    FROM Departments d
    JOIN Employees e ON d.dept_id = e.dept_id
    JOIN Salaries s ON e.emp_id = s.emp_id
    GROUP BY d.dept_name;
END //
DELIMITER ;
```

#### **Explanation of Example**
- **Input**: None (parameters can be added if needed).
- **Output**: Department name and its average salary.
- The procedure uses **joins** to combine three tables and calculates the average salary for each department.

#### **Calling the Procedure**
```sql
CALL GetAvgSalaryByDept();
```

### Example with IN parameter
- This procedure calculates the average salary for a specific department based on the dept_id passed as an input parameter.

```sql
DELIMITER //
CREATE PROCEDURE GetAvgSalaryByDeptIN(
    IN input_dept_id INT
)
BEGIN
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM salaries s
    JOIN employees e ON s.emp_id = e.emp_id
    WHERE e.dept_id = input_dept_id
    GROUP BY dept_id;
END //
DELIMITER ;
```
## To call the procedure

```sql
CALL GetAvgSalaryByDeptIN(1); -- Replace 1 with the desired department ID.
```
### Example with OUT parameter
- This procedure returns the average salary for all departments combined, using an output parameter.
  
```sql
DELIMITER //
CREATE PROCEDURE GetAvgSalaryByDeptOUT(
    OUT overall_avg_salary FLOAT
)
BEGIN
    SELECT AVG(salary) INTO overall_avg_salary
    FROM salaries;
END //
DELIMITER ;
```
## To call the procedure

```sql
CALL GetAvgSalaryByDeptOUT(@avg_salary);
SELECT @avg_salary; -- Retrieve the output parameter value.
```

### Example with IN and OUT Parameters
- This procedure calculates and returns the average salary for a specific department based on the dept_id passed as an input parameter.

```sql
DELIMITER //
CREATE PROCEDURE GetAvgSalaryByDeptINOUT(
    IN input_dept_id INT,
    OUT avg_salary FLOAT
)
BEGIN
    SELECT AVG(salary) INTO avg_salary
    FROM salaries s
    JOIN employees e ON s.emp_id = e.emp_id
    WHERE e.dept_id = input_dept_id;
END //
DELIMITER ;
```
## To call the procedure

```sql
CALL GetAvgSalaryByDeptINOUT(1, @avg_salary); -- Replace 1 with the desired department ID.
SELECT @avg_salary; -- Retrieve the output parameter value.
```

---

## **2. Functions**

### **Definition**
A function in MySQL is a stored program that performs calculations and returns a single value. It is often used in `SELECT` queries or as part of an expression.

---

### **Key Concepts and Keywords**
1. **`CREATE FUNCTION`**: Defines a new function.
2. **`RETURNS`**: Specifies the data type of the value returned by the function.
3. **`RETURN`**: Specifies the value to return when the function is called.
4. **`DECLARE`**: Used to define variables inside the function.

---

### **Syntax**
```sql
CREATE FUNCTION function_name (parameter_name datatype, ...)
RETURNS datatype
BEGIN
    -- SQL statements
    RETURN value;
END;
```

---

### **Example: Function to Calculate Total Salary of an Employee**
```sql
DELIMITER //
CREATE FUNCTION GetTotalSalary(emp_id INT)
RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total_salary DECIMAL(10, 2);
    SELECT SUM(salary) INTO total_salary
    FROM Salaries
    WHERE emp_id = emp_id;
    RETURN total_salary;
END //
DELIMITER ;
```

#### **Explanation of Example**
- **Input**: Employee ID (`emp_id`).
- **Output**: The total salary earned by the employee.
- **`DECLARE`** is used to create a variable to store the calculated salary.

#### **Calling the Function**
```sql
SELECT GetTotalSalary(1); -- Replace '1' with the Employee ID
```

---

## **3. Triggers**

### **Definition**
A trigger is a database object that is automatically executed (or "triggered") in response to certain events on a table, such as `INSERT`, `UPDATE`, or `DELETE`.

---

### **Key Concepts and Keywords**
1. **`CREATE TRIGGER`**: Defines a new trigger.
2. **`BEFORE` | `AFTER`**: Specifies whether the trigger executes before or after the event.
3. **`INSERT` | `UPDATE` | `DELETE`**: The event that activates the trigger.
4. **`OLD`**: Refers to the row before the event (available for `UPDATE` and `DELETE` triggers).
5. **`NEW`**: Refers to the row after the event (available for `INSERT` and `UPDATE` triggers).

---

### **Syntax**
```sql
CREATE TRIGGER trigger_name
AFTER | BEFORE [INSERT | UPDATE | DELETE]
ON table_name
FOR EACH ROW
BEGIN
    -- SQL statements
END;
```

---

### **Example: Trigger to Log Salary Updates**
```sql
DELIMITER //
CREATE TRIGGER AuditSalaryUpdate
AFTER UPDATE ON Salaries
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (emp_id, old_salary, new_salary, change_date)
    VALUES (OLD.emp_id, OLD.salary, NEW.salary, NOW());
END //
DELIMITER ;
```

#### **Explanation of Example**
- The trigger logs salary changes into an **AuditLog** table.
- **`OLD`** references the employee's previous salary.
- **`NEW`** references the employee's updated salary.

#### **Test the Trigger**
```sql
UPDATE Salaries
SET salary = 90000.00
WHERE emp_id = 1 AND salary_date = '2024-01-15';
```

---

## **4. Cursors**

### **Definition**
A cursor allows row-by-row processing of query results. It is useful when operations need to be performed on individual rows.

---

### **Key Concepts and Keywords**
1. **`DECLARE CURSOR`**: Defines a cursor for a query.
2. **`OPEN`**: Opens the cursor and fetches the result set.
3. **`FETCH`**: Retrieves the next row in the result set.
4. **`CLOSE`**: Closes the cursor after processing.
5. **`DECLARE CONTINUE HANDLER`**: Defines how to handle the end of a cursor's result set.

---

### **Syntax**
```sql
DECLARE cursor_name CURSOR FOR query;

OPEN cursor_name;
FETCH cursor_name INTO variables;
CLOSE cursor_name;
```

---

### **Example: Cursor to Process Bonuses**
```sql
DELIMITER //
CREATE PROCEDURE ProcessBonuses()
BEGIN
    DECLARE emp_id INT;
    DECLARE done INT DEFAULT FALSE;

    -- Declare a cursor
    DECLARE bonus_cursor CURSOR FOR SELECT emp_id FROM Employees;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open cursor
    OPEN bonus_cursor;

    read_loop: LOOP
        FETCH bonus_cursor INTO emp_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Example operation: Print or update bonuses (logic goes here)
    END LOOP;

    -- Close cursor
    CLOSE bonus_cursor;
END //
DELIMITER ;
```

#### **Explanation of Example**
- **`DECLARE`** creates the cursor for the `SELECT` query.
- **`OPEN`** initializes the cursor.
- **`FETCH`** retrieves rows one at a time.
- **`LEAVE`** exits the loop when all rows are processed.

---

## **5. Summary**

| Feature     | Purpose                                      | Key Components                   |
|-------------|----------------------------------------------|-----------------------------------|
| **Procedure** | Reusable logic encapsulation                 | `IN`, `OUT`, `INOUT`, `CALL`      |
| **Function**  | Returns a single value                       | `RETURNS`, `RETURN`, `SELECT`     |
| **Trigger**   | Automatic execution on table events          | `BEFORE`, `AFTER`, `OLD`, `NEW`   |
| **Cursor**    | Row-by-row processing of query results       | `DECLARE`, `OPEN`, `FETCH`, `CLOSE` |

With these tools, you can automate tasks, enforce data integrity, and simplify database operations.
