1./*Scenario:
 You are a data analyst at City Hospital. Management wants to create a new table to store patient details.
Task:
 Write a SQL command to create a table named Patients with fields (PatientID, PatientName, Age, Gender, AdmissionDate).
Expected Output:**
 A new table Patients is created successfully in the database*/
 
CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;
CREATE TABLE IF NOT EXISTS Patients(
Patient_ID INT,
Patient_Name VARCHAR(100),
Age INT,
Gender VARCHAR(10),
Admission_Date DATE 
);


2./*Scenario:
 Later, the hospital decides to store the doctor assigned to each patient.
Task:
 Write a SQL command to add a new column DoctorAssigned VARCHAR(50) to the Patients table.
Expected Output:
 The Patients table now has an additional column DoctorAssigned.*/
 
 -- ALTER TABLE - ADD COLUMN
ALTER TABLE Patients
ADD COLUMN DoctorAssigned VARCHAR(100);
 
 
3./*Scenario:
 You are creating a database for an online bookstore.
Task:
 Define a primary key for Books(BookID) and a foreign key in Orders(BookID) referencing Books.
Expected Output:
 Constraints are applied successfully.
 
SQL Question 2: UNIQUE Constraint
Scenario:
 Each book must have a unique ISBN.
Task:
 Add a UNIQUE constraint to the ISBN column in Books.
Expected Output:
 ISBN values are enforced as unique.
 
SQL Question 3: DELETE vs TRUNCATE
Scenario:
 The store wants to clear test orders but sometimes preserve structure.
Task:
 Demonstrate DELETE with WHERE clause and TRUNCATE for Orders table.
Expected Output:
 DELETE removes selected rows; TRUNCATE clears all rows quickly. */

CREATE DATABASE IF NOT EXISTS BookstoreDB;
USE BookstoreDB;
CREATE TABLE IF NOT EXISTS Books(
Book_ID INT PRIMARY KEY,
Title VARCHAR(200),
Author VARCHAR(200),
ISBN VARCHAR(20)
);
CREATE TABLE IF NOT EXISTS Orders(
Order_ID INT PRIMARY KEY,
Book_ID INT,
Quatity INT,
Order_Date DATE,
Foreign key (Book_ID) REFERENCES Books(Book_ID)
);

ALTER TABLE Books
ADD CONSTRAINT UNIQUE_ISBN UNIQUE(ISBN);

DELETE FROM Orders
WHERE Order_ID like 'Test%';

TRUNCATE TABLE Orders;

4./* In a university database, you want to list unique departments.
Task:
 Write a SQL query to return distinct department names.
Expected Output:
 Only unique departments are returned.*/
 
CREATE DATABASE IF NOT EXISTS UniversityDB;
USE UniversityDB;
CREATE TABLE Departments(
Department_ID INT,
Department_Name VARCHAR(100)
);
CREATE TABLE IF NOT EXISTS Students(
Student_ID INT Primary key,
Student_Name VARCHAR(20)NOT NULL,
Email VARCHAR(50) ,
Date_of_Birth DATE,
CourseID INT,
GPA DECIMAL(3,2)
);

INSERT INTO Departments
VALUES(101,'Computer Science'),
(102,'Civil Engineering'),
(103,'Mechanical Engineering'),
(104,'Electrical Engineering'),
(105,'Mathematics'),
(106,'Computer Science'),
(107,'Mechanical Engineering');

INSERT INTO Students(Student_ID, Student_Name, Email, Date_of_Birth, CourseID, GPA)
VALUES (101,'Ramesh','ramesh@example.com','2002-05-18',501,3.8),
(102,'Megha','megha@example.com','2001-03-06',502,4.2),
(103,'Renu',NULL ,'2002-08-12',503,4.8),
(104,'Nithun','nithun@example.com','2000-07-10',504,3.6),
(105,'Aishu',NULL,'2000-06-03',505,4.0);

SELECT DISTINCT Department_Name
FROM Departments;

