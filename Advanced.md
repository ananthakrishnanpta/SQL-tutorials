---

# Advanced MySQL Concepts  
**Procedures, Functions, Triggers, and Cursors**  
**With Practical Examples and Schema Design**  

---

## Slide 1: Title Slide  
**Advanced MySQL Concepts**  
Procedures, Functions, Triggers, and Cursors  
With Practical Examples and Schema Design  
**Author:** Anantha Krishnan PTA  
**Institution:** ITvedant Institute  

---

## Slide 2: Introduction  
**What we'll cover:**  
- **Definitions** of Procedures, Functions, Triggers, and Cursors  
- **Practical Examples** with SQL code  
- **Database Schema Design**  
- **DDL, DML, and DQL Queries**  

Why these concepts?  
- Automate repetitive tasks  
- Ensure data integrity  
- Simplify complex operations  

---

## Slide 3: Database Design  
### Schema: Employee Management System  
**Tables:**  
1. **Departments**: Department details  
   - Columns: `dept_id`, `dept_name`  
2. **Employees**: Employee details  
   - Columns: `emp_id`, `emp_name`, `dept_id`  
3. **Salaries**: Salary history  
   - Columns: `salary_id`, `emp_id`, `salary`, `date`  

**Relationships:**  
- **Employees** belong to **Departments**  
- **Salaries** are tied to **Employees**  

---

## Slide 4: Stored Procedures  
### Definition:  
Precompiled SQL statements used to encapsulate logic.  

### Syntax:  
```sql
DELIMITER //                           --Changes the delimiter of sql to '//' instead of ';'
CREATE PROCEDURE proc_name(parameters) --Declares the procedure
BEGIN                                  --Begins procedure definition
    SQL statements;
END//                                  --End of procedure definition
DELIMITER ;                            --Changes the delimited back to ';'
```

### Example: Calculate average salary by department  
```sql
DELIMITER //
CREATE PROCEDURE GetAvgSalaryByDept()
BEGIN
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM Salaries
    GROUP BY dept_id;
END //
DELIMITER ;
```

---

## Slide 5: Functions  
### Definition:  
Reusable SQL routines that return a single value.  

### Syntax:  
```sql
CREATE FUNCTION func_name(parameters)
RETURNS data_type
BEGIN
    RETURN value;
END;
```

### Example: Get total salary of an employee  
```sql
DELIMITER //
CREATE FUNCTION GetTotalSalary(emp_id INT)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total_salary DECIMAL(10,2);
    SELECT SUM(salary) INTO total_salary
    FROM Salaries
    WHERE employee_id = emp_id;
    RETURN total_salary;
END //
DELIMITER ;
```

---

## Slide 6: Triggers  
### Definition:  
SQL statements executed automatically when a specific event occurs.  

### Syntax:  
```sql
CREATE TRIGGER trigger_name
AFTER | BEFORE [INSERT | UPDATE | DELETE]
ON table_name
FOR EACH ROW
BEGIN
    SQL statements;
END;
```

### Example: Audit salary updates  
```sql
DELIMITER //
CREATE TRIGGER AuditSalaryUpdate
AFTER UPDATE ON Salaries
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog(employee_id, old_salary, new_salary, change_date)
    VALUES (OLD.employee_id, OLD.salary, NEW.salary, NOW());
END //
DELIMITER ;
```

---

## Slide 7: Cursors  
### Definition:  
Allow row-by-row processing of query results.  

### Syntax:  
```sql
DECLARE cursor_name CURSOR FOR query;
OPEN cursor_name;
FETCH cursor_name INTO variables;
CLOSE cursor_name;
```

### Example: Process employee bonuses  
```sql
DELIMITER //
CREATE PROCEDURE ProcessBonuses()
BEGIN
    DECLARE emp_id INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE bonus_cursor CURSOR FOR SELECT employee_id FROM Employees;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN bonus_cursor;
    read_loop: LOOP
        FETCH bonus_cursor INTO emp_id;
        IF done THEN LEAVE read_loop;
        END IF;
        -- Apply bonus logic here
    END LOOP;
    CLOSE bonus_cursor;
END //
DELIMITER ;
```

---

## Slide 8: DDL, DML, and DQL Queries  
### DDL (Schema Creation):  
```sql
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    dept_id INT
);
```

### DML (Inserting Data):  
```sql
INSERT INTO Salaries (emp_id, salary, date)
VALUES (1, 50000, '2024-11-01');
```

### DQL (Retrieving Data):  
```sql
SELECT * FROM Salaries WHERE emp_id = 1;
```

---

## Slide 9: Summary  
- **Procedures:** Encapsulate SQL logic for reuse.  
- **Functions:** Provide reusable calculations.  
- **Triggers:** Automate responses to database events.  
- **Cursors:** Enable row-by-row processing.  

Key takeaway: Use these tools to optimize and maintain complex databases effectively.  

---

## Slide 10: References  
- MySQL Official Documentation  
- ITvedant Tutorials  
- Practical SQL Guides  

---
