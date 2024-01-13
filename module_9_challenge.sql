--Module 9 Challenge

----------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------- 

--Part 1: creating tables

----------------------------------------------------------------------------------- 

--Table 'departments'
CREATE TABLE departments (
	dept_no VARCHAR(255)
	,dept_name VARCHAR(255)
);
SELECT * FROM departments;

-----------------------------------------------------------------------------------

--Table 'dept_emp'
CREATE TABLE dept_emp (
	emp_no INT 
	,dept_no VARCHAR(255) 
);
SELECT * FROM dept_emp;

----------------------------------------------------------------------------------- 

--Table 'dept_manager'
CREATE TABLE dept_manager (
	dept_no VARCHAR(255) 
	,emp_no INT 
);
SELECT * FROM dept_manager;

----------------------------------------------------------------------------------- 
DROP TABLE employees
--Table 'employees'
CREATE TABLE employees (
	emp_no INT 
	,emp_title_id VARCHAR(255) 
	,birth_date VARCHAR(255)
	,first_name VARCHAR(255)
	,last_name VARCHAR(255)
	,sex VARCHAR(255)
	,hire_date DATE
);
SELECT * FROM employees;

----------------------------------------------------------------------------------- 

--Table 'salaries'
CREATE TABLE salaries (
	emp_no INT
	,salary INT
);
SELECT * FROM salaries;

----------------------------------------------------------------------------------- 

--Table 'titles'
CREATE TABLE titles (
	title_id VARCHAR(255) 
	,title VARCHAR(255)
);
SELECT * FROM titles;

-----------------------------------------------------------------------------------
----------------------------------------------------------------------------------- 

--Part 2: Double checking and understanding imported data

----------------------------------------------------------------------------------- 

SELECT * FROM departments;
-- Department numbers (dept_no) are related to department names (dept_name) such that 
-- the name of the department is correlated with a unique number 
SELECT * FROM dept_emp;
-- Employee numbers (emp_no) are related to department number (dept_no) such that 
-- multiple employee numbers can be tied to a single department number 
SELECT * FROM dept_manager;
-- This table is identifying the managers of a department such that multiple managers
-- can be tied to one department 
SELECT * FROM employees;
-- This table uses employee number (emp_no) as its index, and from that index, we are 
-- given employee data. The title of their position is tied to a unique ID under 
-- emp_title_id
SELECT * FROM salaries;
-- This table takes the employee number (emp_no) and indicates the employee's salary
-- in the column salary
SELECT * FROM titles;
-- This table provides the string employee titles for the title IDs

----------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------- 

--Part 3: Data Analysis 

----------------------------------------------------------------------------------- 

-- 1. List the employee number, last name, first name, sex, and salary of each 
--    employee.
SELECT 
	e.emp_no
	,e.last_name
	,e.first_name
	,e.sex
	,s.salary
FROM employees as e
INNER JOIN salaries as s ON e.emp_no = s.emp_no;

----------------------------------------------------------------------------------- 

-- 2. List the first name, last name, and hire date for the employees who were 
--    hired in 1986.
SELECT
	e.first_name
	,e.last_name
	,e.hire_date
FROM employees as e
WHERE e.hire_date BETWEEN TO_DATE('12/31/1985', 'MM/DD/YYYY') AND TO_DATE('01/01/1987', 'MM/DD/YYYY');

----------------------------------------------------------------------------------- 

-- 3. List the manager of each department along with their department number, 
--    department name, employee number, last name, and first name.
SELECT 
	d.dept_no
	,d.dept_name
	,ma.emp_no
	,e.last_name
	,e.first_name
FROM departments as d
JOIN dept_manager as ma ON (d.dept_no=ma.dept_no) 
JOIN employees as e ON (ma.emp_no=e.emp_no);

----------------------------------------------------------------------------------- 

-- 4. List the department number for each employee along with that employee’s 
--    employee number, last name, first name, and department name.
SELECT
	dem.dept_no
	,e.emp_no
	,e.last_name
	,e.first_name
	,d.dept_name
FROM dept_emp AS dem
JOIN employees AS e ON (dem.emp_no=e.emp_no)
JOIN departments as d ON dem.dept_no = d.dept_no
	
----------------------------------------------------------------------------------- 

-- 5. List first name, last name, and sex of each employee whose first name is 
--    Hercules and whose last name begins with the letter B.