/*Scenario:
 Some students don’t have email addresses recorded.
Task:
 Write queries to find students with NULL and NOT NULL emails.
Expected Output:
 The queries return correct subsets of students.*/
 
SELECT * FROM Students
WHERE Email is NULL;
SELECT * FROM Students
WHERE Email is not null;

/*SQL Question 3: IN, BETWEEN, NOT BETWEEN
Scenario:
 Filter students enrolled in specific courses or within certain GPA ranges.
Task:
 Write queries using IN, BETWEEN, and NOT BETWEEN operators.
Expected Output:
 Correct sets of students are returned*/
 
SELECT Student_ID, Student_Name, CourseID
FROM Students
WHERE CourseID IN (501,502,505);

SELECT Student_ID, Student_Name, GPA
FROM Students 
WHERE GPA BETWEEN 3.0 AND 4.5;

SELECT Student_ID, Student_Name, GPA
FROM Students 
WHERE GPA NOT BETWEEN 2.0 AND 3.5;


5./*Scenario:
 In an e-commerce system, show the top 3 highest-priced products.
Task:
 Write a SQL query using ORDER BY and LIMIT.
Expected Output:
 Top 3 products by price are displayed.*/
 
CREATE DATABASE IF NOT EXISTS ECommerceDB;
USE ECommerceDB;
CREATE TABLE IF NOT EXISTS Products(
Product_ID INT PRIMARY KEY,
Product_Name VARCHAR(100),
Price DECIMAL(10,2)
);

INSERT INTO Products (Product_ID, Product_Name, Price)
VALUES (1,'Smartwatch',20000.00),
(2,'Smartphone',70000.00),
(3,'Laptop',60000.00),
(4,'wireless Charger',5000.00),
(5,'Computer Accesorries',15000.00);

SELECT * FROM Products
ORDER BY Price DESC
LIMIT 3;

/*Aggregate Functions
Scenario:
 Management wants statistics of sales data.
Task:
 Write queries using COUNT, SUM, AVG, MAX, MIN on Sales table.
Expected Output:
 Aggregated results are returned.*/
 
CREATE TABLE Sales(
Sale_ID INT PRIMARY KEY,
Product_ID INT,
Price DECIMAL(10,2));

INSERT INTO Sales (Sale_ID, Product_ID, Price)
VALUES(101, 1, 20000.00),
(102, 2, 70000.00),
(103, 3, 6000.00),
(104, 4, 5000.00),
(105, 5, 15000.00);

SELECT COUNT(*) AS Totalsales,
SUM(Price) AS Totalrevenue,
AVG(Price) AS Averagesale,
MAX(Price) AS Highestsale,
MIN(Price) AS Lowestsale
FROM Sales;

/*Scenario:
 Find departments with more than 10 employees.
Task:
 Write a query using GROUP BY and HAVING.
Expected Output:
 Only departments with >10 employees are returned.*/

SELECT Department_ID, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Department_ID
HAVING COUNT(*) > 10;

6./*Scenario:
 Show students with their enrolled course names.
Task:
 Write a query joining Students and Courses.
Expected Output:
 Results include only students with valid enrollments.
 
SQL Question 2: LEFT & RIGHT JOIN
Scenario:
 List all students and their courses, including those without matches.
Task:
 Use LEFT JOIN and RIGHT JOIN between Students and Enrollments.
Expected Output:
 All students/courses are shown with NULLs where no match exists.*/


CREATE DATABASE IF NOT EXISTS SchoolDB;
USE SchoolDB;
CREATE TABLE Students(
Student_ID INT,
Student_Name VARCHAR(20));
CREATE TABLE Enrollments(
Student_ID INT,
Course_ID INT);
CREATE TABLE Courses(
Course_ID INT,
Course_Name VARCHAR(100));

INSERT INTO Students(Student_ID,Student_Name)
VALUES(1,'Ragul'),
(2,'Hema'),
(3,'Bhargav'),
(4,'joyce'),
(5,'Moha');

