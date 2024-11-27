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
Aggregate functions in MySQL are used to perform calculations on a set of values, returning a single result.

| **Function**         | **Syntax**                                                               | **Description**                                                 | **Example**                                   |
|----------------------|-------------------------------------------------------------------------|---------------------------------------------------------------|-----------------------------------------------|
| `COUNT`              | `COUNT([DISTINCT] expression)`                                          | Returns the number of rows matching a specified condition.     | `SELECT COUNT(*) FROM employees;` (returns the number of employees)|
| `SUM`                | `SUM(expression)`                                                       | Returns the sum of all values in a numeric column.             | `SELECT SUM(salary) FROM employees;` (returns the total salary)|
| `AVG`                | `AVG(expression)`                                                       | Returns the average of all values in a numeric column.         | `SELECT AVG(salary) FROM employees;` (returns the average salary)|
| `MIN`                | `MIN(expression)`                                                       | Returns the smallest value in a specified column.              | `SELECT MIN(salary) FROM employees;` (returns the minimum salary)|
| `MAX`                | `MAX(expression)`                                                       | Returns the largest value in a specified column.               | `SELECT MAX(salary) FROM employees;` (returns the maximum salary)|
| `GROUP_CONCAT`       | `GROUP_CONCAT(expression [ORDER BY ...] [LIMIT ...])`                   | Returns a concatenated string of values from a group.           | `SELECT GROUP_CONCAT(department) FROM employees GROUP BY department;` |
| `STDDEV`             | `STDDEV(expression)`                                                    | Returns the standard deviation of the values in a column.      | `SELECT STDDEV(salary) FROM employees;` (returns standard deviation)|
| `VARIANCE`           | `VARIANCE(expression)`                                                  | Returns the variance of the values in a column.                | `SELECT VARIANCE(salary) FROM employees;` (returns variance)|
| `BIT_AND`            | `BIT_AND(expression)`                                                   | Returns the bitwise AND of all values in a column.             | `SELECT BIT_AND(salary) FROM employees;` |
| `BIT_OR`             | `BIT_OR(expression)`                                                    | Returns the bitwise OR of all values in a column.              | `SELECT BIT_OR(salary) FROM employees;` |
| `BIT_XOR`            | `BIT_XOR(expression)`                                                   | Returns the bitwise XOR of all values in a column.             | `SELECT BIT_XOR(salary) FROM employees;` |

---

### **Explanation of Some Key Functions**

1. **`COUNT`**: The `COUNT` function counts the number of rows that match the specified condition. It can also count the number of distinct values.

   - **Syntax**: 
     ```sql
     SELECT COUNT(expression);
     ```
   - **Example**:
     ```sql
     SELECT COUNT(*) FROM employees;  -- Counts the total number of employees.
     SELECT COUNT(DISTINCT department) FROM employees;  -- Counts the distinct number of departments.
     ```

2. **`SUM`**: The `SUM` function returns the total sum of the values in a numeric column.

   - **Syntax**: 
     ```sql
     SELECT SUM(expression);
     ```
   - **Example**:
     ```sql
     SELECT SUM(salary) FROM employees;  -- Returns the total salary of all employees.
     ```

3. **`AVG`**: The `AVG` function returns the average of the values in a numeric column.

   - **Syntax**: 
     ```sql
     SELECT AVG(expression);
     ```
   - **Example**:
     ```sql
     SELECT AVG(salary) FROM employees;  -- Returns the average salary of all employees.
     ```

4. **`MIN`**: The `MIN` function returns the smallest value in a specified column.

   - **Syntax**: 
     ```sql
     SELECT MIN(expression);
     ```
   - **Example**:
     ```sql
     SELECT MIN(salary) FROM employees;  -- Returns the minimum salary from all employees.
     ```

5. **`MAX`**: The `MAX` function returns the largest value in a specified column.

   - **Syntax**: 
     ```sql
     SELECT MAX(expression);
     ```
   - **Example**:
     ```sql
     SELECT MAX(salary) FROM employees;  -- Returns the maximum salary from all employees.
     ```

