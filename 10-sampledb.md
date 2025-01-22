# **MySQL Schema and Data Tutorial**

This tutorial provides the **DDL (Data Definition Language)** for creating the schema, and the **DML (Data Manipulation Language)** for inserting at least 20 records into each table.

Go to:
- [Procedures & Functions](06-ddl-2-00.md)

```sql
CREATE DATABASE emp_db;
USE emp_db;
```
---

## **1. Departments Table**

### **DDL for Departments**
```sql
CREATE TABLE Departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);
```

### **DML for Departments**
```sql
INSERT INTO Departments (dept_name)
VALUES 
    ('HR'), 
    ('Finance'), 
    ('Engineering'), 
    ('Marketing'), 
    ('Sales'), 
    ('Operations'), 
    ('IT Support'), 
    ('Legal'), 
    ('Research'), 
    ('Product Development'),
    ('Customer Service'), 
    ('Training'), 
    ('Quality Assurance'), 
    ('Public Relations'), 
    ('Logistics'), 
    ('Procurement'), 
    ('Data Analytics'), 
    ('Compliance'), 
    ('Risk Management'), 
    ('Audit');
```

---

## **2. Employees Table**

### **DDL for Employees**
```sql
CREATE TABLE Employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    dept_id INT NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id) ON DELETE CASCADE
);
```

### **DML for Employees**
```sql
INSERT INTO Employees (emp_name, dept_id, hire_date)
VALUES 
    ('Alice', 1, '2020-06-15'),
    ('Bob', 2, '2019-03-01'),
    ('Charlie', 3, '2021-08-20'),
    ('Diana', 4, '2022-01-10'),
    ('Eve', 5, '2018-05-23'),
    ('Frank', 6, '2020-11-15'),
    ('Grace', 7, '2017-09-05'),
    ('Hank', 8, '2021-12-19'),
    ('Ivy', 9, '2020-03-17'),
    ('Jack', 10, '2019-07-21'),
    ('Karen', 11, '2023-01-05'),
    ('Leo', 12, '2022-03-10'),
    ('Mona', 13, '2021-06-25'),
    ('Nate', 14, '2020-02-15'),
    ('Olivia', 15, '2020-09-30'),
    ('Paul', 16, '2018-04-13'),
    ('Quinn', 17, '2019-08-29'),
    ('Rachel', 18, '2020-12-14'),
    ('Steve', 19, '2021-10-02'),
    ('Tracy', 20, '2019-01-11');
```

---

## **3. Salaries Table**

### **DDL for Salaries**
```sql
CREATE TABLE Salaries (
    salary_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    salary_date DATE NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id) ON DELETE CASCADE
);
```

### **DML for Salaries**
```sql
INSERT INTO Salaries (emp_id, salary, salary_date)
VALUES
    (1, 50000.00, '2023-01-01'),
    (1, 52000.00, '2023-07-01'),
    (2, 60000.00, '2023-01-01'),
    (3, 75000.00, '2023-01-01'),
    (4, 45000.00, '2023-01-01'),
    (5, 55000.00, '2023-01-01'),
    (6, 58000.00, '2023-01-01'),
    (7, 49000.00, '2023-01-01'),
    (8, 47000.00, '2023-01-01'),
    (9, 65000.00, '2023-01-01'),
    (10, 72000.00, '2023-01-01'),
    (11, 48000.00, '2023-01-01'),
    (12, 62000.00, '2023-01-01'),
    (13, 59000.00, '2023-01-01'),
    (14, 53000.00, '2023-01-01'),
    (15, 68000.00, '2023-01-01'),
    (16, 70000.00, '2023-01-01'),
    (17, 54000.00, '2023-01-01'),
    (18, 50000.00, '2023-01-01'),
    (19, 61000.00, '2023-01-01'),
    (20, 56000.00, '2023-01-01');
```

---

## **4. AuditLog Table**

### **DDL for AuditLog**
```sql
CREATE TABLE AuditLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    change_date DATETIME NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id) ON DELETE CASCADE
);
```

### **DML for AuditLog**
```sql
INSERT INTO AuditLog (emp_id, old_salary, new_salary, change_date)
VALUES
    (1, 50000.00, 52000.00, '2023-07-01 10:00:00'),
    (2, 60000.00, 62000.00, '2023-07-01 10:30:00'),
    (3, 75000.00, 76000.00, '2023-07-01 11:00:00'),
    (4, 45000.00, 47000.00, '2023-07-01 11:30:00'),
    (5, 55000.00, 56000.00, '2023-07-01 12:00:00'),
    (6, 58000.00, 59000.00, '2023-07-01 12:30:00'),
    (7, 49000.00, 50000.00, '2023-07-01 13:00:00'),
    (8, 47000.00, 48000.00, '2023-07-01 13:30:00'),
    (9, 65000.00, 66000.00, '2023-07-01 14:00:00'),
    (10, 72000.00, 73000.00, '2023-07-01 14:30:00'),
    (11, 48000.00, 49000.00, '2023-07-01 15:00:00'),
    (12, 62000.00, 63000.00, '2023-07-01 15:30:00'),
    (13, 59000.00, 60000.00, '2023-07-01 16:00:00'),
    (14, 53000.00, 54000.00, '2023-07-01 16:30:00'),
    (15, 68000.00, 69000.00, '2023-07-01 17:00:00'),
    (16, 70000.00, 71000.00, '2023-07-01 17:30:00'),
    (17, 54000.00, 55000.00, '2023-07-01 18:00:00'),
    (18, 50000.00, 51000.00, '2023-07-01 18:30:00'),
    (19, 61000.00, 62000.00, '2023-07-01 19:00:00'),
    (20, 56000.00, 57000.00, '2023-07-01 19:30:00');
```

---
