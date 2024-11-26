---

# **DQL and SQL Functions in MySQL**

---

## 1. **What is DQL?**

**DQL (Data Query Language)** refers to SQL commands that are used to retrieve data from a database. The primary DQL command is `SELECT`.

---

## 2. **DQL Syntax and Usage**

### **Basic Syntax**:
```sql
SELECT column1, column2, ... 
FROM table_name
WHERE condition
GROUP BY column
HAVING condition
ORDER BY column [ASC|DESC]
LIMIT number OFFSET number;
```

---

## 3. **Examples of DQL Queries**

### **Example 1: Retrieve All Rows**
**Description**: Select all columns and rows from the `employees` table.
```sql
SELECT * FROM employees;
```

---

### **Example 2: Retrieve Specific Columns**
**Description**: Select only the `name` and `salary` columns.
```sql
SELECT name, salary FROM employees;
```

---

### **Example 3: Use `WHERE` to Filter Data**
**Description**: Retrieve employees with salaries greater than 50,000.
```sql
SELECT * FROM employees WHERE salary > 50000;
```

---

### **Example 4: Sort Results with `ORDER BY`**
**Description**: Retrieve all employees, sorted by salary in descending order.
```sql
SELECT * FROM employees ORDER BY salary DESC;
```

---

### **Example 5: Group Data with `GROUP BY`**
**Description**: Count the number of employees in each department.
```sql
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;
```

---

### **Example 6: Filter Grouped Data with `HAVING`**
**Description**: Retrieve departments with more than 5 employees.
```sql
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING employee_count > 5;
```

---

### **Example 7: Limit Results**
**Description**: Retrieve the top 3 highest-paid employees.
```sql
SELECT * FROM employees ORDER BY salary DESC LIMIT 3;
```

---

### **Example 8: Combine Conditions with `AND` and `OR`**
**Description**: Retrieve employees in the Sales department earning more than 40,000.
```sql
SELECT * FROM employees 
WHERE department = 'Sales' AND salary > 40000;
```

---

## 4. **Built-in SQL Functions**

### **Types of Functions**

SQL functions are grouped into the following categories:
1. **Aggregate Functions**  
2. **String Functions**  
3. **Date and Time Functions**  
4. **Mathematical Functions**  
5. **System Functions**

---

### **4.1 Aggregate Functions**

Aggregate functions perform calculations on a set of values and return a single value.

| **Function**  | **Description**                     | **Example**                          |
|---------------|-------------------------------------|--------------------------------------|
| `COUNT()`     | Counts the number of rows          | `SELECT COUNT(*) FROM employees;`    |
| `SUM()`       | Calculates the sum of a column     | `SELECT SUM(salary) FROM employees;` |
| `AVG()`       | Calculates the average value       | `SELECT AVG(salary) FROM employees;` |
| `MIN()`       | Finds the minimum value            | `SELECT MIN(salary) FROM employees;` |
| `MAX()`       | Finds the maximum value            | `SELECT MAX(salary) FROM employees;` |

---

### **4.2 String Functions**
String functions in MySQL are used to perform operations on string data types like `VARCHAR`, `TEXT`, etc.