6. **`GROUP_CONCAT`**: The `GROUP_CONCAT` function concatenates the values from a group of rows into a single string. It can be used with the `ORDER BY` and `LIMIT` clauses.

   - **Syntax**:
     ```sql
     SELECT GROUP_CONCAT(expression [ORDER BY expression] [LIMIT ...]) FROM table GROUP BY column;
     ```
   - **Example**:
     ```sql
     SELECT GROUP_CONCAT(department) FROM employees GROUP BY department;  -- Concatenates all departments.
     SELECT GROUP_CONCAT(department ORDER BY department ASC) FROM employees GROUP BY department;  -- Concatenates and orders departments alphabetically.
     ```

7. **`STDDEV`**: The `STDDEV` function returns the standard deviation of the values in a numeric column. It is used to measure the variation of data points in a dataset.

   - **Syntax**:
     ```sql
     SELECT STDDEV(expression);
     ```
   - **Example**:
     ```sql
     SELECT STDDEV(salary) FROM employees;  -- Returns the standard deviation of salaries.
     ```

8. **`VARIANCE`**: The `VARIANCE` function returns the variance of the values in a numeric column. Variance is the square of the standard deviation.

   - **Syntax**:
     ```sql
     SELECT VARIANCE(expression);
     ```
   - **Example**:
     ```sql
     SELECT VARIANCE(salary) FROM employees;  -- Returns the variance of salaries.
     ```

9. **`BIT_AND`**: The `BIT_AND` function performs a bitwise AND operation on all values in a column and returns the result.

   - **Syntax**:
     ```sql
     SELECT BIT_AND(expression);
     ```
   - **Example**:
     ```sql
     SELECT BIT_AND(salary) FROM employees;  -- Returns the bitwise AND of all salary values.
     ```

10. **`BIT_OR`**: The `BIT_OR` function performs a bitwise OR operation on all values in a column and returns the result.

    - **Syntax**:
      ```sql
      SELECT BIT_OR(expression);
      ```
    - **Example**:
      ```sql
      SELECT BIT_OR(salary) FROM employees;  -- Returns the bitwise OR of all salary values.
      ```

11. **`BIT_XOR`**: The `BIT_XOR` function performs a bitwise XOR operation on all values in a column and returns the result.

    - **Syntax**:
      ```sql
      SELECT BIT_XOR(expression);
      ```
    - **Example**:
      ```sql
      SELECT BIT_XOR(salary) FROM employees;  -- Returns the bitwise XOR of all salary values.
      ```

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
Date and time functions in MySQL are used to perform operations on date and time values.

