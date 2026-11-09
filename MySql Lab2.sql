CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    AccountCreationDate DATE
);
 
 CREATE TABLE Accounts (
    AccountID INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(10,2)
);

CREATE TABLE Transactions (
    TransactionID INT,
    TransactionDate DATE,
    Amount DECIMAL(10,2),
    TransactionType VARCHAR(20)
);


CREATE TABLE Branches (
    BranchID INT,
    BranchName VARCHAR(100),
    BranchAddress VARCHAR(200),
    BranchPhone VARCHAR(15)
);


CREATE TABLE AccountBranches ( 
		AssignmentDate DATE
);

CREATE TABLE Loans (
    LoanID INT,
    LoanAmount DECIMAL(10,2),
    InterestRate DECIMAL(5,2),
    StartDate DATE,
    EndDate DATE
);


ALTER TABLE Customers
ADD DateOfBirth DATE;

ALTER TABLE Customers
MODIFY Phone VARCHAR(20);


ALTER TABLE Accounts
ADD CONSTRAINT chk_MinBalance
CHECK (Balance >= 1000);

DROP TABLE AccountBranches;


-- connect customer table with acounts

ALTER TABLE Accounts
ADD CustomerID INT;

ALTER TABLE Accounts
ADD CONSTRAINT FK_Accounts_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE Customers
MODIFY FirstName VARCHAR(50) NOT NULL;

ALTER TABLE Customers
ADD CONSTRAINT uq_Email UNIQUE (Email);

desc accounts; 
desc customers;
desc loans;
desc transactions;

ALTER TABLE accounts
ADD PRIMARY KEY (accountid);

-- connect loans table with customers

alter table loans
add customerID int;


ALTER TABLE loans
ADD PRIMARY KEY (loanid);


ALTER TABLE loans
ADD CONSTRAINT aK_Accounts_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

desc loans;

-- connect transaction table with accounts

desc accounts;
desc transactions;
alter table transactions
add AccountID int;


ALTER TABLE transactions
ADD PRIMARY KEY (transactionid);


ALTER TABLE transactions
ADD CONSTRAINT SK_Accounts_Customers
FOREIGN KEY (accountID)
REFERENCES accounts(accountID);


-- connect branch table with accounts

desc branches;
desc accounts;


alter table accounts
add branchID int;


ALTER TABLE branches
ADD PRIMARY KEY (branchid);

ALTER table accounts
ADD CONSTRAINT vK_Accounts_Customers
FOREIGN KEY (branchID)
REFERENCES branches(branchID);

-- insert records in customer table 
INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, DateOfBirth)
VALUES
(101,'Rahul','Sharma','rahul@gmail.com','9876543210','1998-04-15');

-- Insert Records into Accounts Table
INSERT INTO Accounts
(AccountID, CustomerID, AccountType, Balance)
VALUES
(201,101,'Savings',25000);


-- Update Customer Phone Number

SET SQL_SAFE_UPDATES=1;
UPDATE Customers
SET Phone='9999999999'
WHERE CustomerID=101;

-- Verify Updated Customer Record:
SELECT * FROM Customers
WHERE CustomerID = 101;

-- Update Customer Email Address
UPDATE Customers
SET Email='rahul.sharma@gmail.com'
WHERE CustomerID=101;

-- Verify Updated Customer Record:
SELECT * FROM Customers
WHERE CustomerID = 101;

-- Delete Transaction Record
DELETE FROM Transactions
WHERE TransactionID = 302;

-- Verify Transaction Records
SELECT * FROM Transactions;

-- Delete Account Record
DELETE FROM Accounts
WHERE AccountID = 202;

-- Verify Account Records

SELECT * FROM Accounts;

-- Insert 4 Records into Customers Table

INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, DateOfBirth)
VALUES
(102, 'Priya', 'Patil', 'priya@gmail.com', '9988776655', '2000-09-20'),
(103, 'Amit', 'Patel', 'amit.patel@gmail.com', '9876500001', '1995-06-18'),
(104, 'Sneha', 'Joshi', 'sneha.joshi@gmail.com', '9876500002', '1997-09-12'),
(105, 'Rohan', 'Kulkarni', 'rohan.k@gmail.com', '9876500003', '1993-11-25');

