-- Create the Book table
CREATE TABLE Book (
    ISBN VARCHAR(50) PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(255),
    Publisher VARCHAR(255),
    Year_of_Publication INT,
    Currently_Lent_to INT,
    FOREIGN KEY (Currently_Lent_to) REFERENCES Member(Member_ID)
);

-- Create the Member table
CREATE TABLE Member (
    Member_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Date_of_Birth DATE,
    Address VARCHAR(255),
    Books_Borrowed INT DEFAULT 0,
    CONSTRAINT Check_Books_Borrowed CHECK (Books_Borrowed <= 5)
);

-- Create the Lending_Transaction table with a check constraint for the return period
CREATE TABLE Lending_Transaction (
    Transaction_ID INT PRIMARY KEY,
    Member_ID INT,
    ISBN VARCHAR(50),
    Date_of_Lending DATE,
    Date_of_Return DATE,
    Condition_At_Return VARCHAR(255),
    FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID),
    FOREIGN KEY (ISBN) REFERENCES Book(ISBN),
    CONSTRAINT CHK_Return_Period CHECK (
        Date_of_Return >= Date_of_Lending 
        AND Date_of_Return <= Date_of_Lending + INTERVAL 30 DAY  -- Adjust the interval as needed
    )
);

-- Sample data for the Book table
INSERT INTO Book (ISBN, Title, Author, Publisher, Year_of_Publication, Currently_Lent_to)
VALUES
    ('978-9792765053', 'Laskar Pelangi', 'Andrea Hirata', 'Bentang Pustaka', 2005, NULL),
    ('978-9792765640', 'Sang Pemimpi', 'Andrea Hirata', 'Bentang Pustaka', 2006, NULL),
    ('978-9799103996', 'Ayat-Ayat Cinta', 'Habiburrahman El Shirazy', 'Republika', 2004, NULL),
    ('978-6020308030', 'Bumi Manusia', 'Pramoedya Ananta Toer', 'Hasta Mitra', 1980, NULL),
    ('978-9799349650', 'Dilan 1990', 'Pidi Baiq', 'Pastel Books', 2013, NULL);

-- Sample data for the Member table
INSERT INTO Member (Member_ID, First_Name, Last_Name, Date_of_Birth, Address, Books_Borrowed)
VALUES
    (1, 'Agus', 'Santoso', '1985-03-20', 'Jl. Jendral Sudirman No. 123, Jakarta', 0),
    (2, 'Rini', 'Wijaya', '1990-07-15', 'Jl. Pahlawan No. 45, Surabaya', 0),
    (3, 'Budi', 'Hartono', '1982-12-05', 'Jl. Gatot Subroto No. 67, Bandung', 0);

INSERT INTO Lending_Transaction (Transaction_ID, Member_ID, ISBN, Date_of_Lending, Date_of_Return, Condition_At_Return)
VALUES
    (1, 1, '978-9792765053', '2023-11-01', '2023-11-06', 'Good'),
    (2, 2, '978-9792765640', '2023-11-02', '2023-11-07', 'Excellent'),
    (3, 3, '978-9799103996', '2023-11-03', '2023-11-08', 'Acceptable'),
    (4, 1, '978-6020308030', '2023-11-04', '2023-11-09', 'Good'),
    (5, 2, '978-9799349650', '2023-11-05', '2023-11-10', 'Excellent'),
    (6, 3, '978-9792765053', '2023-11-06', '2023-11-11', 'Acceptable'),
    (7, 1, '978-9792765640', '2023-11-07', '2023-11-12', 'Good'),
    (8, 2, '978-9799103996', '2023-11-08', '2023-11-13', 'Excellent'),
    (9, 3, '978-6020308030', '2023-11-09', '2023-11-14', 'Acceptable'),
    (10, 1, '978-9799349650', '2023-11-10', '2023-11-15', 'Good'),
    (11, 2, '978-9792765053', '2023-11-11', '2023-11-16', 'Excellent'),
    (12, 3, '978-9792765640', '2023-11-12', '2023-11-17', 'Acceptable'),
    (13, 1, '978-9799103996', '2023-11-13', '2023-11-18', 'Good'),
    (14, 2, '978-6020308030', '2023-11-14', '2023-11-19', 'Excellent'),
    (15, 3, '978-9799349650', '2023-11-15', '2023-11-20', 'Acceptable'),
    (16, 1, '978-9792765053', '2023-11-16', '2023-11-21', 'Good'),
    (17, 2, '978-9792765640', '2023-11-17', '2023-11-22', 'Excellent'),
    (18, 3, '978-9799103996', '2023-11-18', '2023-11-23', 'Acceptable'),
    (19, 1, '978-6020308030', '2023-11-19', '2023-11-24', 'Good'),
    (20, 2, '978-9799349650', '2023-11-20', '2023-11-25', 'Excellent');

-- Question 1: List the titles of books borrowed by a member (identified by a specific Member_ID).
SELECT Book.Title
FROM Lending_Transaction
JOIN Book ON Lending_Transaction.ISBN = Book.ISBN
WHERE Lending_Transaction.Member_ID = your_member_id;

-- Question 2: Find out the members who have borrowed books but have not returned yet.
SELECT DISTINCT Member.Member_ID, Member.First_Name, Member.Last_Name
FROM Member
INNER JOIN Lending_Transaction ON Member.Member_ID = Lending_Transaction.Member_ID
WHERE Lending_Transaction.Date_of_Return IS NULL;


-- Question 3: Find out the total number of books borrowed by a member (identified by a specific Member_ID).
SELECT Member.Member_ID, Member.First_Name, Member.Last_Name, COUNT(Lending_Transaction.ISBN) AS Total_Borrowed
FROM Member
LEFT JOIN Lending_Transaction ON Member.Member_ID = Lending_Transaction.Member_ID
WHERE Member.Member_ID = your_member_id
GROUP BY Member.Member_ID, Member.First_Name, Member.Last_Name;


-- Question 4: List the books which were not returned in good condition.
SELECT Book.Title, Lending_Transaction.Condition_At_Return
FROM Lending_Transaction
JOIN Book ON Lending_Transaction.ISBN = Book.ISBN
WHERE Lending_Transaction.Condition_At_Return <> 'Good' AND Lending_Transaction.Condition_At_Return <> 'Excellent';

-- Question 5: Identify members who have borrowed more than one book at a time.
SELECT Member_ID, First_Name, Last_Name
FROM (
    SELECT Member_ID, COUNT(ISBN) AS BorrowedBooks
    FROM Lending_Transaction
    GROUP BY Member_ID
) AS BorrowedBooksCount
JOIN Member ON BorrowedBooksCount.Member_ID = Member.Member_ID
WHERE BorrowedBooksCount.BorrowedBooks > 1;
