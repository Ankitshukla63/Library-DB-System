create database library_management_system;
use library_management_system;

CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
-- Categories Table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);
-- Books Table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INT,
    category_id INT,
    availability BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);
-- Members Table
CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact VARCHAR(15)
);
-- Issued Books Table
CREATE TABLE Issued_Books (
    issue_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    issue_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);
-- Insert Authors
INSERT INTO Authors VALUES (1, 'J.K. Rowling'), (2, 'George Orwell');
-- Insert Categories
INSERT INTO Categories VALUES (1, 'Fiction'), (2, 'Science');
-- Insert Books
INSERT INTO Books VALUES 
(101, 'Harry Potter', 1, 1, TRUE),
(102, '1984', 2, 1, TRUE),
(103, 'Animal Farm', 2, 1, FALSE);
-- Insert Members
INSERT INTO Members VALUES 
(201, 'Ankit Sharma', '9876543210'),
(202, 'Riya Verma', '8765432109');
-- Insert Issued Books
INSERT INTO Issued_Books VALUES 
(1, 103, 201, '2025-07-25', '2025-08-10');



SELECT * FROM Books;


-- List all issued books with member name
SELECT IB.issue_id, B.title, M.name AS member_name, IB.issue_date, IB.return_date
FROM Issued_Books IB
JOIN Books B ON IB.book_id = B.book_id
JOIN Members M ON IB.member_id = M.member_id;


-- Show overdue books
SELECT B.title, M.name, IB.return_date
FROM Issued_Books IB
JOIN Books B ON IB.book_id = B.book_id
JOIN Members M ON IB.member_id = M.member_id
WHERE IB.return_date < CURRENT_DATE;


-- Count books per category
SELECT C.name, COUNT(*) AS total_books
FROM Books B
JOIN Categories C ON B.category_id = C.category_id
GROUP BY C.name;