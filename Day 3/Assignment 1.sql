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



