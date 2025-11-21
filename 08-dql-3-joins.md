---

# **Joins in MySQL**

---

## 1. **What are Joins?**

In relational databases, data is stored across multiple tables, and joins allow you to **combine related rows** from these tables based on a **common key** or relationship.

---

## 2. **Tables Used in Examples**

We’ll use two tables: **employees** and **departments**.

### **employees** Table:
| **id** | **name**    | **department_id** | **salary** |
|--------|-------------|-------------------|------------|
| 1      | Alice       | 1                 | 50000      |
| 2      | Bob         | 2                 | 60000      |
| 3      | Charlie     | 1                 | 70000      |
| 4      | Diana       | 3                 | 40000      |
| 5      | Ethan       | NULL              | 45000      |

### **departments** Table:
| **id** | **department_name** |
|--------|----------------------|
| 1      | HR                  |
| 2      | IT                  |
| 3      | Sales               |
| 4      | Marketing           |

Here are the SQL commands to create and populate the tables for the given data:

### Creating the `departments` Table
```sql
CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(50)
);
```

### Creating the `employees` Table
```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (department_id) REFERENCES departments(id)
);
```


### Inserting Data into `departments`
```sql
INSERT INTO departments (id, department_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Sales'),
(4, 'Marketing');
```

### Inserting Data into `employees`
```sql
INSERT INTO employees (id, name, department_id, salary) VALUES
(1, 'Alice', 1, 50000),
(2, 'Bob', 2, 60000),
(3, 'Charlie', 1, 70000),
(4, 'Diana', 3, 40000),
(5, 'Ethan', NULL, 45000);
``` 
---

## 3. **How Joins Work**

### **Join Process Overview**

1. **Find Matching Rows**: Joins use a condition, usually specified in the `ON` clause, to find rows with related data.  
2. **Combine Rows**: Matching rows are combined into a single result row.
3. **Unmatched Rows**: Depending on the join type, unmatched rows may or may not appear in the result, with `NULL` values filling in missing columns.

---

## 4. **Types of Joins**

Let’s explore each join type step by step with examples.

---

### **4.1 INNER JOIN**

#### **Definition**:  
An **INNER JOIN** retrieves rows that have **matching values** in both tables.

#### **SQL Query**:
```sql
SELECT e.name AS employee_name, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.id;
```

#### **How It Works**:

1. **Match Rows**: Only rows where `employees.department_id = departments.id` are included.  
2. **Unmatched Rows Excluded**: Rows without a match in either table are excluded.

#### **Step-by-Step Execution**:

- Compare `department_id` in `employees` with `id` in `departments`.

| **employees.department_id** | **departments.id** | **Match?** |
|-----------------------------|--------------------|------------|
| 1                           | 1                  | ✅ Yes      |
| 2                           | 2                  | ✅ Yes      |
| 1                           | 1                  | ✅ Yes      |
| 3                           | 3                  | ✅ Yes      |
| NULL                        | 1, 2, 3, 4         | ❌ No       |

#### **Result Table**:
| **employee_name** | **department_name** |
|-------------------|----------------------|
| Alice             | HR                  |
| Bob               | IT                  |
| Charlie           | HR                  |
| Diana             | Sales               |

---

### **4.2 LEFT JOIN**

#### **Definition**:  
A **LEFT JOIN** retrieves all rows from the **left table** (employees) and **matching rows** from the right table (departments). Rows with no match on the right have `NULL` values.

#### **SQL Query**:
```sql
SELECT e.name AS employee_name, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.id;
```

#### **How It Works**:

1. **All Rows from Left**: All rows from `employees` are included, regardless of whether they match.  
2. **Unmatched Rows Get NULL**: If no match is found, `department_name` is `NULL`.

#### **Step-by-Step Execution**:

- Compare `department_id` in `employees` with `id` in `departments`.

