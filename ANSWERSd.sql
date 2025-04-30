-- answers.sql
-- Database Design and Normalization Assignment
-- Author: [TM HLATSHWAYO]


-- ----------------------------------------
-- Question 1: Achieving 1NF
-- ----------------------------------------

-- Creating normalized ProductDetail_1NF table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Inserting data into 1NF-compliant table
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- ----------------------------------------
-- Question 2: Achieving 2NF
-- ----------------------------------------

-- Creating Orders table to separate CustomerName
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Creating OrderProducts table for product-specific data
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Inserting data into Orders table
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Inserting data into OrderProducts table
INSERT INTO OrderProducts (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- ----------------------------------------
-- Question 3: Achieving 3NF
-- ----------------------------------------

-- Creating Customers table to eliminate transitive dependency
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    CustomerAddress VARCHAR(255)
);

-- Updating Orders table to reference Customers via CustomerID
DROP TABLE IF EXISTS Orders; -- Dropping previous Orders table to redefine structure

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Inserting data into Customers
INSERT INTO Customers (CustomerID, CustomerName, CustomerAddress) VALUES
(1, 'John Doe', '123 Main St'),
(2, 'Jane Smith', '456 Oak Ave'),
(3, 'Emily Clark', '789 Pine Rd');

-- Re-inserting data into normalized Orders table
INSERT INTO Orders (OrderID, CustomerID) VALUES
(101, 1),
(102, 2),
(103, 3);
