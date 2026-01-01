CREATE DATABASE finalDBproject;
use finalDBproject;

-----------------------
-- LIBRARY-Table---
----------------------

CREATE TABLE LIBRARY_Table (
    LibraryID INT IDENTITY(1,1) PRIMARY KEY,
    LName NVARCHAR(100) NOT NULL UNIQUE,
    Lib_Location NVARCHAR(100) NOT NULL,
    ContactNumber NVARCHAR(20) NOT NULL,
    EstablishedYear INT
);

INSERT INTO LIBRARY_Table (LName, Lib_Location, ContactNumber, EstablishedYear)
VALUES
('Shinas Library', 'shinas_UTAS', '123-456-7890', 1990),
('Suhar Library', 'UNIVERSITY', '987-654-3210', 2010),
('Muscat Central Library', 'Muscat', '555-1111', 2005);

SELECT * from  LIBRARY_Table;

-----------------------
-- BOOK-Table---
----------------------
CREATE TABLE Book (
    BookID INT IDENTITY(1,1) PRIMARY KEY,
    ISBN NVARCHAR(20) NOT NULL UNIQUE,
    Title NVARCHAR(200) NOT NULL,
    Genre NVARCHAR(50) NOT NULL CHECK (Genre IN ('Fiction','Non-fiction','Reference','Children')),
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    IsAvailable BIT NOT NULL DEFAULT 1,
    ShelfLocation NVARCHAR(50) NOT NULL,
    LibraryID INT NOT NULL,
    CONSTRAINT FK_Book_Library FOREIGN KEY (LibraryID)
        REFERENCES LIBRARY_Table(LibraryID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Book (ISBN, Title, Genre, Price, ShelfLocation, LibraryID)
VALUES

('111-0001', 'Data Science Basics', 'Non-fiction', 22.50, 'A2', 1),
('111-0002', 'SQL Mastery', 'Reference', 35.00, 'A3', 1),
('111-0003', 'Fairy Tales', 'Children', 12.00, 'A4', 1),
('111-0004', 'Mystery Island', 'Fiction', 18.00, 'A5', 1),
('111-0005', 'AI Future', 'Non-fiction', 28.00, 'A6', 1),
('222-0001', 'Football Legends', 'Fiction', 16.50, 'B3', 2),
('222-0002', 'World History', 'Non-fiction', 24.00, 'B4', 2),
('222-0003', 'Encyclopedia Vol 1', 'Reference', 50.00, 'B5', 2),
('222-0004', 'Kids Stories', 'Children', 10.00, 'B6', 2),
('222-0005', 'Science Explained', 'Reference', 45.00, 'B7', 2),
('333-0001', 'Modern Fiction', 'Fiction', 20.00, 'C1', 3),
('333-0002', 'Learning Python', 'Reference', 42.00, 'C2', 3),
('333-0003', 'Healthy Living', 'Non-fiction', 19.00, 'C3', 3),
('333-0004', 'Children Fun Book', 'Children', 11.50, 'C4', 3),
('333-0005', 'Advanced SQL', 'Reference', 48.00, 'C5', 3),
('333-0006', 'Short Stories', 'Fiction', 14.00, 'C6', 3),
('333-0007', 'History of Oman', 'Non-fiction', 26.00, 'C7', 3),
('333-0008', 'Math for Kids', 'Children', 9.50, 'C8', 3),
('333-0009', 'Tech Trends', 'Non-fiction', 30.00, 'C9', 3),
('333-0010', 'Fantasy World', 'Fiction', 17.00, 'C10', 3);

SELECT * from  Book;

-------------
-- MEMBER---
-------------

CREATE TABLE MEMBER_TABLE (
    MemberID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100),
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PhoneNumber NVARCHAR(20),
    MembershipStartDate DATE NOT NULL
);



INSERT INTO MEMBER_TABLE (FullName, Email, PhoneNumber, MembershipStartDate)
VALUES
('EBTESAM', 'EBTESAM@GOOGLE.com', '333-1234', '2025-02-03'),
('AHMED', 'AHMED@OUTLOOK.com', '111-5678', '2022-09-04'),
('FATMA', 'FATMA@HOTMAIL.com', '222-5678', '2020-11-11'),
('ALI', 'ALI@gmail.com', '900-1111', '2021-01-01'),
('SARA', 'SARA@gmail.com', '900-2222', '2021-03-10'),
('MOHAMMED', 'MOHAMMED@gmail.com', '900-3333', '2022-05-20'),
('HIND', 'HIND@gmail.com', '900-4444', '2022-08-15'),
('KHALID', 'KHALID@gmail.com', '900-5555', '2023-01-01'),
('AISHA', 'AISHA@gmail.com', '900-6666', '2023-02-14'),
('YOUSEF', 'YOUSEF@gmail.com', '900-7777', '2023-04-01');

SELECT * from  MEMBER_TABLE;

---------------
-- STAFF-----
--------------
CREATE TABLE STAFF_TABLE (
    StaffID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100),
    Position NVARCHAR(50),
    ContactNumber NVARCHAR(20),
    LibraryID INT NOT NULL,
    CONSTRAINT FK_Staff_Library FOREIGN KEY (LibraryID)
        REFERENCES LIBRARY_Table(LibraryID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO STAFF_TABLE (FullName, Position, ContactNumber, LibraryID)
VALUES
('EBTESAM ALZAABI', 'Librarian', '777-1111', 1),
('NURA ALHOSANI', 'Assistant Librarian', '888-2222', 1),
('AMANI ALSALHI', 'Auditor', '999-3333', 2);

SELECT * from  STAFF_TABLE;

--------------------
-- LOAN---
-----------------
CREATE TABLE Loan_table (
    LoanID INT IDENTITY(1,1) PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE NULL,
    Status NVARCHAR(20) NOT NULL DEFAULT 'Issued' CHECK (Status IN ('Issued', 'Returned', 'Overdue')),
    
    CONSTRAINT chk_ReturnDate CHECK (ReturnDate IS NULL OR ReturnDate >= LoanDate),

);

INSERT INTO Loan_table (MemberID, BookID, LoanDate, DueDate, ReturnDate, Status)
VALUES
(1, 1, '2025-12-01', '2025-12-15', NULL, 'Issued'),
(1, 2, '2025-12-02', '2025-12-16', '2025-12-14', 'Returned'),
(2, 3, '2025-12-05', '2025-12-20', NULL, 'Issued'),
(4, 1, '2025-04-01', '2025-04-15', NULL, 'Issued'),
(5, 2, '2025-05-03', '2025-04-18', NULL, 'Issued'),
(6, 3, '2025-02-01', '2025-08-13', NULL, 'Issued'),
(7, 2, '2025-07-08', '2025-07-12', NULL, 'Issued'),
(8, 1, '2025-03-09', '2025-09-11', NULL, 'Issued'),
(9, 1, '2025-06-03', '2025-10-10', NULL, 'Issued'),
(10, 3, '2025-01-05', '2025-02-20', '2025-04-18', 'Returned');

SELECT * from  Loan_table;

--------------------------
-- PAYMENT----
-----------
CREATE TABLE Payment (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    LoanID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL CHECK (Amount > 0),
    Method NVARCHAR(50),
    CONSTRAINT FK_Payment_Loan FOREIGN KEY (LoanID)
        REFERENCES Loan_table(LoanID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Payment (LoanID, PaymentDate, Amount, Method)
VALUES
(2, '2025-12-14', 5.00, 'Cash'),
(2, '2025-12-14', 3.50, 'Card'),
(3, '2025-02-25', 6.00, 'Cash'),
(8, '2025-05-20', 8.50, 'Card');


SELECT * from  Payment;

---------------------
-- REVIEW----
-------------------
CREATE TABLE Review (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT NOT NULL,
    MemberID INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Comments NVARCHAR(500) DEFAULT 'No comments',
    ReviewDate DATE NOT NULL,
    CONSTRAINT FK_Review_Book FOREIGN KEY (BookID)
        REFERENCES dbo.Book(BookID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_Review_Member FOREIGN KEY (MemberID)
        REFERENCES MEMBER_TABLE(MemberID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


INSERT INTO Review (BookID, MemberID, Rating, Comments, ReviewDate)
VALUES
(1, 1, 5, 'Amazing read!', '2025-12-10'),
(2, 1, 4, 'so happy.', '2025-12-12'),
(3, 2, 5, 'sad', '2025-12-15'); 

SELECT * from  Review;

------------------


----																		----------------------------------
------Section 1: Complex Queries with Joins------------
-----------------------------------------------------------

---- (1 )- Library Book Inventory Report----

SELECT 
    L.LName AS LibraryName,
    COUNT(B.BookID) AS TotalBooks,
    SUM(CASE WHEN B.IsAvailable = 1 THEN 1 ELSE 0 END) AS AvailableBooks,
    SUM(CASE WHEN B.IsAvailable = 0 THEN 1 ELSE 0 END) AS BooksOnLoan
FROM LIBRARY_Table L
LEFT JOIN Book B ON L.LibraryID = B.LibraryID
GROUP BY L.LName;


------- (2) Active Borrowers Analysis--------

SELECT 
    M.FullName AS MemberName,
    M.Email,
    B.Title AS BookTitle,
    L.LoanDate,
    L.DueDate,
    L.Status
FROM Loan_table L
JOIN MEMBER_TABLE M ON L.MemberID = M.MemberID
JOIN Book B ON L.BookID = B.BookID
WHERE L.Status IN ('Issued', 'Overdue');



-----(3) Issued Loans with Member Details---

SELECT 
    M.FullName AS MemberName,
    M.PhoneNumber,
    B.Title AS BookTitle,
    LT.LName AS LibraryName,
    DATEDIFF(DAY, L.DueDate, GETDATE()) AS DaysOverdue,
    ISNULL(SUM(P.Amount), 0) AS TotalFinePaid
FROM Loan_table L
JOIN MEMBER_TABLE M ON L.MemberID = M.MemberID
JOIN Book B ON L.BookID = B.BookID
JOIN LIBRARY_Table LT ON B.LibraryID = LT.LibraryID
LEFT JOIN Payment P ON L.LoanID = P.LoanID
WHERE L.Status = 'Issued'
GROUP BY 
    M.FullName, M.PhoneNumber, B.Title, LT.LName, L.DueDate;



	----(4) Staff Performance Overview---------

	SELECT 
    LT.LName AS LibraryName,
    S.FullName AS StaffName,
    S.Position,
    COUNT(B.BookID) AS BooksManaged
FROM LIBRARY_Table LT
JOIN STAFF_TABLE S ON LT.LibraryID = S.LibraryID
LEFT JOIN Book B ON LT.LibraryID = B.LibraryID
GROUP BY 
    LT.LName, S.FullName, S.Position;



	---(5)  Book Popularity Report ---

	SELECT 
    B.Title,
    B.ISBN,
    B.Genre,
    COUNT(L.LoanID) AS TimesLoaned,
    AVG(R.Rating) AS AverageRating
FROM Book B
JOIN Loan_table L ON B.BookID = L.BookID
LEFT JOIN Review R ON B.BookID = R.BookID
GROUP BY 
    B.Title, B.ISBN, B.Genre
HAVING COUNT(L.LoanID) >= 3;


---(6) Member Reading History-----

SELECT 
    M.FullName AS MemberName,
    B.Title AS BookTitle,
    L.LoanDate,
    L.ReturnDate,
    R.Rating,
    R.Comments
FROM MEMBER_TABLE M
LEFT JOIN Loan_table L ON M.MemberID = L.MemberID
LEFT JOIN Book B ON L.BookID = B.BookID
LEFT JOIN Review R 
    ON R.MemberID = M.MemberID 
    AND R.BookID = B.BookID
ORDER BY 
    M.FullName, L.LoanDate;


	----- (7)  Revenue Analysis by Genre ----

	SELECT 
    B.Genre,
    COUNT(DISTINCT L.LoanID) AS TotalLoans,
    ISNULL(SUM(P.Amount), 0) AS TotalFineCollected,
    ISNULL(SUM(P.Amount) / NULLIF(COUNT(DISTINCT L.LoanID), 0), 0) 
        AS AverageFinePerLoan
FROM Book B
JOIN Loan_table L ON B.BookID = L.BookID
LEFT JOIN Payment P ON L.LoanID = P.LoanID
GROUP BY B.Genre;



--------------------------------------------------------
---------- Section 2: Aggregate Functions and Grouping--
--------------------------------------------------------

----- 8.Monthly Loan Statistics-------

SELECT 
    DATENAME(MONTH, LoanDate) AS MonthName,
    COUNT(*) AS TotalLoans,
    SUM(CASE WHEN Status = 'Returned' THEN 1 ELSE 0 END) AS TotalReturned,
    SUM(CASE WHEN Status IN ('Issued', 'Overdue') THEN 1 ELSE 0 END) AS StillIssuedOrOverdue
FROM Loan_table
WHERE YEAR(LoanDate) = YEAR(GETDATE())
GROUP BY 
    DATENAME(MONTH, LoanDate),
    MONTH(LoanDate)
ORDER BY MONTH(LoanDate);



----------9. Member Engagement Metrics:------------

SELECT 
    M.FullName AS MemberName,
    COUNT(L.LoanID) AS TotalBooksBorrowed,
    SUM(CASE WHEN L.Status IN ('Issued', 'Overdue') THEN 1 ELSE 0 END) 
        AS CurrentlyOnLoan,
    ISNULL(SUM(P.Amount), 0) AS TotalFinesPaid,
    AVG(R.Rating) AS AverageRatingGiven
FROM MEMBER_TABLE M
JOIN Loan_table L ON M.MemberID = L.MemberID
LEFT JOIN Payment P ON L.LoanID = P.LoanID
LEFT JOIN Review R ON M.MemberID = R.MemberID
GROUP BY 
    M.FullName;



----------10.Library Performance Comparison---------

SELECT 
    LT.LName AS LibraryName,
    COUNT(DISTINCT B.BookID) AS TotalBooksOwned,
    COUNT(DISTINCT L.MemberID) AS ActiveMembers,
    ISNULL(SUM(P.Amount), 0) AS TotalFineRevenue,
    CAST(COUNT(DISTINCT B.BookID) * 1.0 
         / NULLIF(COUNT(DISTINCT L.MemberID), 0) 
         AS DECIMAL(10,2)) AS AvgBooksPerMember
FROM LIBRARY_Table LT
LEFT JOIN Book B ON LT.LibraryID = B.LibraryID
LEFT JOIN Loan_table L ON B.BookID = L.BookID
LEFT JOIN Payment P ON L.LoanID = P.LoanID
GROUP BY 
    LT.LName;


-----------11.High-Value Books Analysis--------

SELECT 
    B.Title,
    B.Genre,
    B.Price,
    AVG(B.Price) OVER (PARTITION BY B.Genre) AS GenreAveragePrice,
    B.Price - AVG(B.Price) OVER (PARTITION BY B.Genre) AS PriceDifference
FROM Book B
WHERE B.Price >
      (SELECT AVG(B2.Price)
       FROM Book B2
       WHERE B2.Genre = B.Genre);


-----------12. Payment Pattern Analysis--------

SELECT 
    Method AS PaymentMethod,
    COUNT(*) AS NumberOfTransactions,
    SUM(Amount) AS TotalCollected,
    AVG(Amount) AS AveragePaymentAmount,
    CAST(
        SUM(Amount) * 100.0 / SUM(SUM(Amount)) OVER ()
        AS DECIMAL(5,2)
    ) AS PercentageOfTotalRevenue
FROM Payment
GROUP BY Method;





--------------------------------------------------------
---------- Section  3: Views Creation-------------
--------------------------------------------------------


------------13.vw_CurrentLoans-------------
CREATE VIEW vw_CurrentLoans AS
SELECT
    L.LoanID,
    M.MemberID,
    M.FullName AS MemberName,
    M.Email,
    M.PhoneNumber,
    B.BookID,
    B.Title AS BookTitle,
    B.Genre,
    B.ShelfLocation,
    L.LoanDate,
    L.DueDate,
    L.Status,
    DATEDIFF(DAY, GETDATE(), L.DueDate) AS DaysUntilDue,
    CASE 
        WHEN L.DueDate < GETDATE() THEN DATEDIFF(DAY, L.DueDate, GETDATE())
        ELSE 0
    END AS DaysOverdue
FROM Loan_table L
JOIN MEMBER_TABLE M ON L.MemberID = M.MemberID
JOIN Book B ON L.BookID = B.BookID
WHERE L.Status IN ('Issued', 'Overdue');

	SELECT * FROM vw_CurrentLoans;

------------14. Vw _Library Statistics------------

CREATE VIEW vw_LibraryStatistics AS
SELECT
    Lib.LibraryID,
    Lib.LName AS LibraryName,
    COUNT(DISTINCT B.BookID) AS TotalBooks,
    SUM(CASE WHEN B.IsAvailable = 1 THEN 1 ELSE 0 END) AS AvailableBooks,
    COUNT(DISTINCT M.MemberID) AS TotalMembers,
    SUM(CASE WHEN L.Status IN ('Issued','Overdue') THEN 1 ELSE 0 END) AS ActiveLoans,
    COUNT(DISTINCT S.StaffID) AS TotalStaff,
    ISNULL(SUM(P.Amount),0) AS TotalRevenue
FROM LIBRARY_Table Lib
LEFT JOIN Book B ON B.LibraryID = Lib.LibraryID
LEFT JOIN STAFF_TABLE S ON S.LibraryID = Lib.LibraryID
LEFT JOIN Loan_table L ON L.BookID = B.BookID
LEFT JOIN Payment P ON P.LoanID = L.LoanID
LEFT JOIN MEMBER_TABLE M ON M.MemberID = L.MemberID
GROUP BY Lib.LibraryID, Lib.LName;

SELECT * FROM vw_LibraryStatistics;


------------15.Vw _Book Details With Reviews--------

CREATE VIEW vw_BookDetailsWithReviews AS
SELECT
    B.BookID,
    B.ISBN,
    B.Title,
    B.Genre,
    B.Price,
    B.ShelfLocation,
    B.IsAvailable,
    Lib.LName AS LibraryName,
    COUNT(R.ReviewID) AS TotalReviews,
    ISNULL(AVG(CAST(R.Rating AS DECIMAL(3,2))),0) AS AverageRating,
    MAX(R.ReviewDate) AS LatestReviewDate
FROM Book B
LEFT JOIN Review R ON R.BookID = B.BookID
LEFT JOIN LIBRARY_Table Lib ON B.LibraryID = Lib.LibraryID
GROUP BY 
    B.BookID, B.ISBN, B.Title, B.Genre, B.Price, B.ShelfLocation, B.IsAvailable, Lib.LName;

	SELECT * FROM vw_BookDetailsWithReviews;


	
--------------------------------------------------------
---------- Section4: Stored Procedures-------------
--------------------------------------------------------

-------16- sp_IssueBook ------------


create procedure finalproject
as
select*
from Book

exec finalproject

CREATE PROCEDURE sp_IssueBook
    @MemberID INT,
    @BookID INT,
    @DueDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare variables
    DECLARE @BookAvailable BIT;
    DECLARE @HasOverdue INT;

    -- Check if the book exists and is available
    SELECT @BookAvailable = IsAvailable
    FROM Book
    WHERE BookID = @BookID;

    IF @BookAvailable IS NULL
    BEGIN
        PRINT 'Error: Book does not exist.';
        RETURN;
    END

    IF @BookAvailable = 0
    BEGIN
        PRINT 'Error: Book is not available for loan.';
        RETURN;
    END

    -- Check if member has any overdue loans
    SELECT @HasOverdue = COUNT(*)
    FROM Loan_table
    WHERE MemberID = @MemberID
      AND Status = 'Overdue';

    IF @HasOverdue > 0
    BEGIN
        PRINT 'Error: Member has overdue loans. Cannot issue new book.';
        RETURN;
    END

    -- Issue the book (create a new loan)
    INSERT INTO Loan_table (MemberID, BookID, LoanDate, DueDate, Status)
    VALUES (@MemberID, @BookID, CAST(GETDATE() AS DATE), @DueDate, 'Issued');

    -- Update book availability
    UPDATE Book
    SET I

	EXEC sp_IssueBook @MemberID = 2, @BookID = 5, @DueDate = '2025-12-15';

	---

	SELECT @BookAvailable = IsAvailable
FROM Book
WHERE BookID = @BookID;

SELECT BookID, Title, IsAvailable FROM Book;
EXEC sp_IssueBook @MemberID = 2, @BookID = 5, @DueDate = '2026-01-15';
SELECT * FROM Loan_table WHERE MemberID = 2;
SELECT BookID, Title, IsAvailable FROM Book WHERE BookID = 5;
------------

-- Check Book availability
SELECT BookID, Title, IsAvailable 
FROM Book
WHERE BookID = 5;

-- Check current loans
SELECT * 
FROM Loan_table
WHERE BookID = 5 OR MemberID = 2;

EXEC sp_IssueBook 
    @MemberID = 2, 
    @BookID = 5, 
    @DueDate = '2022-05-20';

	Book issued successfully to MemberID 2. LoanID: X;

	-- Check Book availability again
SELECT BookID, Title, IsAvailable 
FROM Book
WHERE BookID = 5;

-- Check updated Loan table
SELECT * 
FROM Loan_table
WHERE BookID = 5 OR MemberID = 2;

-------- 17- sp_ReturnBook ----

----Before returning the book---

-- Check the Loan table
SELECT LoanID, MemberID, BookID, LoanDate, DueDate, ReturnDate, Status
FROM Loan_table
WHERE LoanID = 3;

-- Check the Book table
SELECT BookID, Title, IsAvailable
FROM Book
WHERE BookID = (SELECT BookID FROM Loan_table WHERE LoanID = 3);

-- Check Payment table for existing payments
SELECT * FROM Payment
WHERE LoanID = 3;


---Expected output message-----

---- Execute stored procedure----
EXEC sp_ReturnBook
    @LoanID = 3,
    @ReturnDate = '2025-12-30';

	Return processed successfully. Total fine: 20

	----- After returning the book ----

	-- Check the Loan table
SELECT LoanID, MemberID, BookID, LoanDate, DueDate, ReturnDate, Status
FROM Loan_table
WHERE LoanID = 3;

-- Check the Book table
SELECT BookID, Title, IsAvailable
FROM Book
WHERE BookID = (SELECT BookID FROM Loan_table WHERE LoanID = 3);

-- Check Payment table for new payment
SELECT * FROM Payment
WHERE LoanID = 3;

--------- 18 sp_GetMemberReport ------


CREATE PROCEDURE sp_GetMemberReport
    @MemberID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- 1. Member Basic Info
    SELECT MemberID, FullName, Email, PhoneNumber, MembershipStartDate
    FROM MEMBER_TABLE
    WHERE MemberID = @MemberID;
    
    -- 2. Current loans (status Issued or Overdue)
    SELECT L.LoanID, B.Title, L.LoanDate, L.DueDate, L.Status
    FROM Loan_table L
    JOIN Book B ON L.BookID = B.BookID
    WHERE L.MemberID = @MemberID AND L.Status IN ('Issued', 'Overdue');
    
    -- 3. Loan History with Return status
    SELECT L.LoanID, B.Title, L.LoanDate, L.DueDate, L.ReturnDate, L.Status
    FROM Loan_table L
    JOIN Book B ON L.BookID = B.BookID
    WHERE L.MemberID = @MemberID;
    
    -- 4. Total fines paid and pending
    SELECT
        SUM(CASE WHEN P.Method != 'Pending' THEN P.Amount ELSE 0 END) AS TotalFinesPaid,
        SUM(CASE WHEN P.Method = 'Pending' THEN P.Amount ELSE 0 END) AS TotalFinesPending
    FROM Loan_table L
    LEFT JOIN Payment P ON L.LoanID = P.LoanID
    WHERE L.MemberID = @MemberID;
    
    -- 5. Reviews by member
    SELECT R.ReviewID, B.Title, R.Rating, R.Comments, R.ReviewDate
    FROM Review R
    JOIN Book B ON R.BookID = B.BookID
    WHERE R.MemberID = @MemberID;
END;

EXEC sp_GetMemberReport @MemberID = 1;



----------19. sp_MonthlyLibraryReport --------

CREATE PROCEDURE sp_MonthlyLibraryReport
    @LibraryID INT,
    @Month INT,
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @StartDate DATE = DATEFROMPARTS(@Year, @Month, 1);
    DECLARE @EndDate DATE = EOMONTH(@StartDate);
    
    -- Total loans issued in that month
    SELECT COUNT(*) AS TotalLoansIssued
    FROM Loan_table L
    JOIN Book B ON L.BookID = B.BookID
    WHERE B.LibraryID = @LibraryID
      AND L.LoanDate BETWEEN @StartDate AND @EndDate;
    
    -- Total books returned in that month
    SELECT COUNT(*) AS TotalBooksReturned
    FROM Loan_table L
    JOIN Book B ON L.BookID = B.BookID
    WHERE B.LibraryID = @LibraryID
      AND L.ReturnDate BETWEEN @StartDate AND @EndDate;
    
    -- Total revenue collected in that month
    SELECT ISNULL(SUM(P.Amount), 0) AS TotalRevenue
    FROM Payment P
    JOIN Loan_table L ON P.LoanID = L.LoanID
    JOIN Book B ON L.BookID = B.BookID
    WHERE B.LibraryID = @LibraryID
      AND P.PaymentDate BETWEEN @StartDate AND @EndDate
      AND P.Method != 'Pending';
    
    -- Most borrowed genre in that month
    SELECT TOP 1 B.Genre, COUNT(*) AS BorrowCount
    FROM Loan_table L
    JOIN Book B ON L.BookID = B.BookID
    WHERE B.LibraryID = @LibraryID
      AND L.LoanDate BETWEEN @StartDate AND @EndDate
    GROUP BY B.Genre
    ORDER BY BorrowCount DESC;
    
    -- Top 3 most active members by number of loans in that month
    SELECT TOP 3 M.MemberID, M.FullName, COUNT(*) AS LoanCount
    FROM Loan_table L
    JOIN Book B ON L.BookID = B.BookID
    JOIN MEMBER_TABLE M ON L.MemberID = M.MemberID
    WHERE B.LibraryID = @LibraryID
      AND L.LoanDate BETWEEN @StartDate AND @EndDate
    GROUP BY M.MemberID, M.FullName
    ORDER BY LoanCount DESC;
END;

EXEC sp_MonthlyLibraryReport @LibraryID = 1, @Month = 12, @Year = 2025;



-----

----17--
