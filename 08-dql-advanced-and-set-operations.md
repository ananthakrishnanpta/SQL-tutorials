## **1. Advanced Querying Techniques**

### **1.1. USING Clause**

#### **Concept**:
The `USING` clause simplifies join conditions when two tables share a column with the same name. It eliminates redundancy by avoiding repeated specification of column names in join conditions.

#### **Syntax**:
```sql
SELECT column1, column2
FROM table1
JOIN table2 USING(column_name);
```

#### **Example:**
```sql
-- Tables: students(student_id, first_name, last_name), enrollments(student_id, course_id)
SELECT students.student_id, first_name, course_id
FROM students
JOIN enrollments USING(student_id);
```

#### **Explanation**:
- `USING(student_id)` automatically matches `student_id` in both `students` and `enrollments`.
- This avoids writing `ON students.student_id = enrollments.student_id`.

---

### **1.2. EXISTS**

#### **Concept**:
The `EXISTS` operator tests for the presence of rows returned by a subquery. It returns `TRUE` if the subquery yields any rows, and `FALSE` otherwise. It is often used to check whether related data exists.

#### **Syntax**:
```sql
SELECT column1, column2
FROM table1
WHERE EXISTS (subquery);
```

#### **Example:**
```sql
-- Find students enrolled in at least one course
SELECT first_name, last_name
FROM students
WHERE EXISTS (
    SELECT 1
    FROM enrollments
    WHERE students.student_id = enrollments.student_id
);
```

#### **Explanation**:
- The subquery checks if a `student_id` from `students` exists in the `enrollments` table.
- If true, the student’s details are retrieved by the outer query.

---

### **1.3. ANY and ALL**

#### **Concepts**:
- **`ANY`**: Tests whether a condition is true for **at least one** value returned by a subquery.
- **`ALL`**: Tests whether a condition is true for **all** values returned by a subquery.

#### **Syntax**:
```sql
-- ANY
SELECT column1
FROM table1
WHERE column1 = ANY (subquery);

-- ALL
SELECT column1
FROM table1
WHERE column1 = ALL (subquery);
```

#### **Example with ANY:**
```sql
-- Find courses with at least one student older than 21
SELECT course_id
FROM courses
WHERE course_id = ANY (
    SELECT course_id
    FROM enrollments
    JOIN students ON enrollments.student_id = students.student_id
    WHERE students.age > 21
);
```

#### **Example with ALL:**
```sql
-- Find courses where all enrolled students are older than 18
SELECT course_id
FROM courses
WHERE course_id = ALL (
    SELECT course_id
    FROM enrollments
    JOIN students ON enrollments.student_id = students.student_id
    WHERE students.age > 18
);
```

#### **Explanation**:
- **`ANY`**: The condition is true if any course has a student older than 21.
- **`ALL`**: The condition is true if all students in a course are older than 18.

---

### **1.4. IN Clause**

#### **Concept**:
The `IN` clause checks if a value exists in a given list or result set from a subquery. It acts as shorthand for multiple `OR` conditions.

#### **Syntax**:
```sql
SELECT column1
FROM table1
WHERE column1 IN (value1, value2, ...);

SELECT column1
FROM table1
WHERE column1 IN (subquery);
```

#### **Example:**
```sql
-- Find students enrolled in specific courses
SELECT first_name, last_name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE course_id IN ('C101', 'C102')
);
```

#### **Explanation**:
- The inner query retrieves students in `C101` or `C102`.
- The outer query fetches their details from the `students` table.

---

## **2. Set Operations**

Set operations combine the results of two or more `SELECT` queries. They are useful for combining, comparing, or subtracting datasets. The result of set operations must have the same number of columns with compatible data types.

### **2.1. UNION**

#### **Concept**:
`UNION` combines results from two queries and removes duplicates.

#### **Syntax**:
```sql
SELECT column1 FROM table1
UNION
SELECT column1 FROM table2;
```

#### **Example:**
```sql
-- Combine lists of students from two courses
SELECT student_id FROM enrollments WHERE course_id = 'C101'
UNION
SELECT student_id FROM enrollments WHERE course_id = 'C102';
```

#### **Explanation**:
- Combines student IDs from both courses, removing duplicates.

---

### **2.2. UNION ALL**

#### **Concept**:
`UNION ALL` combines results from two queries without removing duplicates.

#### **Syntax**:
```sql
SELECT column1 FROM table1
UNION ALL
SELECT column1 FROM table2;
```

#### **Example:**
```sql
-- Combine lists of students, including duplicates
SELECT student_id FROM enrollments WHERE course_id = 'C101'
UNION ALL
SELECT student_id FROM enrollments WHERE course_id = 'C102';
```

#### **Explanation**:
- Unlike `UNION`, this retains duplicates.

---

### **2.3. INTERSECT** *(Simulated in MySQL using INNER JOIN)*

#### **Concept**:
`INTERSECT` returns rows present in both queries. MySQL lacks direct support, but it can be simulated.

#### **Example:**
```sql
-- Students enrolled in both courses
SELECT student_id
FROM enrollments e1
WHERE course_id = 'C101'
AND EXISTS (
    SELECT 1
    FROM enrollments e2
    WHERE e1.student_id = e2.student_id
    AND e2.course_id = 'C102'
);
```

---

### **2.4. EXCEPT** *(Simulated in MySQL using NOT IN)*

#### **Concept**:
`EXCEPT` returns rows from the first query that are not in the second. MySQL does not support this directly.

#### **Example:**
```sql
-- Students enrolled in C101 but not in C102
SELECT student_id
FROM enrollments
WHERE course_id = 'C101'
AND student_id NOT IN (
    SELECT student_id
    FROM enrollments
    WHERE course_id = 'C102'
);
```

---

## **3. Practical Use Case**

### **Tables:**
#### `students`
| student_id | first_name | last_name | age  |
|------------|------------|-----------|------|
| 1          | Ramesh     | Kumar     | 22   |
| 2          | Sita       | Sharma    | 21   |
| 3          | Arjun      | Mehta     | 20   |

#### `courses`
| course_id  | course_name   |
|------------|---------------|
| C101       | Mathematics   |
| C102       | Physics       |

#### `enrollments`
| student_id | course_id |
|------------|-----------|
| 1          | C101      |
| 1          | C102      |
| 2          | C101      |

---

### **Use Case Query:**
Find students enrolled in Mathematics but not in Physics.
```sql
SELECT first_name, last_name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE course_id = 'C101'
)
AND student_id NOT IN (
    SELECT student_id
    FROM enrollments
    WHERE course_id = 'C102'
);
```

#### **Result:**
| first_name | last_name |
|------------|-----------|
| Sita       | Sharma    |

---
