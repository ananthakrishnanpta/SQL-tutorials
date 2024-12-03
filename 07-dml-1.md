---

# MySQL DML Commands: **INSERT, UPDATE, DELETE**

---

## 1. **INSERT Command**

### **Definition**:
The `INSERT` command is used to add new records to a table.

### **Syntax**:
```sql
INSERT INTO table_name (column1, column2, ...) VALUES (value1, value2, ...);
```

---

### **Examples**:

#### **a) Insert a Single Row**
**Description**: Adds one record to the `employees` table.
```sql
INSERT INTO employees (id, name, salary) VALUES (1, 'Alice', 50000);
```

---

#### **b) Insert Multiple Rows**
**Description**: Inserts several records into the `employees` table in a single query.
```sql
INSERT INTO employees (id, name, salary) 
VALUES 
  (2, 'Bob', 60000),
  (3, 'Charlie', 70000);
```

---

#### **c) Insert with Default Values**
**Description**: Adds a new record while letting some columns use their default values.
```sql
INSERT INTO employees (id, name) VALUES (4, 'Diana');
```
**Note**: The `salary` column will use its default value, if defined.

---

#### **d) Insert and Ignore Duplicates**
**Description**: Prevents errors when a duplicate record is encountered by ignoring it.
```sql
INSERT IGNORE INTO employees (id, name, salary) VALUES (1, 'Alice', 50000);
```

---

#### **e) Insert or Update if Duplicate Key Exists**
**Description**: Updates the existing record if a duplicate key is found.
```sql
INSERT INTO employees (id, name, salary)
VALUES (1, 'Alice', 55000)
ON DUPLICATE KEY UPDATE salary = VALUES(salary);
```

---

## 2. **UPDATE Command**

### **Definition**:
The `UPDATE` command modifies existing records in a table.

### **Syntax**:
```sql
UPDATE table_name
SET
  column1 = value1,
  column2 = value2,
  ...
WHERE condition;
```

---

### **Important**:  
In MySQL workbench, when multiple records are affected by *UPDATE* or *DELETE* command, if *safe updates mode* is turned **on** (it is on by default), it will prevent the query from running to prevent accidental changes to records.
Hence, when running these commands without a where clause (filtering), it doesn't execute.
After ensuring that the query you are writing is accurate, we can temporarily turn off this feature 
1. **Turn Off Safe Updates**:
   ```sql
   SET SQL_SAFE_UPDATES = 0;
   ```
2. **Run the Update or Delete Command**.
3. **Re-enable Safe Updates**:
   ```sql
   SET SQL_SAFE_UPDATES = 1;
   ```

---

### **Examples**:

#### **a) Update a Single Row**
**Description**: Modifies the `salary` of the employee with `id = 1`.
```sql
UPDATE employees SET salary = 55000 WHERE id = 1;
```

---

#### **b) Update Multiple Rows**
**Description**: Increases the `salary` of all employees earning less than `60000` by `5000`.
```sql
UPDATE employees SET salary = salary + 5000 WHERE salary < 60000;
```

---

#### **c) Update All Rows**
**Description**: Adds a fixed bonus to all employees in the table.  
- **Step 1**: Disable safe updates.
```sql
SET SQL_SAFE_UPDATES = 0;
```
- **Step 2**: Run the update query.
```sql
UPDATE employees SET bonus = 5000;
```
- **Step 3**: Re-enable safe updates.
```sql
SET SQL_SAFE_UPDATES = 1;
```

---

#### **d) Conditional Update Using a Subquery**
**Description**: Updates an employee's `salary` based on the highest salary in another table.
```sql
UPDATE employees
SET salary = (SELECT MAX(salary) FROM employees_backup)
WHERE id = 2;
```

---
#### **Updating with different values depending on conditions**
## **Using `UPDATE` with `CASE` in MySQL**

---

### 1. **What is `CASE` in MySQL?**

The `CASE` statement in MySQL is a conditional construct that works like an **if-else** block. It is often used in `UPDATE` queries to apply different updates to rows based on specific conditions.

#### **Syntax of `CASE` in `UPDATE`**:
```sql
UPDATE table_name
SET column_name = 
  CASE 
    WHEN condition1 THEN value1
    WHEN condition2 THEN value2
    ...
    ELSE default_value
  END
WHERE condition;
```

---

### 2. **How Does It Work in `UPDATE`?**

- The `CASE` statement evaluates conditions row-by-row.
- Based on which `WHEN` condition is true, it sets the value of the column.
- If no conditions match, the `ELSE` block provides a default value.
- The `WHERE` clause (optional) restricts which rows are updated.

---

### 3. **Examples of `UPDATE` with `CASE`**

#### **Example 1: Updating a Salary Based on Job Role**
**Description**: Increase the salary of employees based on their roles:
- Managers get a 10% increase.
- Developers get a 15% increase.
- Interns get a fixed salary of 20000.

```sql
UPDATE employees
SET salary = 
  CASE 
    WHEN role = 'Manager' THEN salary * 1.10
    WHEN role = 'Developer' THEN salary * 1.15
    WHEN role = 'Intern' THEN 20000
    ELSE salary
  END;
```

