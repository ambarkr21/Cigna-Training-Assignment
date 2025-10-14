--1. List books with exactly one available copy 
SELECT Book_ID, Title
FROM Books
WHERE Available_Copies = 1;

--2. List authors where names start with a specific letter (Ex: J)
SELECT Author_Name
FROM Authors
WHERE Author_Name LIKE 'J%';

--3. List memebers with no address recorded
SELECT Member_Name
FROM Members
WHERE Address IS NULL;

--4. List borrowings with a specific borrow date
SELECT *
FROM Borrowings 
WHERE Borrow_Date = TO_DATE('2025-10-01','YYYY-MM-DD');

--5. List Books with a publishing year after 2000
SELECT Title
FROM Books
WHERE Publication_Year > 2000;

--6. List borrowings with no fines
SELECT *
FROM Borrowings
WHERE Fine = 0;

--7. List members sorted by membership date in descending order
SELECT *
FROM Members
ORDER BY Membership_Date DESC;

--8. Count total number of authors
SELECT COUNT(Author_ID)
FROM Authors;

--9. List books with title containing a specific word (Ex: 'Potter')
SELECT Title
FROM Books
WHERE Title LIKE '%Potter%';

--10. List borrowings returned on a specific borrow date
SELECT * 
FROM Borrowings
WHERE Return_Date = TO_DATE('2025-10-14','YYYY-M-DD');

--11.List members with a specific area code in their phone number (Ex: '111')
SELECT Member_Name
FROM Members
WHERE Phone LIKE '111%';

--12. List books sorted by title alphabetically 
SELECT Title
FROM Books
ORDER BY Title ASC;

--13. Sum the total available copies across all books
SELECT SUM(Available_Copies) AS Total_Available_Copies
FROM Books;

--14. List borrowings with a due date in specific month (Ex: October 2025)
SELECT * 
FROM Borrowings
WHERE TO_CHAR(Due_Date, 'YYYY-MM')='2025-10';

--15. List authors with names longer than 10 characters
SELECT Author_Name
FROM Authors
WHERE LENGTH(Author_Name)>10;