| **Function**       | **Syntax**                                                               | **Description**                                               | **Example**                              |
|--------------------|-------------------------------------------------------------------------|---------------------------------------------------------------|------------------------------------------|
| `CONCAT`           | `CONCAT(string1, string2, ...)`                                          | Concatenates two or more strings.                             | `SELECT CONCAT('Hello', ' ', 'World');`  |
| `LENGTH`           | `LENGTH(string)`                                                         | Returns the length of a string in bytes.                      | `SELECT LENGTH('Hello');` (returns 5)    |
| `CHAR_LENGTH`      | `CHAR_LENGTH(string)`                                                   | Returns the length of a string in characters.                 | `SELECT CHAR_LENGTH('Hello');` (returns 5)|
| `UPPER`            | `UPPER(string)`                                                         | Converts string to uppercase.                                 | `SELECT UPPER('hello');` (returns 'HELLO')|
| `LOWER`            | `LOWER(string)`                                                         | Converts string to lowercase.                                 | `SELECT LOWER('HELLO');` (returns 'hello')|
| `TRIM`             | `TRIM([BOTH|LEADING|TRAILING] trim_char FROM string)`                   | Removes specified characters from the start and/or end.       | `SELECT TRIM('  hello  ');` (returns 'hello')|
| `SUBSTRING`        | `SUBSTRING(string, start, length)`                                      | Extracts a substring from a string.                           | `SELECT SUBSTRING('Hello World', 7, 5);` (returns 'World')|
| `REPLACE`          | `REPLACE(string, old_substring, new_substring)`                         | Replaces occurrences of a substring with another substring.   | `SELECT REPLACE('Hello World', 'World', 'Universe');` (returns 'Hello Universe')|
| `INSTR`            | `INSTR(string, substring)`                                              | Returns the position of the first occurrence of a substring.  | `SELECT INSTR('Hello World', 'World');` (returns 7)|
| `LOCATE`           | `LOCATE(substring, string)`                                             | Returns the position of the first occurrence of a substring.  | `SELECT LOCATE('World', 'Hello World');` (returns 7)|
| `REVERSE`          | `REVERSE(string)`                                                       | Reverses the characters in a string.                          | `SELECT REVERSE('Hello');` (returns 'olleH')|
| `CONCAT_WS`        | `CONCAT_WS(separator, string1, string2, ...)`                           | Concatenates strings with a separator.                         | `SELECT CONCAT_WS('-', '2024', '11', '26');` (returns '2024-11-26')|
| `RPAD`             | `RPAD(string, length, pad_string)`                                      | Pads the string on the right side to a specified length.       | `SELECT RPAD('Hello', 10, '-');` (returns 'Hello-----')|
| `LPAD`             | `LPAD(string, length, pad_string)`                                      | Pads the string on the left side to a specified length.        | `SELECT LPAD('Hello', 10, '-');` (returns '-----Hello')|
| `SOUNDEX`          | `SOUNDEX(string)`                                                       | Returns the soundex key of the string (phonetic representation).| `SELECT SOUNDEX('hello');` (returns 'H040')|
| `LEFT`             | `LEFT(string, length)`                                                  | Returns the left part of a string with a specified length.     | `SELECT LEFT('Hello World', 5);` (returns 'Hello')|
| `RIGHT`            | `RIGHT(string, length)`                                                 | Returns the right part of a string with a specified length.    | `SELECT RIGHT('Hello World', 5);` (returns 'World')|
| `ASCII`            | `ASCII(string)`                                                         | Returns the ASCII value of the first character in the string.  | `SELECT ASCII('A');` (returns 65)        |
| `CHAR`             | `CHAR(n)`                                                               | Converts an ASCII code to a character.                         | `SELECT CHAR(65);` (returns 'A')         |
| `FORMAT`           | `FORMAT(number, decimal_places)`                                        | Formats a number as a string, rounding to the specified decimal places. | `SELECT FORMAT(12345.6789, 2);` (returns '12,345.68')|
| `REGEXP_REPLACE`   | `REGEXP_REPLACE(string, pattern, replace)`                               | Replaces substrings matching a regular expression.            | `SELECT REGEXP_REPLACE('Hello 123 World', '\\d+', 'ABC');` (returns 'Hello ABC World')|
| `REGEXP`           | `REGEXP(string, pattern)`                                               | Matches a string against a regular expression pattern.         | `SELECT 'hello' REGEXP 'h.*o';` (returns 1)|
| `PATINDEX`         | `PATINDEX(pattern, string)`                                             | Returns the position of the first occurrence of a substring.   | `SELECT PATINDEX('%World%', 'Hello World');` (returns 7)|
| `ESCAPE`           | `ESCAPE(string)`                                                        | Escapes special characters in a string.                        | `SELECT ESCAPE('O\'Reilly');` (returns "O\'Reilly")|

---

### **Explanation of Some Key Functions**