---

#### **Example 2: Updating Grades Based on Marks**
**Description**: Assign grades to students based on their marks:
- Marks >= 90: Grade = 'A'.
- Marks >= 75 and < 90: Grade = 'B'.
- Marks >= 50 and < 75: Grade = 'C'.
- Marks < 50: Grade = 'F'.

```sql
UPDATE students
SET grade = 
  CASE 
    WHEN marks >= 90 THEN 'A'
    WHEN marks >= 75 THEN 'B'
    WHEN marks >= 50 THEN 'C'
    ELSE 'F'
  END;
```

---

#### **Example 3: Conditional Updates with a `WHERE` Clause**
**Description**: Update employee bonuses only for those in the `Sales` department, based on performance:
- High performance: Bonus = 20% of salary.
- Medium performance: Bonus = 10% of salary.
- Low performance: Bonus = 5% of salary.

```sql
UPDATE employees
SET bonus = 
  CASE 
    WHEN performance = 'High' THEN salary * 0.20
    WHEN performance = 'Medium' THEN salary * 0.10
    WHEN performance = 'Low' THEN salary * 0.05
    ELSE 0
  END
WHERE department = 'Sales';
```

---

#### **Example 4: Using `CASE` with Multiple Columns**
**Description**: Update both `bonus` and `salary` based on an employee's performance:
- High performance: 20% bonus, 10% salary increase.
- Medium performance: 10% bonus, 5% salary increase.
- Low performance: 5% bonus, no salary increase.

```sql
UPDATE employees
SET 
  bonus = CASE 
            WHEN performance = 'High' THEN salary * 0.20
            WHEN performance = 'Medium' THEN salary * 0.10
            WHEN performance = 'Low' THEN salary * 0.05
            ELSE 0
          END,
  salary = CASE 
             WHEN performance = 'High' THEN salary * 1.10
             WHEN performance = 'Medium' THEN salary * 1.05
             ELSE salary
           END;
```

---

#### 4. **Advantages of Using `CASE` in `UPDATE`**

1. **Efficiency**: Allows conditional updates in a single query instead of multiple queries.  
2. **Clarity**: Makes complex updates easier to understand.  
3. **Flexibility**: Can handle multiple conditions and update multiple columns simultaneously.

---

#### 5. **Best Practices**

1. **Test Conditions**: Ensure your `CASE` conditions cover all scenarios to avoid unintended results.
2. **Use the `ELSE` Block**: Always include an `ELSE` block to handle rows that don’t match any condition.
3. **Restrict Rows with `WHERE`**: Use a `WHERE` clause to limit updates to relevant rows.
4. **Back Up Your Data**: Before running complex updates, back up the table to prevent accidental data loss.

---

#### 6. **Common Mistakes to Avoid**

1. **Missing `ELSE`**: If a row doesn’t match any `WHEN` condition and no `ELSE` is provided, the column value becomes `NULL`.  
2. **Not Using a `WHERE` Clause**: Updating all rows unintentionally can lead to data corruption.  
3. **Overcomplicated Conditions**: Break down complex `CASE` logic into simpler statements if possible for better readability.


---

## 3. **DELETE Command**

### **Definition**:
The `DELETE` command removes records from a table. Please note that it cannot be used to remove a single column value from a record. For that we can use `UPDATE` command and set that column value to null.

### **Syntax**:
```sql
DELETE FROM table_name WHERE condition;
```

---

### **Examples**:

#### **a) Delete a Single Row**
**Description**: Deletes the record of the employee with `id = 1`.
```sql
DELETE FROM employees WHERE id = 1;
```

---

#### **b) Delete Multiple Rows**
**Description**: Removes employees earning less than `50000`.
```sql
DELETE FROM employees WHERE salary < 50000;
```

---

#### **c) Delete All Rows in a Table**
**Description**: Removes all data from the `employees` table without deleting its structure.
```sql
DELETE FROM employees;
```

---

#### **d) Delete with Join**
**Description**: Deletes employees associated with a specific department.
```sql
DELETE e
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE d.name = 'Sales';
```

---

#### **e) Truncate the Table (Alternative to DELETE)**
**Description**: Quickly deletes all rows from the table and resets the auto-increment counter.
```sql
TRUNCATE TABLE employees;
```

---

### **Key Differences Between DELETE and TRUNCATE**:
| Feature            | DELETE                     | TRUNCATE                      |
|--------------------|----------------------------|--------------------------------|
| Filters            | Supports `WHERE` clause   | Cannot filter rows            |
| Rollback           | Possible (if transactional)| Not possible                  |
| Performance        | Slower (row-by-row delete)| Faster (resets the table)     |

---

## 4. **Best Practices**
1. Always use a `WHERE` clause in `UPDATE` and `DELETE` to avoid unintended changes.  
2. For large-scale deletions, use batches to avoid locking issues.  
3. Test queries in a development environment before running them in production.  
4. Use `INSERT IGNORE` or `ON DUPLICATE KEY UPDATE` to handle duplicate entries gracefully.  
5. Temporarily disable safe updates in MySQL Workbench for global updates but re-enable them afterward.

---