| **Function**         | **Syntax**                                                               | **Description**                                                 | **Example**                                   |
|----------------------|-------------------------------------------------------------------------|---------------------------------------------------------------|-----------------------------------------------|
| `CURDATE`            | `CURDATE()`                                                             | Returns the current date in 'YYYY-MM-DD' format.               | `SELECT CURDATE();` (returns '2024-11-26')    |
| `CURRENT_DATE`       | `CURRENT_DATE()`                                                        | Same as `CURDATE()`, returns the current date.                 | `SELECT CURRENT_DATE();` (returns '2024-11-26')|
| `CURTIME`            | `CURTIME()`                                                             | Returns the current time in 'HH:MM:SS' format.                 | `SELECT CURTIME();` (returns '14:30:15')      |
| `CURRENT_TIME`       | `CURRENT_TIME()`                                                        | Same as `CURTIME()`, returns the current time.                 | `SELECT CURRENT_TIME();` (returns '14:30:15')  |
| `NOW`                | `NOW()`                                                                 | Returns the current date and time in 'YYYY-MM-DD HH:MM:SS' format. | `SELECT NOW();` (returns '2024-11-26 14:30:15')|
| `SYSDATE`            | `SYSDATE()`                                                             | Returns the current date and time (with fractional seconds).   | `SELECT SYSDATE();` (returns '2024-11-26 14:30:15.123')|
| `DATE`               | `DATE(datetime)`                                                        | Extracts the date part from a datetime or timestamp.           | `SELECT DATE('2024-11-26 14:30:15');` (returns '2024-11-26')|
| `TIME`               | `TIME(datetime)`                                                        | Extracts the time part from a datetime or timestamp.           | `SELECT TIME('2024-11-26 14:30:15');` (returns '14:30:15')|
| `YEAR`               | `YEAR(date)`                                                            | Extracts the year part from a date.                            | `SELECT YEAR('2024-11-26');` (returns 2024)    |
| `MONTH`              | `MONTH(date)`                                                           | Extracts the month part from a date.                           | `SELECT MONTH('2024-11-26');` (returns 11)     |
| `DAY`                | `DAY(date)`                                                             | Extracts the day part from a date.                             | `SELECT DAY('2024-11-26');` (returns 26)       |
| `DAYOFWEEK`          | `DAYOFWEEK(date)`                                                       | Returns the weekday index (1=Sunday, 2=Monday, ..., 7=Saturday). | `SELECT DAYOFWEEK('2024-11-26');` (returns 3)  |
| `DAYOFMONTH`         | `DAYOFMONTH(date)`                                                      | Returns the day of the month (1-31).                           | `SELECT DAYOFMONTH('2024-11-26');` (returns 26) |
| `DAYOFYEAR`          | `DAYOFYEAR(date)`                                                       | Returns the day of the year (1-366).                           | `SELECT DAYOFYEAR('2024-11-26');` (returns 331) |
| `WEEK`               | `WEEK(date)`                                                            | Returns the week number of the year.                           | `SELECT WEEK('2024-11-26');` (returns 48)      |
| `WEEKDAY`            | `WEEKDAY(date)`                                                         | Returns the weekday index (0=Monday, 6=Sunday).                | `SELECT WEEKDAY('2024-11-26');` (returns 1)    |
| `MONTHNAME`          | `MONTHNAME(date)`                                                       | Returns the full name of the month (e.g., January, February).  | `SELECT MONTHNAME('2024-11-26');` (returns 'November')|
| `DAYNAME`            | `DAYNAME(date)`                                                         | Returns the full name of the day of the week (e.g., Monday).   | `SELECT DAYNAME('2024-11-26');` (returns 'Tuesday')|
| `ADDDATE`            | `ADDDATE(date, INTERVAL expr unit)`                                     | Adds a specified time interval to a date.                       | `SELECT ADDDATE('2024-11-26', INTERVAL 5 DAY);` (returns '2024-12-01')|
| `DATE_ADD`           | `DATE_ADD(date, INTERVAL expr unit)`                                    | Same as `ADDDATE()`, adds a specified time interval to a date.  | `SELECT DATE_ADD('2024-11-26', INTERVAL 5 DAY);` (returns '2024-12-01')|
| `SUBDATE`            | `SUBDATE(date, INTERVAL expr unit)`                                     | Subtracts a specified time interval from a date.                | `SELECT SUBDATE('2024-11-26', INTERVAL 5 DAY);` (returns '2024-11-21')|
| `DATE_SUB`           | `DATE_SUB(date, INTERVAL expr unit)`                                    | Same as `SUBDATE()`, subtracts a specified time interval from a date. | `SELECT DATE_SUB('2024-11-26', INTERVAL 5 DAY);` (returns '2024-11-21')|
| `TIMESTAMPDIFF`      | `TIMESTAMPDIFF(unit, datetime1, datetime2)`                             | Returns the difference between two dates or times in the specified unit (e.g., SECOND, MINUTE, HOUR, DAY). | `SELECT TIMESTAMPDIFF(DAY, '2024-11-21', '2024-11-26');` (returns 5)|
| `DATEDIFF`           | `DATEDIFF(date1, date2)`                                                | Returns the difference between two dates in days.               | `SELECT DATEDIFF('2024-11-26', '2024-11-21');` (returns 5)|
| `STR_TO_DATE`        | `STR_TO_DATE(string, format)`                                           | Converts a string to a date based on a specified format.        | `SELECT STR_TO_DATE('2024-11-26', '%Y-%m-%d');` (returns '2024-11-26')|
| `DATE_FORMAT`        | `DATE_FORMAT(date, format)`                                             | Formats a date into a specified format.                         | `SELECT DATE_FORMAT('2024-11-26', '%Y-%m-%d');` (returns '2024-11-26')|

---

### **Explanation of Some Key Functions**

1. **`CURDATE` / `CURRENT_DATE`**: Returns the current date without the time part.

   ```sql
   SELECT CURDATE();  -- Output: '2024-11-26'
   ```

