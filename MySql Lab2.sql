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


-- Search Customers Whose First Name Starts with “A”
SELECT *FROM Customers
WHERE FirstName LIKE 'A%';

-- Search Customers Whose Email Contains “gmail”

SELECT *FROM Customers
WHERE Email LIKE '%gmail%';

-- Search Customers Whose Last Name Ends with “kar”

SELECT *FROM Customers
WHERE LastName LIKE '%kar';


-- Retrieve Records for Selected Account Types

SELECT *FROM Accounts
WHERE AccountType IN ('Savings', 'Current');

-- Retrieve Transactions for Selected Transaction Types

SELECT *FROM Transactions
WHERE TransactionType IN ('Deposit', 'Withdrawal');

-- Retrieve Records for Selected Customers

SELECT *FROM Customers
WHERE CustomerID IN (101,102,105);

-- Display Customers in Ascending Order of Last Name

SELECT *FROM Customers
ORDER BY LastName ASC;

-- Display Accounts with Highest Balance First

SELECT *FROM Accounts
ORDER BY Balance DESC;

-- Display Transactions Sorted by Transaction Date

SELECT *FROM Transactions
ORDER BY TransactionDate DESC;

-- Display Only Top 5 Highest Balance Accounts

SELECT * FROM Accounts
ORDER BY Balance DESC
LIMIT 5;

-- Display First 3 Customer Records

SELECT * FROM Customers
LIMIT 3;


-- Skip Initial Transaction Records While Viewing Data

SELECT * FROM Transactions
LIMIT 5 OFFSET 3;

-- Display Savings Account Customers Sorted by Balance

SELECT * FROM Accounts
WHERE AccountType = 'Savings'
ORDER BY Balance DESC;

-- Search Customers Using Partial Name and Limit Results

SELECT *FROM Customers
WHERE FirstName LIKE 'S%'
LIMIT 5;

-- Display Selected Transactions in Sorted Order

SELECT *FROM Transactions
WHERE TransactionType IN ('Deposit','Withdrawal')
ORDER BY TransactionDate DESC;


-- String Functions
-- Math Functions
-- Date Functions

-- 1)String Functions

-- These functions help clean and format text values.

-- Display customer Table

select * from customers;

-- Display all customer FirstName in uppercase.

SELECT FirstName,
UPPER(FirstName) AS UpperCaseName
FROM customers;

-- Display all customer FirstName in lowercase.

SELECT 
    firstname, LOWER(firstname) AS UpperCaseName
FROM
    customers;
    
-- Find the total number of characters in each customer FirstName. 

SELECT 
    firstname, LENGTH(firstname) AS NameLength
FROM
    customers;
    
    
-- Display only the first three characters of customer FirstName .

SELECT 
    Firstname, LEFT(Firstname, 3) AS Initials
FROM
    customers;
    
 -- Combine customer's FirstName with LastName.
 
 select concat(FirstName,'-',LastName) as Fullname from customers;
 
 
 -- 2) Math Functions
 -- These functions perform financial calculations.

-- ROUND()

-- Purpose: Rounds a decimal number to the nearest whole number.
-- Syntax & Example
-- ROUND(number)

SELECT ROUND(1256.78) AS Rounded_Value;


-- CEIL()
-- Purpose: Returns the smallest integer greater than or equal to a number
-- syntax & Example
-- CEIL(number)
SELECT CEIL(1256.25) AS Ceiling_Value;

-- FLOOR()
-- Purpose: Returns the largest integer less than or equal to a number.
-- Syntax & Example
-- FLOOR(number)

SELECT FLOOR(1256.79) AS Floor_Value;

-- ABS()
-- Purpose: Returns the absolute (positive) value of a number.
-- Syntax & Example
-- ABS(number)
select abs(-2500) as Absolute_Value;

-- MOD()
-- Purpose: Returns the remainder after dividing one number by another.
-- Syntax & Example
-- MOD(dividend, divisor)
SELECT MOD(25,4) AS Remainder;


-- 3)Date Functions
-- These functions analyze dates and time
-- Display customer Table
select * from customers;

-- Display the current system date.
select curdate();

-- Display the current system date and time.
select now();

-- Display the Birth of year
SELECT CustomerID,
YEAR(DateOfBirth) AS BirthYear
FROM customers;

-- Display the Birth month.
SELECT CustomerID,
MONTH(DateOfBirth) AS BirthMonth
FROM customers;

-- Calculate the number of days since BirthDate.

SELECT
CustomerID,
DATEDIFF(CURDATE(),DateOfBirth) AS Days
FROM customers;


-- Comparison Functions
-- Categorize customers as Adult or Young based on their birth year.

SELECT 
    FirstName,
    DateOfBirth,
    IF(YEAR(DateOfBirth) <= 1995,
        'Adult',
        'Young') AS Category
