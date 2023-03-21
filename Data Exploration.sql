-- Data Exploration of personal Databases 
-- Skills used: Conditions, Filtering, Creating Tables, Aggregate Functions, CTEs


-- Create two tables

Create Table EmployeeTable
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

CREATE TABLE EmployeeDescription 
(EmployeeID int, 
JobTitle varchar(50),
Salary int, 
Hire_date int
)

-- Insert into Tables values

Insert into EmployeeDescription VALUES
(01, 'Teacher', 30400, 1991),
(02, 'Fireman', 25900, 1991),
(03, 'Waiter', 29200, 1991),
(04, 'Dogsitter', 31100, 1991),
(05, 'Translator', 72000, 1991),
(06, 'Architect', 65100, 1992),
(07, 'Recruiter', 14300, 1992),
(08, 'Bank Teller', 3800, 1991),
(09, 'Yoga Instructor', 31300, 1900)

Insert into EmployeeTable VALUES
(01, 'Jonas', 'Smith', 30, 'Male'),
(02, 'Elison', 'Johnson', 30, 'Female'),
(03, 'Frank', 'Williams', 29, 'Male'),
(04, 'Adelyn', 'Martin', 31, 'Female'),
(05, 'Mari', 'Garcia', 32, 'Male'),
(06, 'Peter', 'Scott', 35, 'Male'),
(07, 'Isabel', 'Palmer', 32, 'Female'),
(08, 'Made', 'Jones', 38, 'Male'),
(09, 'Tony', 'Davis', 31, 'Male')



-- Select all columns of both tables 

SELECT*
FROM EmployeeDescription

SELECT*
FROM EmployeeTable

-- Pull out the Employee whose JobTitle is 'Fireman'

SELECT JobTitle, Salary, EmployeeID 
FROM EmployeeDescription
WHERE JobTitle ='Fireman'

-- Show the name of the Employee with ID nr. 2

SELECT FirstName, LastName
FROM EmployeeTable
WHERE EmployeeID = 2


--Merge FirstName and LastName together 

SELECT FirstName + ' ' + LastName AS FullName 
FROM EmployeeTable 



-- Get all employees with salary < 30000

SELECT * 
FROM EmployeeDescription
WHERE Salary < 30000

-- Get all employees except the employee with salary = 30400

SELECT * 
FROM EmployeeDescription
WHERE Salary != 30400

-- Insert a new row into the table EmployeeDescription

INSERT INTO EmployeeDescription
VALUES 
('09', 'Yoga Instructor', '31300', '1900')

-- Check if the row has been inserted

SELECT *
FROM EmployeeDescription
WHERE JobTitle='Yoga Instructor'


-- Pull out the first 3 rows of the table EmployeeDescription

SELECT TOP 3 * 
FROM EmployeeDescription

-- The number of Employees based on the FirstName 

SELECT COUNT (FirstName) AS Name 
FROM EmployeeTable

-- Get the highest paid employee and the average salary

SELECT MAX (Salary) AS Highest_Paid_Employee
FROM EmployeeDescription

SELECT AVG(Salary) AS avg_salary 
FROM EmployeeDescription

-- Get the employee whose JobTitle is Teacher and his Salary equals 30400

SELECT*
FROM EmployeeDescription
WHERE JobTitle = 'Teacher' AND Salary=30400

-- Pull out employees whose JobTitle is Teacher or the ID equals 3
SELECT*
FROM EmployeeDescription
WHERE JobTitle = 'Teacher' OR EmployeeID=3

-- How many Hire_date are there

SELECT COUNT(Hire_date) AS Number_Hire_date
FROM EmployeeDescription


-- How many hire_dates are there for each salary (listing all rows)

SELECT Salary, Hire_Date, COUNT(Hire_date) OVER (PARTITION BY Hire_date) AS Number_Hire_Date
FROM EmployeeDescription

-- List Hire_date without duplicates 

SELECT Hire_date
FROM EmployeeDescription
GROUP BY Hire_date

-- Pull out Hire_date grouped per Gender

SELECT Hire_date,Gender
FROM EmployeeDescription
INNER JOIN EmployeeTable
on EmployeeTable.EmployeeID=EmployeeDescription.EmployeeID
GROUP BY Hire_date,Gender


-- Get all the JobTitles that start with'T'

SELECT *
FROM EmployeeDescription
WHERE JobTitle LIKE 'T%'


-- Get all the rows where FirstName equals Jonas and Elison

SELECT * 
FROM EmployeeTable 
Where FirstName IN ('Jonas', 'Elison')

-- Order by Hire_date in a decreasing order

SELECT* 
FROM EmployeeDescription
ORDER BY 4 DESC 


-- Update he EmployeeDescription table changing the ID 8 whose JobTitle is Bank Teller into 10

UPDATE EmployeeDescription
SET EmployeeID = 10 where JobTitle = 'Bank Teller' 

-- Check if the changes have been applied 

SELECT*
FROM EmployeeDescription
WHERE JobTitle = 'Bank Teller'


-- Remove the spaces from the JobTitle column 

SELECT EmployeeID, TRIM(JobTitle) AS JobTitle_without_space
FROM EmployeeDescription


-- Pull out just the three letter of the columns FirstName and JobTitle 

SELECT SUBSTRING( EmployeeTable.FirstName, 1, 3), SUBSTRING( EmployeeDescription.JobTitle,1,2)
FROM EmployeeDescription
FULL OUTER JOIN EmployeeTable
ON EmployeeDescription.EmployeeID = EmployeeTable.EmployeeID

-- Get the whole FirstName column lowercase

SELECT LOWER(FirstName) AS Lower_Name
FROM EmployeeTable


-- Get the whole FirstName column uppercase

SELECT UPPER(FirstName) AS Upper_Name
FROM EmployeeTable

-- Replace the FirstName of the employee with ID 1 from Jonas into Thomas

Select FirstName, REPLACE(FirstName, 'Jonas', 'Thomas') as FirstNameFixed
FROM EmployeeTable


-- Pull out the average of employees' age 

WITH cte_age 
AS 
(SELECT Age AS List_Age
FROM EmployeeTable)

SELECT 
   AVG(List_Age) AS Avg_Age
FROM cte_age