INSERT INTO Enrollments(Student_ID,Course_ID)
VALUES(1,101),
(2,102),
(3,103);

INSERT INTO Courses(Course_ID,Course_Name)
VALUES(101,'Science'),
(102,'Mathematics'),
(103,'Physics');

SELECT S.Student_Name ,C.Course_Name
FROM Students S
INNER JOIN Enrollments E ON S.Student_ID=E.Student_ID
INNER JOIN Courses C ON E.Course_ID=C.Course_ID;

SELECT S.Student_Name ,C.Course_Name
FROM Students S
LEFT JOIN Enrollments E ON S.Student_ID=E.Student_ID
LEFT JOIN Courses C ON E.Course_ID=C.Course_ID;

SELECT S.Student_Name ,C.Course_Name
FROM Students S
RIGHT JOIN Enrollments E ON S.Student_ID=E.Student_ID
RIGHT JOIN Courses C ON E.Course_ID=C.Course_ID;


/*Scenario:
 Combine lists of current and past employees.
Task:
 Write queries demonstrating UNION and UNION ALL.
Expected Output:
 UNION removes duplicates, UNION ALL keeps all rows.*/
 
 CREATE TABLE CurrentEmployees(
 Employee_ID INT,
 Employee_Name VARCHAR(100));
 
 CREATE TABLE PastEmployees(
 Employee_ID INT,
 Employee_Name VARCHAR(100));
 
 INSERT INTO CurrentEmployees(Employee_ID,Employee_Name)
 VALUES(1,'Samson'),
 (2,'Rohit'),
 (3,'Jaddu');
 
SELECT Employee_ID,Employee_Name FROM CurrentEmployees
UNION
SELECT Employee_ID,Employee_Name FROM PastEmployees;

SELECT Employee_ID,Employee_Name FROM CurrentEmployees
UNION ALL
SELECT Employee_ID,Employee_Name FROM PastEmployees;

--------------------------------------------------------------------------------------------

7./* Scenario:
 Clean up employee names for reporting.
Task:
 Write queries using UPPER, LOWER, SUBSTRING, CONCAT.
Expected Output:
 Formatted name outputs are displayed.*/
 
 CREATE TABLE Employees(
 Employee_ID INT,
 First_Name varchar(20),
 Last_Name VARCHAR(20),
 Join_of_date DATE);
 
 INSERT INTO Employees(Employee_ID,First_Name,Last_Name,Join_of_date)
 VALUES(1,'prem','kumar','2015-03-18'),
 (2,'john','smith','2018-02-16'),
 (3,'samson','sanjai','2025-05-10');
 
SELECT  Employee_ID,
UPPER(First_name) AS first_name_upper,
LOWER(Last_name) AS last_name_lower,
SUBSTRING(First_name, 1, 3) AS First_name_prefix,
CONCAT(First_name, ' ', Last_name) AS Full_name
FROM Employees;

 

/*SQL Question 2: Date Functions
Scenario:
 Calculate employee tenure in years.
Task:
 Use DATE functions like YEAR(), DATEDIFF(), NOW().
Expected Output:
 Employee tenure is calculated correctly.*/

SELECT Employee_ID,First_Name,Last_Name,Join_of_date,
DATEDIFF(NOW(), join_of_date) / 365 AS tenure_years
FROM Employees;

/*SQL Question 3: User-defined Function
Scenario:
 Create a reusable function to return full name of a student.
Task:
 Write and test a UDF combining FirstName + LastName.
Expected Output:
 Full name is returned when function is called.*/

DELIMITER //
CREATE FUNCTION GetFullName (First_Name VARCHAR(20), Last_Name VARCHAR(20))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN CONCAT(First_Name, ' ',Last_Name);
END //
DELIMITER ;