2. **`CURTIME` / `CURRENT_TIME`**: Returns the current time without the date part.

   ```sql
   SELECT CURTIME();  -- Output: '14:30:15'
   ```

3. **`NOW` / `SYSDATE`**: Returns the current date and time.

   ```sql
   SELECT NOW();  -- Output: '2024-11-26 14:30:15'
   ```

4. **`DATE`**: Extracts the date part from a `DATETIME` or `TIMESTAMP` value.

   ```sql
   SELECT DATE('2024-11-26 14:30:15');  -- Output: '2024-11-26'
   ```

5. **`YEAR`, `MONTH`, `DAY`**: Extracts the year, month, and day parts from a date.

   ```sql
   SELECT YEAR('2024-11-26');  -- Output: 2024
   SELECT MONTH('2024-11-26');  -- Output: 11
   SELECT DAY('2024-11-26');  -- Output: 26
   ```

6. **`DAYOFWEEK`**: Returns the weekday index, where 1 = Sunday and 7 = Saturday.

   ```sql
   SELECT DAYOFWEEK('2024-11-26');  -- Output: 3 (Tuesday)
   ```

7. **`WEEKDAY`**: Returns the weekday index, where 0 = Monday and 6 = Sunday.

   ```sql
   SELECT WEEKDAY('2024-11-26');  -- Output: 1 (Tuesday)
   ```

8. **`ADDDATE` / `DATE_ADD`**: Adds a specified time interval to a date.

   ```sql
   SELECT ADDDATE('2024-11-26', INTERVAL 5 DAY);  -- Output: '2024-12-01'
   ```

9. **`SUBDATE` / `DATE_SUB`**: Subtracts a specified time interval from a date.

   ```sql
   SELECT DATE_SUB('2024-11-26', INTERVAL 5 DAY);  -- Output: '2024-11-21'
   ```

10. **`DATEDIFF`**: Returns the difference between two dates in days.

    ```sql


    SELECT DATEDIFF('2024-11-26', '2024-11-21');  -- Output: 5
    ```

11. **`TIMESTAMPDIFF`**: Returns the difference between two dates in a specified unit (e.g., seconds, minutes, days).

    ```sql
    SELECT TIMESTAMPDIFF(DAY, '2024-11-21', '2024-11-26');  -- Output: 5
    ```

---

### **4.4 Mathematical Functions**
Mathematical functions in MySQL are used to perform calculations on numeric values.