| **employees.department_id** | **departments.id** | **Match?** | **Result**        |
|-----------------------------|--------------------|------------|-------------------|
| 1                           | 1                  | ✅ Yes      | HR                |
| 2                           | 2                  | ✅ Yes      | IT                |
| 1                           | 1                  | ✅ Yes      | HR                |
| 3                           | 3                  | ✅ Yes      | Sales             |
| NULL                        | 1, 2, 3, 4         | ❌ No       | NULL              |

#### **Result Table**:
| **employee_name** | **department_name** |
|-------------------|----------------------|
| Alice             | HR                  |
| Bob               | IT                  |
| Charlie           | HR                  |
| Diana             | Sales               |
| Ethan             | NULL                |

---

### **4.3 RIGHT JOIN**

#### **Definition**:  
A **RIGHT JOIN** retrieves all rows from the **right table** (departments) and **matching rows** from the left table (employees). Rows with no match on the left have `NULL` values.

#### **SQL Query**:
```sql
SELECT e.name AS employee_name, d.department_name
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.id;
```

#### **How It Works**:

1. **All Rows from Right**: All rows from `departments` are included, regardless of whether they match.  
2. **Unmatched Rows Get NULL**: If no match is found, `employee_name` is `NULL`.

#### **Step-by-Step Execution**:

- Compare `department_id` in `employees` with `id` in `departments`.

| **employees.department_id** | **departments.id** | **Match?** | **Result**        |
|-----------------------------|--------------------|------------|-------------------|
| 1                           | 1                  | ✅ Yes      | Alice, HR         |
| 2                           | 2                  | ✅ Yes      | Bob, IT           |
| 1                           | 1                  | ✅ Yes      | Charlie, HR       |
| 3                           | 3                  | ✅ Yes      | Diana, Sales      |
| NULL                        | 4                  | ❌ No       | NULL, Marketing   |

#### **Result Table**:
| **employee_name** | **department_name** |
|-------------------|----------------------|
| Alice             | HR                  |
| Bob               | IT                  |
| Charlie           | HR                  |
| Diana             | Sales               |
| NULL              | Marketing           |

---

### **4.4 FULL OUTER JOIN**

#### **Definition**:  
A **FULL OUTER JOIN** retrieves rows when there is a match in **either table**. Rows without matches in one table have `NULL` values for the other table.

> **Note**: MySQL doesn’t natively support FULL OUTER JOIN. You can simulate it with a `UNION` of `LEFT JOIN` and `RIGHT JOIN`.

#### **SQL Query**:
```sql
SELECT e.name AS employee_name, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.id
UNION
SELECT e.name AS employee_name, d.department_name
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.id;
```

#### **Result Table**:
| **employee_name** | **department_name** |
|-------------------|----------------------|
| Alice             | HR                  |
| Bob               | IT                  |
| Charlie           | HR                  |
| Diana             | Sales               |
| Ethan             | NULL                |
| NULL              | Marketing           |

---

### **4.5 CROSS JOIN**

#### **Definition**:  
A **CROSS JOIN** creates a Cartesian product of rows from both tables. Each row in the first table is paired with **all rows** from the second table.

#### **SQL Query**:
```sql
SELECT e.name AS employee_name, d.department_name
FROM employees e
CROSS JOIN departments d;
```

#### **Result Table**:
| **employee_name** | **department_name** |
|-------------------|----------------------|
| Alice             | HR                  |
| Alice             | IT                  |
| Alice             | Sales               |
| Alice             | Marketing           |
| Bob               | HR                  |
| ...               | ...                 |

---

### **4.6 SELF JOIN**

#### **Definition**:  
A **SELF JOIN** joins a table to itself, typically used for hierarchical or comparative queries.

#### **SQL Query**:
Find employees earning more than their colleagues:
```sql
SELECT e1.name AS employee, e2.name AS colleague
FROM employees e1
INNER JOIN employees e2
ON e1.salary > e2.salary;
```