8./*Scenario:
 HR wants a quick way to fetch employee details by ID.
Task:
 Create a stored procedure accepting EmployeeID as input.
Expected Output:
 Employee details are returned when procedure is executed.*/
 
 DELIMITER //
 CREATE PROCEDURE GetEmployeedetails(IN emp_id INT)
 BEGIN
 SELECT * FROM Employees
 WHERE Employee_ID = emp_id;
 END //
 DELIMITER ;
 
 CALL GetEmployeedetails(1);
 
 
/*SQL Question 2: Simple View
Scenario:
 Management wants a view for employee name and department.
Task:
 Write a CREATE VIEW statement.
Expected Output:
 A new view is created successfully.*/
 
 CREATE VIEW EmployeeDepartmentView AS
 SELECT
 E.Employee_ID,
 E.Employee_Name,
 D.Department_Name
 FROM Employees E
JOIN Departments D ON E.Department_ID=D.Department_ID; 


/*SQL Question 3: Complex View
Scenario:
 Create a view joining Employees, Departments, and Salaries.
Task:
 Write SQL to define a complex view with multiple joins.
Expected Output:
 The view returns combined data from all three tables.
drop your answers here also update in your SQL script*/

CREATE VIEW FullEmployeedetails AS 
SELECT
E.Employee_ID,
E.Employee_Name,
D.Department_Name,
S.Salary
FROM Employee E
JOIN Departments D ON E.Deaprtment_ID=D.Deaprtment_ID
JOIN Salary S ON E.Employee_ID=S.Employee_ID;

9./*SQL Question 1: Trigger
Scenario:
 Log every deletion in the Orders table.
Task:
 Write a trigger to insert deleted rows into Order_History.
Expected Output:
 Deleted records are logged automatically.*/
 
 CREATE TABLE Employees(
 Employee_ID INT,
 Employee_Name VARCHAR(20),
 Department_ID INT);
 
 CREATE TABLE Departments(
 Department_ID INT,
 Deaprtment_Name VARCHAR(100));


CREATE TABLE Salaries(
Employee_ID INT,
SalaryAmount DECIMAL(10,2)); 

CREATE TABLE Orders(
Order_ID INT,
Customer_ID INT,
Order_Date DATE);

CREATE TABLE Order_History(
Order_ID INT,
Customer_ID INT,
Order_Date DATE,
DeletedAT DATETIME
); 


DELIMITER //
CREATE TRIGGER trg_LogOrderDeletion
AFTER DELETE ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Order_History (Order_ID, Customer_ID, Order_Date, DeletedAt)
    VALUES (OLD.Order_ID, OLD.Customer_ID, OLD.Order_Date, NOW());
END //
DELIMITER ;
 
 
/*SQL Question 2: DCL Commands
Scenario:
 Grant reporting access to junior analysts.
Task:
 Write SQL using GRANT and REVOKE commands.
Expected Output:
 User privileges are updated accordingly.*/

-- Grant SELECT access on reports to junior analysts
GRANT SELECT ON Reports TO 'junior_analyst'@'localhost';

-- Revoke access if needed
REVOKE SELECT ON Reports FROM 'junior_analyst'@'localhost';
 

 
/*SQL Question 3: TCL Commands
Scenario:
 During a bank transfer, ensure atomicity.
Task:
 Write SQL using COMMIT, ROLLBACK, SAVEPOINT.
Expected Output:
 Transaction integrity is maintained.
Drop your answers here
also make it in your script*/

CREATE TABLE Reports(
Report_ID INT,
Title VARCHAR(100));

CREATE TABLE Accounts(
Account_ID INT,
Account_Holder VARCHAR(20),
Balance DECIMAL(10,2));

INSERT INTO Accounts(Account_ID,Account_Holder,Balance)
VALUES(123,'suresh',10000.00),
(456,'loki',5000.00);

START TRANSACTION;
UPDATE Accounts
SET Balance=Balance - 200
WHERE Account_ID=456;

UPDATE Accounts
SET Balance=Balance + 4000
WHERE Account_ID=123;

SAVEPOINT Step1;

SELECT * FROM Accounts;

ROLLBACK TO Step1;

COMMIT;