-- Insert 4 Records into Accounts Table
INSERT INTO Accounts
(AccountID, CustomerID, AccountType, Balance)
VALUES
(202, 102, 'Current', 40000),
(203, 103, 'Savings', 35000),
(204, 104, 'Current', 60000),
(205, 105, 'Savings', 45000);


-- Insert 5 Records into Transactions Table
INSERT INTO Transactions
(TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES
(301, 201, '2025-05-10', 5000, 'Deposit'),
(302, 202, '2025-05-11', 2500, 'Withdraw'),
(303, 203, '2025-05-12', 10000, 'Deposit'),
(304, 204, '2025-05-13', 3000, 'Withdraw'),
(305, 205, '2025-05-14', 7000, 'Deposit');

-- Insert 5 Records into Branches Table
INSERT INTO Branches
(BranchID, BranchName, BranchAddress, BranchPhone)
VALUES
(1, 'Mumbai Branch', 'Andheri, Mumbai', '0221111111'),
(2, 'Pune Branch', 'Shivaji Nagar, Pune', '0202222222'),
(3, 'Nashik Branch', 'College Road, Nashik', '0253222222'),
(4, 'Nagpur Branch', 'Sitabuldi, Nagpur', '0712333333'),
(5, 'Navi Mumbai Branch', 'Vashi, Navi Mumbai', '0224444444');

-- Insert 5 Records into Loans Table
INSERT INTO Loans
(LoanID, LoanAmount, InterestRate, StartDate, EndDate, CustomerID)
VALUES
(301, 500000, 8.50, '2025-01-15', '2030-01-15', 101),
(302, 300000, 9.25, '2025-02-10', '2028-02-10', 102),
(303, 750000, 8.75, '2025-03-20', '2032-03-20', 103),
(304, 250000, 10.00, '2025-04-05', '2029-04-05', 104),
(305, 1000000, 7.95, '2025-05-12', '2035-05-12', 105);


-- View Complete Customer Information
SELECT * FROM Customers;

-- View Only Required Customer Details

SELECT FirstName, LastName, Email, Phone
FROM Customers;

-- Retrieve Customers with Savings Accounts

SELECT *FROM Accounts
WHERE AccountType = 'Savings';

-- Retrieve Accounts with Balance Greater Than 25000

SELECT *FROM Accounts
WHERE Balance > 25000;

-- Retrieve Transactions Between Specific Amounts

SELECT *FROM Transactions
WHERE Amount BETWEEN 5000 AND 20000;

-- Retrieve Records for Selected Customers

SELECT *FROM Customers
WHERE CustomerID IN (101,102,103);

-- Search Customers Using Partial Name Matching

SELECT *FROM Customers
WHERE FirstName LIKE 'R%';

-- Display Customers in Alphabetical Order

SELECT *FROM Customers
ORDER BY FirstName ASC;

-- Display Accounts with Highest Balance First

SELECT *FROM Accounts
ORDER BY Balance DESC;

-- Retrieve Unique Account Types

SELECT DISTINCT AccountType
FROM Accounts;

-- Display Top 3 Highest Balance Accounts

SELECT *FROM Accounts
ORDER BY Balance DESC
LIMIT 3;

-- Skip Initial Records While Viewing Transactions

SELECT *FROM Transactions
LIMIT 5 OFFSET 2;

-- Find Customers Without Phone Numbers
SELECT * FROM Customers
WHERE Phone IS NULL;

-- Find Customers Having Email Addresses

SELECT * FROM Customers
WHERE Email IS NOT NULL;

-- Categorize Accounts Using Balance

SELECT AccountID,
       Balance,
       CASE
           WHEN Balance >= 50000 THEN 'Premium Account'
           WHEN Balance >= 25000 THEN 'Standard Account'
           ELSE 'Basic Account'
       END AS AccountCategory
FROM Accounts;

-- Assign Rank Based on Account Balance

SELECT AccountID,
       Balance,
       RANK() OVER (ORDER BY Balance DESC) AS BalanceRank
FROM Accounts;

-- Calculate Running Total of Transactions

SELECT TransactionID,
       Amount,
       SUM(Amount) OVER (ORDER BY TransactionDate) AS RunningTotal
FROM Transactions;


-- Display Average Transaction Amount

SELECT TransactionID,
       Amount,
       AVG(Amount) OVER () AS AverageTransaction
FROM Transactions;











