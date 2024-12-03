# **Subqueries in MySQL**

---

## 1. **What is a Subquery?**

A **subquery** is a query nested inside another query. It provides intermediate results that the outer query can use. Subqueries are often used to:

- Filter rows
- Aggregate data
- Perform complex calculations
- Check for existence or matching conditions

---

## 2. **Types of Subqueries**

| **Type**           | **Description**                                                                 |
|---------------------|---------------------------------------------------------------------------------|
| **Single-row**      | Returns a single value (one row, one column).                                   |
| **Multi-row**       | Returns multiple rows (one column).                                            |
| **Multi-column**    | Returns multiple columns (can be used with `IN`, `EXISTS`, or in `FROM`).       |
| **Correlated**      | Refers to columns in the outer query and is evaluated for each row of the outer query. |
| **Non-correlated**  | Independent of the outer query and is executed only once.                      |

---

## 3. **Example Tables**

We’ll use the following tables:

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

---

## 4. **Examples of Subqueries**

### **4.1 Single-row Subquery**

#### **Definition**:  
A subquery that returns a single value.

#### **Example 1**: Find employees who earn more than the **average salary**.

```sql
SELECT name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
```

#### **Explanation**:  
1. The **subquery** `SELECT AVG(salary) FROM employees` calculates the average salary.
2. The outer query compares each employee's salary to this value.

#### **Step-by-step Execution**:
- **Subquery Result**:  
  Average salary = `(50000 + 60000 + 70000 + 40000 + 45000) / 5 = 53000`.

- **Outer Query Result**:
| **name**    | **salary** |
|-------------|------------|
| Bob         | 60000      |
| Charlie     | 70000      |

---

### **4.2 Multi-row Subquery**

#### **Definition**:  
A subquery that returns multiple rows, often used with `IN`, `ANY`, or `ALL`.

#### **Example 2**: Find employees working in departments with IDs 1 or 2.

```sql
SELECT name
FROM employees
WHERE department_id IN (
    SELECT id
    FROM departments
    WHERE id IN (1, 2)
);
```

#### **Explanation**:  
1. The subquery `SELECT id FROM departments WHERE id IN (1, 2)` retrieves department IDs `1` and `2`.
2. The outer query selects employees matching these department IDs.

#### **Subquery Result**:
| **id** |
|--------|
| 1      |
| 2      |

#### **Outer Query Result**:
| **name**    |
|-------------|
| Alice       |
| Bob         |
| Charlie     |

---

### **4.3 Multi-column Subquery**

#### **Definition**:  
A subquery that returns multiple columns, often used in comparisons or joins.

#### **Example 3**: Find employees whose department and salary match those of another employee.

```sql
SELECT name
FROM employees
WHERE (department_id, salary) IN (
    SELECT department_id, salary
    FROM employees
    WHERE name = 'Alice'
);
```

#### **Explanation**:  
1. The subquery retrieves the `department_id` and `salary` for "Alice" (`department_id = 1`, `salary = 50000`).
2. The outer query finds employees with the same department and salary.

#### **Result**:
| **name**    |
|-------------|
| Alice       |

---

### **4.4 Correlated Subquery**

#### **Definition**:  
A subquery that refers to columns in the outer query and is evaluated for each row of the outer query.

#### **Example 4**: Find employees earning more than the average salary in their own department.

```sql
SELECT name, salary
FROM employees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM employees e2
    WHERE e1.department_id = e2.department_id
);
```

#### **Explanation**:  
1. For each employee (`e1`), the subquery calculates the average salary of their department (`e2`).
2. The outer query compares the employee’s salary to this value.

#### **Step-by-step Execution**:
- For **Alice (department_id = 1)**: Avg salary = `(50000 + 70000) / 2 = 60000`. Result: ❌
- For **Charlie (department_id = 1)**: Avg salary = `60000`. Result: ✅
- For **Bob (department_id = 2)**: Avg salary = `60000`. Result: ❌

#### **Result**:
| **name**    | **salary** |
|-------------|------------|
| Charlie     | 70000      |

---

### **4.5 Non-correlated Subquery**

#### **Definition**:  
A subquery that is independent of the outer query.

#### **Example 5**: List all employees and show the total number of departments.

```sql
SELECT name, (
    SELECT COUNT(*)
    FROM departments
) AS total_departments
FROM employees;
```

#### **Explanation**:  
1. The subquery calculates the total number of departments (`4`).
2. The outer query includes this value for each employee.

#### **Result**:
| **name**    | **total_departments** |
|-------------|------------------------|
| Alice       | 4                      |
| Bob         | 4                      |
| Charlie     | 4                      |
| Diana       | 4                      |
| Ethan       | 4                      |

---

### **4.6 Using Subquery in `FROM` Clause**

#### **Definition**:  
A subquery used as a temporary table.

#### **Example 6**: Find the average salary by department, showing only departments with an average salary above 50,000.

```sql
SELECT department_name, avg_salary
FROM (
    SELECT d.department_name, AVG(e.salary) AS avg_salary
    FROM employees e
    INNER JOIN departments d
    ON e.department_id = d.id
    GROUP BY d.department_name
) AS department_avg
WHERE avg_salary > 50000;
```

#### **Explanation**:
1. The **subquery** calculates the average salary per department.
2. The **outer query** filters departments with `avg_salary > 50000`.

#### **Subquery Result**:
| **department_name** | **avg_salary** |
|---------------------|----------------|
| HR                  | 60000          |
| IT                  | 60000          |
| Sales               | 40000          |

#### **Outer Query Result**:
| **department_name** | **avg_salary** |
|---------------------|----------------|
| HR                  | 60000          |
| IT                  | 60000          |

---

### **4.7 Subquery with `EXISTS`**

#### **Definition**:  
Checks if a subquery returns any rows.

#### **Example 7**: Find employees who work in a department.

```sql
SELECT name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM departments d
    WHERE e.department_id = d.id
);
```

#### **Explanation**:  
1. For each employee, the subquery checks if a matching department exists.
2. The `EXISTS` clause returns `TRUE` or `FALSE`.

#### **Result**:
| **name**    |
|-------------|
| Alice       |
| Bob         |
| Charlie     |
| Diana       |

---

## 5. **Best Practices for Subqueries**

1. **Optimize Performance**: Use indexes for columns used in subqueries.
2. **Limit Scope**: Avoid overly complex subqueries; break them into smaller parts if needed.
3. **Avoid Redundancy**: Use joins where subqueries are unnecessary for better performance.

---
