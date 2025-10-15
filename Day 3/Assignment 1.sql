-- Create the Dept table
CREATE TABLE Dept (
    Deptno INT PRIMARY KEY,
    Dname VARCHAR2(50),
    Loc VARCHAR2(50)
);

-- Create the Emps table
CREATE TABLE Emps (
    Empno INT PRIMARY KEY,
    Ename VARCHAR(50),
    Job VARCHAR(50),
    Sal DECIMAL(10, 2),
    Deptno INT,
    CONSTRAINT FK_A FOREIGN KEY (Deptno) REFERENCES Dept(Deptno)
);

-- Insert data into the Dept table
INSERT INTO Dept (Deptno, Dname, Loc) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

-- Insert data into the Emps table
INSERT INTO Emps (Empno, Ename, Job, Sal, Deptno) VALUES
(7369, 'SMITH', 'CLERK', 800.00, 20),
(7499, 'ALLEN', 'SALESMAN', 1600.00, 30),
(7521, 'WARD', 'SALESMAN', 1250.00, 30),
(7566, 'JONES', 'MANAGER', 2975.00, 20),
(7698, 'BLAKE', 'MANAGER', 2850.00, 30),
(7782, 'CLARK', 'MANAGER', 2450.00, 10),
(7788, 'SCOTT', 'ANALYST', 3000.00, 20),
(7839, 'KING', 'PRESIDENT', 5000.00, 10),
(7844, 'TURNER', 'SALESMAN', 1500.00, 30),
(7876, 'ADAMS', 'CLERK', 1100.00, 20),
(7900, 'JAMES', 'CLERK', 950.00, 30),
(7902, 'FORD', 'ANALYST', 3000.00, 20),
(7934, 'MILLER', 'CLERK', 1300.00, 10),
(8000, 'JOHNSON', 'ENGINEER', 2500.00, NULL); -- Employee not assigned to a department


SELECT
    E.Ename,
    D.Dname
FROM
    Emps E
INNER JOIN
    Dept D ON E.Deptno = D.Deptno;

SELECT
    E.Ename,
    E.Job,
    D.Loc
FROM
    Emps E
INNER JOIN
    Dept D ON E.Deptno = D.Deptno;

SELECT
    Ename
FROM
    Emps
WHERE
    Deptno = (SELECT Deptno FROM Dept WHERE Dname = 'SALES');

SELECT
    E.Ename,
    D.Dname,
    D.Loc
FROM
    Dept D
LEFT OUTER JOIN
    Emps E ON D.Deptno = E.Deptno;

SELECT
    E.Ename,
    D.Dname
FROM
    Emps E
FULL OUTER JOIN
    Dept D ON E.Deptno = D.Deptno;

SELECT
    D.Dname,
    SUM(E.Sal) AS Total_Salary
FROM
    Dept D
LEFT JOIN
    Emps E ON D.Deptno = E.Deptno
GROUP BY
    D.Dname;

SELECT
    D.Dname,
    COUNT(E.Empno) AS Number_of_Employees
FROM
    Dept D
INNER JOIN
    Emps E ON D.Deptno = E.Deptno
GROUP BY
    D.Dname
HAVING
    COUNT(E.Empno) > 3;


SELECT
    E.Ename
FROM
    Emps E
INNER JOIN
    Dept D ON E.Deptno = D.Deptno
WHERE
    D.Loc = (SELECT Loc FROM Dept WHERE Dname = 'ACCOUNTING');

SELECT
    D.Dname,
    E.Ename,
    E.Sal
FROM
    Emps E
JOIN
    Dept D ON E.Deptno = D.Deptno
WHERE
    E.Sal = (SELECT MAX(Sal) FROM Emps WHERE Deptno = E.Deptno);


SELECT
    E.Ename,
    E.Sal
FROM
    Emps E
WHERE
    E.Sal > (SELECT AVG(Sal) FROM Emps WHERE Deptno = E.Deptno);

