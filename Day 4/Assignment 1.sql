--Assignment 1 - Calculate Simple Interest
DECLARE
    P NUMBER;
    R NUMBER;
    T NUMBER;
    SI NUMBER;
BEGIN  
    P:=1000;
    R:=5;
    T:=5;
    SI:=(P*R*T)/100;
    DBMS_OUTPUT.PUT_LINE('SI is:'|| SI);
END;

--Assignment 2 - Employee Bonus Collection
DECLARE
    salary NUMBER;
    bonus NUMBER;
    emp_name VARCHAR(20);
BEGIN
    emp_name:='Ambar';
    salary:=60000;
    IF salary > 50000 THEN
        bonus:=salary*0.1;
        salary:=salary+bonus;
    ELSE
        bonus:=salary*0.15;
        salary:=salary+bonus;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Bonus is ' || bonus || 'Emp name is ' || emp_name || ' salary is ' || salary);
END;

--Assignment 3 - Retrieve and Display Department Details
DECLARE 
    vdept Dept%ROWTYPE;
    did NUMBER;
BEGIN
    did:=20;
    SELECT * INTO vdept FROM dept WHERE dept_no=did;
    DBMS_OUTPUT.PUT_LINE(vdept.loc ||' ' || vdept.Dname);
END;

--Assignment 4 - Student Marks Management
DECLARE
    TYPE student IS TABLE OF NUMBER INDEX BY VARCHAR2(20);
    stu student;
    skey VARCHAR2(20);
    ag NUMBER;
    total NUMBER;
BEGIN
    stu('John'):=30;
    stu('Jack'):=40;
    stu('Mahesh'):=50;
    stu('Ramesh'):=25;
    stu('Suresh'):=20;
    skey:=stu.FIRST;
    total:=0;
    WHILE skey IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE(skey || '->' || stu(skey));
        total:=total+stu(skey);
        skey:=stu.NEXT(skey);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Total Marks is ' || total);
    DBMS_OUTPUT.PUT_LINE('Average Marks is ' || total/stu.count);
END;

--Assignment 5 - Country-Capital Lookup
DECLARE
    TYPE country IS TABLE OF VARCHAR2(50) INDEX BY VARCHAR2(50);
    cnt country;
    cap VARCHAR2(50);
BEGIN
    cnt('India'):='New Delhi';
    cnt('USA'):='Washington DC';
    cnt('Sri Lanka'):='Colombo';
    cnt('New Zealand'):='Wellington';
    cnt('Germany'):='Berlin';
    cnt('Ireland'):='Dublin';
    DBMS_OUTPUT.PUT_LINE('Enter the Country Name:');
    SELECT '&cap' INTO cap FROM DUAL;
    DBMS_OUTPUT.PUT_LINE('The capital of ' || cap || ' is ' || cnt(cap));
END;
