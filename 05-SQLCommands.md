# **SQL Commands Categorization and Explanation**

SQL commands are categorized into five primary types based on their functionality. Each category of SQL commands serves a specific purpose in managing and manipulating relational databases. Below are the five categories and their respective commands, with a description of what each category and command deals with.

---

## **1. Data Definition Language (DDL)**

**Definition**: DDL commands are used to define, manage, and modify the structure of the database objects, such as tables, schemas, indexes, and views. These commands deal with the creation, alteration, and deletion of database structures.

### **Common DDL Commands**:

| Command      | Description |
|--------------|-------------|
| `CREATE`     | Creates a new database object like a table, index, view, or schema. |
| `ALTER`      | Modifies an existing database object, such as adding/removing columns, changing data types, or renaming. |
| `DROP`       | Deletes a database object, such as a table, view, or schema. |
| `TRUNCATE`   | Removes all rows from a table but retains its structure for future use. |
| `RENAME`     | Renames an existing database object (such as a table or column). |

### **Example of DDL**:
```sql
-- Creating a new table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birthdate DATE
);

-- Altering a table to add a column
ALTER TABLE students ADD COLUMN email VARCHAR(100);

-- Dropping a table
DROP TABLE students;
```

---

## **2. Data Manipulation Language (DML)**

**Definition**: DML commands are used for managing data within schema objects. These commands allow you to insert, update, delete, and retrieve data from tables. DML commands directly affect the data stored in the database.

### **Common DML Commands**:

| Command      | Description |
|--------------|-------------|
| `INSERT`     | Adds new records (rows) to a table. |
| `UPDATE`     | Modifies existing records in a table. |
| `DELETE`     | Removes records from a table. |

### **Example of DML**:
```sql
-- Inserting data into the students table
INSERT INTO students (student_id, first_name, last_name, birthdate)
VALUES (1, 'John', 'Doe', '2000-01-01');

-- Updating data in the students table
UPDATE students
SET email = 'john.doe@example.com'
WHERE student_id = 1;

-- Deleting data from the students table
DELETE FROM students
WHERE student_id = 1;
```

---

## **3. Data Query Language (DQL)**

**Definition**: DQL commands are used to query or retrieve data from the database. It does not modify the data in any way but allows users to select specific information from one or more tables based on conditions.

### **Common DQL Commands**:

| Command      | Description |
|--------------|-------------|
| `SELECT`     | Retrieves data from one or more tables. |

### **Example of DQL**:
```sql
-- Selecting all columns from the students table
SELECT * FROM students;

-- Selecting specific columns with a condition
SELECT first_name, last_name FROM students
WHERE birthdate = '2000-01-01';
```

---

## **4. Data Control Language (DCL)**

**Definition**: DCL commands are used to control access to data in a database. These commands define permissions and access rights for database users, ensuring that only authorized users can perform certain actions.

### **Common DCL Commands**:

| Command      | Description |
|--------------|-------------|
| `GRANT`      | Assigns specific privileges to a user or role. |
| `REVOKE`     | Removes specific privileges from a user or role. |

### **Example of DCL**:
```sql
-- Granting SELECT permission to a user
GRANT SELECT ON students TO user_name;

-- Revoking DELETE permission from a user
REVOKE DELETE ON students FROM user_name;
```

---

## **5. Transaction Control Language (TCL)**

**Definition**: TCL commands are used to manage transactions within a database. A transaction is a sequence of operations performed as a single unit of work, and TCL commands ensure that the database remains in a consistent state.

### **Common TCL Commands**:

| Command      | Description |
|--------------|-------------|
| `COMMIT`     | Saves all changes made in the current transaction to the database. |
| `ROLLBACK`   | Undoes changes made in the current transaction, reverting to the last commit. |
| `SAVEPOINT`  | Sets a point within a transaction that you can roll back to, without affecting the entire transaction. |
| `SET TRANSACTION` | Sets the properties of the transaction, such as isolation level. |

### **Example of TCL**:
```sql
-- Starting a transaction
START TRANSACTION;

-- Inserting data as part of a transaction
INSERT INTO students (student_id, first_name, last_name) 
VALUES (2, 'Jane', 'Smith');

-- Committing the transaction to save changes
COMMIT;

-- Rolling back a transaction if an error occurs
ROLLBACK;
```

---

## **Summary of SQL Command Categories**

| Category                | Purpose                                                    | Example Commands                |
|-------------------------|------------------------------------------------------------|---------------------------------|
| **DDL (Data Definition Language)** | Defines and manages database structure (tables, indexes, schemas) | `CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME` |
| **DML (Data Manipulation Language)** | Manages data manipulation (insertion, updates, and deletion) | `INSERT`, `UPDATE`, `DELETE`   |
| **DQL (Data Query Language)**       | Retrieves data from the database without modifying it   | `SELECT`                        |
| **DCL (Data Control Language)**    | Controls access and privileges on database objects      | `GRANT`, `REVOKE`               |
| **TCL (Transaction Control Language)** | Manages transaction behavior and ensures data integrity | `COMMIT`, `ROLLBACK`, `SAVEPOINT`, `SET TRANSACTION` |

---