| **Function**        | **Syntax**                                                               | **Description**                                               | **Example**                              |
|---------------------|-------------------------------------------------------------------------|---------------------------------------------------------------|------------------------------------------|
| `ABS`               | `ABS(number)`                                                           | Returns the absolute value of a number.                       | `SELECT ABS(-10);` (returns 10)          |
| `CEIL`              | `CEIL(number)`                                                          | Returns the smallest integer greater than or equal to the number. | `SELECT CEIL(4.2);` (returns 5)          |
| `FLOOR`             | `FLOOR(number)`                                                         | Returns the largest integer less than or equal to the number.  | `SELECT FLOOR(4.8);` (returns 4)         |
| `ROUND`             | `ROUND(number, decimals)`                                               | Rounds a number to the specified number of decimal places.    | `SELECT ROUND(4.5678, 2);` (returns 4.57)|
| `POW`               | `POW(base, exponent)`                                                   | Returns the value of the base raised to the power of the exponent. | `SELECT POW(2, 3);` (returns 8)         |
| `POWER`             | `POWER(base, exponent)`                                                 | Returns the value of the base raised to the power of the exponent. (Same as `POW`) | `SELECT POWER(2, 3);` (returns 8) |
| `SQRT`              | `SQRT(number)`                                                          | Returns the square root of the number.                        | `SELECT SQRT(16);` (returns 4)          |
| `RAND`              | `RAND()`                                                                | Returns a random floating-point value between 0 and 1.        | `SELECT RAND();` (returns a random number)|
| `MOD`               | `MOD(dividend, divisor)`                                                | Returns the remainder of a division operation.                | `SELECT MOD(10, 3);` (returns 1)        |
| `EXP`               | `EXP(number)`                                                           | Returns e raised to the power of the specified number.        | `SELECT EXP(1);` (returns 2.718281828)   |
| `LOG`               | `LOG(number)`                                                           | Returns the natural logarithm of a number (base e).           | `SELECT LOG(2);` (returns 0.693147181)   |
| `LOG10`             | `LOG10(number)`                                                         | Returns the logarithm of a number with base 10.               | `SELECT LOG10(100);` (returns 2)        |
| `SIGN`              | `SIGN(number)`                                                          | Returns the sign of a number (-1 for negative, 1 for positive, 0 for zero). | `SELECT SIGN(-10);` (returns -1) |
| `RADIANS`           | `RADIANS(degrees)`                                                      | Converts degrees to radians.                                  | `SELECT RADIANS(180);` (returns 3.141593)|
| `DEGREES`           | `DEGREES(radians)`                                                      | Converts radians to degrees.                                  | `SELECT DEGREES(PI());` (returns 180)   |
| `PI`                | `PI()`                                                                  | Returns the value of pi (π).                                   | `SELECT PI();` (returns 3.141593)       |
| `GCD`               | `GCD(a, b)`                                                             | Returns the greatest common divisor of two numbers.           | `SELECT GCD(56, 98);` (returns 14)      |
| `LCM`               | `LCM(a, b)`                                                             | Returns the least common multiple of two numbers.             | `SELECT LCM(4, 5);` (returns 20)        |
| `BIT_AND`           | `BIT_AND(expr)`                                                         | Returns the bitwise AND of all bits in the expression.        | `SELECT BIT_AND(5), BIT_AND(7);`        |
| `BIT_OR`            | `BIT_OR(expr)`                                                          | Returns the bitwise OR of all bits in the expression.         | `SELECT BIT_OR(5), BIT_OR(7);`          |
| `BIT_XOR`           | `BIT_XOR(expr)`                                                         | Returns the bitwise XOR of all bits in the expression.        | `SELECT BIT_XOR(5), BIT_XOR(7);`        |
| `PI`                | `PI()`                                                                  | Returns the value of π (Pi).                                  | `SELECT PI();` (returns 3.141593)       |

---

### **Explanation of Some Key Functions**

1. **`ABS`**: This function returns the absolute (positive) value of the number, effectively removing any negative sign.

   ```sql
   SELECT ABS(-10);  -- Output: 10
   ```

2. **`CEIL`**: The `CEIL` function returns the smallest integer greater than or equal to the given number.

   ```sql
   SELECT CEIL(4.2);  -- Output: 5
   ```

3. **`FLOOR`**: The `FLOOR` function returns the largest integer less than or equal to the given number.

   ```sql
   SELECT FLOOR(4.8);  -- Output: 4
   ```

4. **`ROUND`**: The `ROUND` function rounds a number to the specified number of decimal places.

   ```sql
   SELECT ROUND(4.5678, 2);  -- Output: 4.57
   ```

5. **`POW`/`POWER`**: These two functions are interchangeable. They return the value of the first number raised to the power of the second number.

   ```sql
   SELECT POW(2, 3);  -- Output: 8
   SELECT POWER(2, 3);  -- Output: 8
   ```

6. **`SQRT`**: This function returns the square root of a given number.

   ```sql
   SELECT SQRT(16);  -- Output: 4
   ```

7. **`RAND`**: The `RAND` function generates a random floating-point number between 0 and 1.

   ```sql
   SELECT RAND();  -- Output: Random number between 0 and 1
   ```

8. **`MOD`**: The `MOD` function returns the remainder after dividing two numbers.

   ```sql
   SELECT MOD(10, 3);  -- Output: 1
   ```

9. **`EXP`**: This function returns the value of e (Euler's number) raised to the power of the given number.

   ```sql
   SELECT EXP(1);  -- Output: 2.718281828
   ```

10. **`LOG`**: The `LOG` function returns the natural logarithm of the given number.

    ```sql
    SELECT LOG(2);  -- Output: 0.693147181
    ```

11. **`PI`**: This function returns the value of π (Pi), which is approximately 3.141593.

    ```sql
    SELECT PI();  -- Output: 3.141593
    ```

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
