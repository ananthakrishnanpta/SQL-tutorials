CREATE TABLE SampleTable (
    -- Numeric data types
    id INT AUTO_INCREMENT PRIMARY KEY, -- Integer, used for unique identifiers
    age TINYINT UNSIGNED,              -- Tiny integer, suitable for small numbers (0 to 255)
    score SMALLINT,                    -- Small integer, used for slightly larger numbers (-32,768 to 32,767)
    quantity MEDIUMINT,                -- Medium integer, for moderately large values (-8,388,608 to 8,388,607)
    large_count BIGINT,                -- Big integer, for very large numbers (-2^63 to 2^63-1)
    price DECIMAL(10, 2),              -- Fixed-point decimal, often used for currency (10 digits, 2 decimal places)
    percentage FLOAT,                  -- Single-precision floating point, for approximate values
    rating DOUBLE,                     -- Double-precision floating point, for higher precision values
    
    -- String data types
    name VARCHAR(100),                 -- Variable-length string, commonly used for names
    description TEXT,                  -- Large text, used for longer text data
    binary_data BLOB,                  -- Binary large object, used for binary data like images
    initials CHAR(3),                  -- Fixed-length string, suitable for abbreviations (e.g., "ABC")
    
    -- Date and Time data types
    created_at DATETIME,               -- Date and time combined, without timezone (format: 'YYYY-MM-DD HH:MM:SS')
    birth_date DATE,                   -- Date only (format: 'YYYY-MM-DD')
    appointment_time TIME,             -- Time only (format: 'HH:MM:SS')
    event_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp, automatically updated on row change
    
    -- ENUM and SET data types
    status ENUM('active', 'inactive', 'pending'), -- Enumeration, used for limited, predefined values
    tags SET('red', 'green', 'blue'),             -- Set, allows multiple selections from predefined values
    
    -- JSON and Spatial data types
    metadata JSON,                     -- JSON, used to store structured data in JSON format
    location POINT                     -- Spatial data type, stores geographic point coordinates (latitude, longitude)
);


-- Numeric Types: INT, TINYINT, SMALLINT, MEDIUMINT, BIGINT, DECIMAL, FLOAT, and DOUBLE are all numeric data types, suited for different ranges and precision needs.
-- String Types: VARCHAR and TEXT handle character data, while CHAR is for fixed-length strings. BLOB is used for binary data.
-- Date and Time Types: DATETIME, DATE, TIME, and TIMESTAMP manage date and time data in different formats.
-- ENUM and SET: ENUM is used for single-choice options, while SET allows multiple values from a fixed set.
-- JSON and Spatial Types: JSON stores structured data, while POINT is for geographical coordinates.