1. **`CONCAT`**: This function concatenates two or more strings. It’s commonly used when you need to combine columns or values together.
   
   ```sql
   SELECT CONCAT('First Name: ', 'John', ' Last Name: ', 'Doe');
   ```

2. **`TRIM`**: It removes unwanted characters (spaces by default) from both ends of a string.

   ```sql
   SELECT TRIM('  Hello World  ');  -- Output: 'Hello World'
   ```

3. **`SUBSTRING`**: This extracts part of the string, starting from a given position for a specific length.

   ```sql
   SELECT SUBSTRING('Hello World', 7, 5);  -- Output: 'World'
   ```

4. **`REPLACE`**: Replaces a substring within a string with another substring.

   ```sql
   SELECT REPLACE('Hello World', 'World', 'Universe');  -- Output: 'Hello Universe'
   ```

5. **`INSTR`**: This returns the position of the first occurrence of a substring within a string.

   ```sql
   SELECT INSTR('Hello World', 'World');  -- Output: 7
   ```

6. **`SOUNDEX`**: Returns the phonetic representation of the string, which is useful for comparing words that sound similar but are spelled differently.

   ```sql
   SELECT SOUNDEX('hello');  -- Output: 'H040'
   ```

---

### **4.3 Date and Time Functions**

Date and time functions are used to manipulate date/time values.

| **Function**         | **Description**                               | **Example**                                      |
|----------------------|-----------------------------------------------|------------------------------------------------|
| `NOW()`              | Returns the current date and time            | `SELECT NOW();`                                |
| `CURDATE()`          | Returns the current date                     | `SELECT CURDATE();`                            |
| `YEAR()`             | Extracts the year from a date                | `SELECT YEAR(hire_date) FROM employees;`       |
| `MONTH()`            | Extracts the month from a date               | `SELECT MONTH(hire_date) FROM employees;`      |
| `DATEDIFF()`         | Returns the difference between two dates     | `SELECT DATEDIFF(CURDATE(), hire_date);`       |

---

### **4.4 Mathematical Functions**

Mathematical functions perform calculations on numeric data.

| **Function**  | **Description**                     | **Example**                          |
|---------------|-------------------------------------|--------------------------------------|
| `ABS()`       | Returns the absolute value          | `SELECT ABS(-10);`                   |
| `ROUND()`     | Rounds a number to the nearest value| `SELECT ROUND(salary, 2);`           |
| `FLOOR()`     | Rounds down to the nearest integer  | `SELECT FLOOR(salary);`              |
| `CEIL()`      | Rounds up to the nearest integer    | `SELECT CEIL(salary);`               |
| `POWER()`     | Raises a number to a power          | `SELECT POWER(salary, 2);`           |

---

### **4.5 System Functions**

System functions provide information about the database or user.

| **Function**      | **Description**                              | **Example**                          |
|-------------------|----------------------------------------------|--------------------------------------|
| `USER()`          | Returns the current user                    | `SELECT USER();`                     |
| `DATABASE()`      | Returns the current database name            | `SELECT DATABASE();`                 |
| `VERSION()`       | Returns the MySQL version                   | `SELECT VERSION();`                  |

---

## 5. **Combining Functions in Queries**

You can combine multiple functions for complex queries.

### **Example: Retrieve Employee Details with Full Name, Year of Joining, and Salary Rounded to 2 Decimal Places**
```sql
SELECT 
  CONCAT(first_name, ' ', last_name) AS full_name,
  YEAR(hire_date) AS year_of_joining,
  ROUND(salary, 2) AS rounded_salary
FROM employees;
```

---

## 6. **Best Practices for Using DQL and Functions**

1. **Filter Early**: Use `WHERE` and `LIMIT` to avoid fetching unnecessary rows.  
2. **Avoid `SELECT *`**: Fetch only the required columns for better performance.  
3. **Indexing**: Use indexes on columns frequently queried in `WHERE`, `GROUP BY`, and `ORDER BY` clauses.  
4. **Optimize Aggregations**: Use indexed columns in `GROUP BY` for faster aggregations.  
5. **Test Functions**: Before combining functions in complex queries, test them individually.

---
