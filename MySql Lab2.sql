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