FROM
    customers;
    
-- Display 'Not Available' if a phone number is NULL.

SELECT 
    FirstName, IFNULL(Phone, 'Not Available') AS PhoneNumber
FROM
    Customers;
    
    -- Find the latest birth date.
    
    SELECT GREATEST(
'2000-09-20',
'1995-06-18',
'1997-09-12',
'1993-11-25'
) AS LatestBirthDate;

-- Find the earliest birth date.

SELECT LEAST(
'2000-09-20',
'1995-06-18',
'1997-09-12',
'1993-11-25'
) AS EarliestBirthDate;

-- Compare two customer names.

SELECT
    FirstName,
    NULLIF(FirstName,'Priya') AS Result
FROM Customers;


-- 5)aggregate functions

-- Calculate the total balance maintained across all customer accounts.

select sum(balance) as total_balance from Accounts;

-- Calculate the average balance maintained across all customer accounts to understand the typical amount held by customers.

SELECT AVG(Balance) AS average_balance
FROM Accounts;


-- Identify the highest balance maintained in any customer account.

SELECT MAX(Balance) AS highest_balance
FROM Accounts;

-- Identify the lowest balance maintained in any customer account.

SELECT MIN(Balance) AS lowest_balance
FROM Accounts;

-- Determine the total number of customer accounts available in the system.

SELECT COUNT(*) AS total_accounts
FROM Accounts;

-- Q1).The bank wants to calculate the total account balance for each AccountType by 
-- grouping the records based on AccountType and 
-- identify which account type is attracting the highest total deposits from customers

SELECT 
    AccountType,
    SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType;

-- The bank management wants to identify only those account types whose total customer deposits exceed ₹25,000.

SELECT 
    AccountType,
    SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType
HAVING SUM(Balance) > 25000;



-- RANK()
-- DENSE_RANK()
-- ROW_NUMBER()
-- SUM()
-- LAG()
-- LEAD()
-- Rank()
-- Equal values receive the same rank.
-- The next rank is skipped.
Select
    LoanID,
    CustomerID, LoanAmount, RANK() OVER(
        ORDER BY LoanAmount DESC
    ) AS LoanRank
FROM Loans;
-- Dense rank()
-- The DENSE_RANK() function works similarly to RANK(), but it does not skip rank numbers.
-- Unlike RANK(), the numbering remains consecutive.

SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    DENSE_RANK() OVER(
        ORDER BY LoanAmount DESC
    ) AS DenseRank
FROM Loans;



-- Row()
SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    ROW_NUMBER() OVER(
        ORDER BY LoanAmount DESC
    ) AS RowNumber
FROM Loans;

-- partition by
SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    ROW_NUMBER() OVER(
        PARTITION BY CustomerID
        ORDER BY LoanAmount DESC
    ) AS RowNum
FROM Loans; 


-- sum() over() -- used running total

SELECT
    LoanID, CustomerID,LoanAmount,
    SUM(LoanAmount) OVER(
        ORDER BY LoanAmount DESC
    ) AS RunningTotal
FROM Loans;


-- lag()
SELECT
    LoanID,
    CustomerID,
    LoanAmount,
    LAG(LoanAmount) OVER(
        ORDER BY LoanAmount DESC
    ) AS PreviousLoanAmount
FROM Loans;


-- LEAD()

SELECT
    LoanID, CustomerID, LoanAmount,
    LEAD(LoanAmount) OVER(
        ORDER BY LoanAmount DESC
    ) AS NextLoanAmount
FROM Loans;



use banking;
-- 1) Introduction to Joins
-- 2) Types of Joins
-- 3) INNER JOIN
-- 4) LEFT JOIN

desc accounts;
desc transactions;

select * from accounts;
select* from transactions;

SELECT
    a.AccountID, a.AccountType, a.Balance,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
INNER JOIN Transactions t
ON a.AccountID = t.AccountID;

-- Display All Accounts Including Those Without Transactions  ---(LEFT Join)
SELECT
    a.AccountID, a.AccountType, a.Balance,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
LEFT JOIN Transactions t
ON a.AccountID = t.AccountID;

-- Generate Deposit Transaction Reports --- (INNER Join)

SELECT
    a.AccountID, a.AccountType, a.Balance,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
INNER JOIN Transactions t
ON a.AccountID = t.AccountID
WHERE t.TransactionType = 'Deposit';

-- Generate High Balance Account Transaction Reports

SELECT
    a.AccountID, a.AccountType, a.Balance,
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount
FROM Accounts a
INNER JOIN Transactions t
ON a.AccountID = t.AccountID
WHERE a.Balance > 30000
ORDER BY a.Balance DESC;








































   











































