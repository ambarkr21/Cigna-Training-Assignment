--Create Table Department
  CREATE TABLE Dept(
  Dept_No NUMBER PRIMARY KEY,
  Dname VARCHAR2(30),
  Loc VARCHAR2(30)
  );
  
--Create Table Employee
CREATE TABLE Emp(
  Emp_No NUMBER PRIMARY KEY,
  Ename VARCHAR2(20),
  Job VARCHAR(30),
  Salary NUMBER(10,2),
  Dept_No NUMBER,
  CONSTRAINT FK_emp FOREIGN KEY (Dept_No) REFERENCES Dept(Dept_No)
  );

--Inserting values to Department
INSERT INTO Dept VALUES(10, 'Accounting', 'BLR');
INSERT INTO Dept VALUES(20, 'RESEARCH', 'HYD');
INSERT INTO Dept VALUES(30, 'Sales', 'DEL');
INSERT INTO Dept VALUES(40, 'Operations', 'MUM');

--Inserting values to Employee
INSERT INTO Emp VALUES(1011, 'Bob', 'Account Manager', 50000, 10);
INSERT INTO Emp VALUES(1012, 'Smith', 'Sales Manager', 30000, 30);
INSERT INTO Emp VALUES(1013, 'Ana', 'Intern', 15000, 20);
INSERT INTO Emp VALUES(1014, 'Dia', 'Operations Manager', 45000, 40);
INSERT INTO Emp VALUES(1015, 'Jane', 'Supply Manager', 40000, 40);
INSERT INTO Emp VALUES(1016, 'Clark', 'Salesman', 18000, 30);
INSERT INTO Emp VALUES(1017, 'Mark', 'Research Lead', 55000, 20);
INSERT INTO Emp VALUES(1018, 'Antony', 'Audit Manager', 55000, 10);
INSERT INTO Emp VALUES(1019, 'Mary', 'Audit Manager', 45000, 10);
INSERT INTO Emp VALUES(1020, 'Marsha', 'Audit Manager', 35000, 10);

---------------------------------------------------------QUERY---------------------------------------------------------------

--1. Display employee names along with their department names.
SELECT E.Ename, D.Dname
FROM Emp E
JOIN Dept D ON E.Dept_No = D.Dept_No;

--2. List all employees with their job titles and the location of their department.
SELECT E.Ename, E.Job, D.Loc
FROM Emp E
JOIN Dept D ON E.Dept_No = D.Dept_No;

--3. Display employees who work in the SALES department.
SELECT E.Ename, E.Job, E.Salary
FROM Emp E
JOIN Dept D ON E.Dept_No = D.Dept_No
WHERE D.Dname = 'SALES';

--4. List all employees along with their department name and location, including departments that have no employees.
SELECT D.Dname, D.Loc, E.Ename, E.Job
FROM Dept D
LEFT JOIN Emp E ON D.Dept_No = E.Dept_No;

--5. Display all departments and employees, even if some employees are not assigned to any department.
SELECT D.Dname, D.Loc, E.Ename, E.Job
FROM Dept D
FULL JOIN Emp E ON D.Dept_No = E.Dept_No;

--6. Show each department name and  total salary paid to its employees.
SELECT D.Dname, SUM(E.Salary) AS Total_Salary
FROM Dept D
JOIN Emp E ON D.Dept_No = E.Dept_No
GROUP BY D.Dname;

--7. Find departments that have more than 3 employees.  Display dname and no. of employees.
SELECT D.Dname, COUNT(E.Emp_No) AS Num_Employees
FROM Dept D
JOIN Emp E ON D.Dept_No = E.Dept_No
GROUP BY D.Dname
HAVING COUNT(E.Emp_No) > 3;

--8. Display employees who work in the same location as the ACCOUNTING department.
SELECT E.Ename, D.Loc
FROM Emp E
JOIN Dept D ON E.Dept_No = D.Dept_No
WHERE D.Loc = (SELECT Loc FROM Dept WHERE Dname = 'Accounting');

--9. For each department, display the employee who has the highest salary.
SELECT E.Ename, E.Salary, D.Dname
FROM Emp E
JOIN Dept D ON E.Dept_No = D.Dept_No
WHERE E.Salary = (
  SELECT MAX(E2. Salary)
  FROM Emp E2
  WHERE E2.Dept_No = E.Dept_No
  );

--10. List employees whose salary is greater than the average salary of their department.
SELECT E.Ename, E.Salary, D.Dname
FROM Emp E
JOIN Dept D ON E.Dept_No - D.Dept_No
WHERE E.Salary > (
  SELECT AVG(E2.Salary)
  FROM Emp E2
  WHERE E2.Dept_No = E.Dept_No
  );

----------------------------------------------------------Check Subquery-----------------------------------------------------
--1. Single-row Subquery
SELECT Ename, Salary 
FROM Emp 
WHERE Salary > (SELECT AVG(Salary) FROM Emp);

--2. Multi-row Subquery
SELECT Ename, Dept_No 
FROM Emp
WHERE Dept_No IN (SELECT Dept_No FROM Dept WHERE Loc= 'MUM');

--3. Multi-column Subquery
SELECT Emp_No, Ename, Job, Dept_No 
FROM Emp
WHERE (Job, Dept_No) IN 
      (SELECT Job, Dept_No FROM Emp WHERE Emp_No = 1018); 

--4. Correlated Subquery
SELECT E.Ename, E.Salary, E.Dept_No 
FROM Emp E 
WHERE E.Salary > (SELECT AVG(Salary) 
FROM Emp
WHERE Dept_No = E.Dept_No); 

--5. In the WHERE Clause
SELECT * 
FROM Emp
WHERE deptno IN (SELECT deptno FROM DEPT WHERE Loc= 'CHICAGO'); 

--6) In the HAVING Claus
 SELECT deptno, AVG(Salary) 
FROM Emp 
GROUP BY deptno 
HAVING AVG(Salary) > (SELECT AVG(Salary) FROM Emp);

--7) In the SELECT Clause
SELECT e.emp_name, 
       (SELECT dept_name FROM DEPT d WHERE d.deptno = e.deptno) AS department 
FROM Emp e;
