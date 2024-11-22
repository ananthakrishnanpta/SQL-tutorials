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
When updating all rows without a `WHERE` clause, MySQL Workbench has **safe updates mode** enabled by default. To perform such updates:
1. **Turn Off Safe Updates**:
   ```sql
   SET SQL_SAFE_UPDATES = 0;
   ```
2. **Run the Update Command**.
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

## 3. **DELETE Command**

### **Definition**:
The `DELETE` command removes records from a table.

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
