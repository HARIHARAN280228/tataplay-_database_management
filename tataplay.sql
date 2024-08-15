CREATE SCHEMA Tataplay
  
  CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(255),
    RegistrationDate DATE
);

CREATE TABLE Subscriptions (
    SubscriptionID INT PRIMARY KEY AUTO_INCREMENT,
    PlanName VARCHAR(255) NOT NULL,
    MonthlyCost DECIMAL(10, 2),
    Description TEXT
);

CREATE TABLE Channels (
    ChannelID INT PRIMARY KEY AUTO_INCREMENT,
    ChannelName VARCHAR(255) NOT NULL,
    ChannelCategory VARCHAR(255)
);

CREATE TABLE Customer_Subscriptions (
    CustomerSubscriptionID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    SubscriptionID INT,
    SubscriptionDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (SubscriptionID) REFERENCES Subscriptions(SubscriptionID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerSubscriptionID INT,
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (CustomerSubscriptionID) REFERENCES Customer_Subscriptions(CustomerSubscriptionID)
);

CREATE TABLE Service_Requests (
    RequestID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    RequestDate DATE,
    RequestType VARCHAR(255),
    Status VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


INSERT INTO Customers (Name, Address, PhoneNumber, Email, RegistrationDate)
VALUES
('John Doe', '123 Main St', '9876543210', 'john@example.com', '2023-01-01'),
('Jane Smith', '456 Park Ave', '8765432109', 'jane@example.com', '2023-02-15');

INSERT INTO Subscriptions (PlanName, MonthlyCost, Description)
VALUES
('Basic Plan', 199.00, 'Basic package with limited channels'),
('Premium Plan', 499.00, 'Premium package with all channels');

insert INTO Channels (ChannelName, ChannelCategory)
VALUES
('Star Sports', 'Sports'),
('HBO', 'Entertainment');

INSERT INTO Customer_Subscriptions (CustomerID, SubscriptionID, SubscriptionDate)
VALUES
(1, 1, '2023-01-01'),
(2, 2, '2023-02-15');

INSERT INTO Payments (CustomerSubscriptionID, PaymentDate, Amount, PaymentMethod)
VALUES
(1, '2023-01-05', 199.00, 'Credit Card'),
(2, '2023-02-20', 499.00, 'Debit Card');

INSERT INTO Service_Requests (CustomerID, RequestDate, RequestType, Status)
VALUES
(1, '2023-03-01', 'Installation', 'Completed'),
(2, '2023-03-05', 'Technical Support', 'Pending');

SELECT 
    c.Name AS CustomerName,
    s.PlanName AS SubscriptionPlan,
    p.PaymentDate,
    p.Amount
FROM 
    Customers c
INNER JOIN 
    Customer_Subscriptions cs ON c.CustomerID = cs.CustomerID
INNER JOIN 
    Subscriptions s ON cs.SubscriptionID = s.SubscriptionID
INNER JOIN 
    Payments p ON cs.CustomerSubscriptionID = p.CustomerSubscriptionID;



SELECT 
    c.Name AS CustomerName,
    s.PlanName AS SubscriptionPlan,
    p.PaymentDate,
    p.Amount
FROM 
    Customers c
LEFT JOIN 
    Customer_Subscriptions cs ON c.CustomerID = cs.CustomerID
LEFT JOIN 
    Subscriptions s ON cs.SubscriptionID = s.SubscriptionID
LEFT JOIN 
    Payments p ON cs.CustomerSubscriptionID = p.CustomerSubscriptionID;



SELECT 
    c.Name AS CustomerName,
    s.PlanName AS SubscriptionPlan,
    p.PaymentDate,
    p.Amount
FROM 
    Payments p
RIGHT JOIN 
    Customer_Subscriptions cs ON p.CustomerSubscriptionID = cs.CustomerSubscriptionID
RIGHT JOIN 
    Customers c ON cs.CustomerID = c.CustomerID
RIGHT JOIN 
    Subscriptions s ON cs.SubscriptionID = s.SubscriptionID;


SELECT 
    c.Name AS CustomerName,
    ch.ChannelName
FROM 
    Customers c
CROSS JOIN 
    Channels ch;

SELECT 
    c.Name AS CustomerName,
    s.PlanName AS SubscriptionPlan,
    p.PaymentDate,
    p.Amount
FROM 
    Customers c
LEFT JOIN 
    Customer_Subscriptions cs ON c.CustomerID = cs.CustomerID
LEFT JOIN 
    Subscriptions s ON cs.SubscriptionID = s.SubscriptionID
LEFT JOIN 
    Payments p ON cs.CustomerSubscriptionID = p.CustomerSubscriptionID

UNION

SELECT 
    c.Name AS CustomerName,
    s.PlanName AS SubscriptionPlan,
    p.PaymentDate,
    p.Amount
FROM 
    Customer_Subscriptions cs
LEFT JOIN 
    Customers c ON c.CustomerID = cs.CustomerID
LEFT JOIN 
    Subscriptions s ON cs.SubscriptionID = s.SubscriptionID
LEFT JOIN 
    Payments p ON cs.CustomerSubscriptionID = p.CustomerSubscriptionID

UNION

SELECT 
    c.Name AS CustomerName,
    s.PlanName AS SubscriptionPlan,
    p.PaymentDate,
    p.Amount
FROM 
    Payments p
LEFT JOIN 
    Customer_Subscriptions cs ON cs.CustomerSubscriptionID = p.CustomerSubscriptionID
LEFT JOIN 
    Customers c ON cs.CustomerID = c.CustomerID
LEFT JOIN 
    Subscriptions s ON cs.SubscriptionID = s.SubscriptionID;
