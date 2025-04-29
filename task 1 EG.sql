CREATE DATABASE TechShop;
USE TechShop;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(255)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Amount DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers (CustomerID, Name, Email, Phone, Address) VALUES
(1, 'Revan', 'rev@gmail.com', '987654321', 'India'),
(2, 'Sab', 'sab@gmail.com', '98865643', 'Germany');
select * from Customers;
INSERT INTO Products (ProductID, ProductName, Description, Price) VALUES
(1, 'Laptop', 'High-performance laptop', 85000),
(2, 'Smartphone', 'Latest model smartphone', 76000);
select * from Products;
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1, 1, '2025-04-20'),
(2, 2, '2025-04-02');
select * from Orders;
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Amount) VALUES
(1, 1, 1, 2, 98000),
(2, 2, 2, 1, 89000);
select * from OrderDetails;
INSERT INTO Inventory (InventoryID, ProductID, QuantityInStock, LastStockUpdate) VALUES
(1, 1, 50, '2025-04-10'),
(2, 2, 100, '2025-04-10');
select * from Inventory;