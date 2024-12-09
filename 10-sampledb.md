## **Database Design for Salary and Department Management**

### **Database Name**
`salary_management`

---

### **Schema Overview**
This schema includes three tables: 
1. **Departments**
2. **Employees**
3. **Salaries**

Each table is designed to work with the procedures provided in the documentation.

---

### **1. Departments Table**
- **Purpose**: Stores department details.
- **Primary Key**: `dept_id`

#### **Table Definition**
```sql
CREATE TABLE Departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);
```

#### **Sample Data**
```sql
INSERT INTO Departments (dept_name) VALUES
('HR'),
('Finance'),
('Engineering'),
('Marketing');
```

---

### **2. Employees Table**
- **Purpose**: Stores employee details.
- **Foreign Key**: `dept_id` (references `Departments`).

#### **Table Definition**
```sql
CREATE TABLE Employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    dept_id INT NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
```

#### **Sample Data**
```sql
INSERT INTO Employees (emp_name, dept_id) VALUES
('Alice', 1), -- HR
('Bob', 2),   -- Finance
('Charlie', 3), -- Engineering
('Diana', 3), -- Engineering
('Eve', 4);   -- Marketing
```

---

### **3. Salaries Table**
- **Purpose**: Stores salary details of employees.
- **Foreign Key**: `emp_id` (references `Employees`).

#### **Table Definition**
```sql
CREATE TABLE Salaries (
    salary_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    salary_date DATE NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
```

#### **Sample Data**
```sql
INSERT INTO Salaries (emp_id, salary, salary_date) VALUES
(1, 50000.00, '2024-01-01'), -- Alice
(2, 60000.00, '2024-01-01'), -- Bob
(3, 70000.00, '2024-01-01'), -- Charlie
(4, 80000.00, '2024-01-01'), -- Diana
(5, 55000.00, '2024-01-01'); -- Eve
```

---

### **Full SQL Script**
Below is the full SQL script to create the database, tables, and sample data.

```sql
-- Create the database
CREATE DATABASE salary_management;
USE salary_management;

-- Create Departments table
CREATE TABLE Departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

-- Insert sample data into Departments
INSERT INTO Departments (dept_name) VALUES
('HR'),
('Finance'),
('Engineering'),
('Marketing');

-- Create Employees table
CREATE TABLE Employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    dept_id INT NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Insert sample data into Employees
INSERT INTO Employees (emp_name, dept_id) VALUES
('Alice', 1), -- HR
('Bob', 2),   -- Finance
('Charlie', 3), -- Engineering
('Diana', 3), -- Engineering
('Eve', 4);   -- Marketing

-- Create Salaries table
CREATE TABLE Salaries (
    salary_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    salary_date DATE NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Insert sample data into Salaries
INSERT INTO Salaries (emp_id, salary, salary_date) VALUES
(1, 50000.00, '2024-01-01'), -- Alice
(2, 60000.00, '2024-01-01'), -- Bob
(3, 70000.00, '2024-01-01'), -- Charlie
(4, 80000.00, '2024-01-01'), -- Diana
(5, 55000.00, '2024-01-01'); -- Eve
```

---

### **Explanation of the Schema**
1. **Departments Table**: 
   - Stores department names.
   - `dept_id` is the primary key and uniquely identifies each department.

2. **Employees Table**: 
   - Stores employee names and their associated department.
   - `dept_id` is a foreign key linking to the `Departments` table.

3. **Salaries Table**:
   - Stores salary information and the date of salary payment.
   - `emp_id` is a foreign key linking to the `Employees` table.

---
