--Module 9 Challenge

----------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------- 

--Part 1: Table Creation

----------------------------------------------------------------------------------- 

DROP TABLE departments 
--Table 'departments'
CREATE TABLE departments (
	dept_no VARCHAR(255) NOT NULL PRIMARY KEY
	,dept_name VARCHAR(255) NOT NULL UNIQUE
);
SELECT * FROM departments;
----------------------------------------------------------------------------------- 

DROP TABLE titles
--Table 'titles'
CREATE TABLE titles (
	title_id VARCHAR(255) NOT NULL PRIMARY KEY
	,title VARCHAR(255) NOT NULL
);
SELECT * FROM titles;

----------------------------------------------------------------------------------- 

DROP TABLE employees
--Table 'employees'
CREATE TABLE employees (
	emp_no INT NOT NULL PRIMARY KEY
	,emp_title_id VARCHAR(255) NOT NULL REFERENCES titles(title_id)
	,birth_date VARCHAR(255) NOT NULL
	,first_name VARCHAR(255) NOT NULL
	,last_name VARCHAR(255) NOT NULL
	,sex VARCHAR(255) NOT NULL
	,hire_date DATE NOT NULL
	,FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);
SELECT * FROM employees;

-----------------------------------------------------------------------------------

DROP TABLE dept_emp
--Table 'dept_emp'
CREATE TABLE dept_emp (
	emp_no INT NOT NULL
	,dept_no VARCHAR(255) NOT NULL
	,PRIMARY KEY (emp_no, dept_no)
	,FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	,FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);
SELECT * FROM dept_emp;

----------------------------------------------------------------------------------- 

DROP TABLE dept_manager
--Table 'dept_manager'
CREATE TABLE dept_manager (
	dept_no VARCHAR(255) NOT NULL
	,emp_no INT NOT NULL
	,PRIMARY KEY (dept_no, emp_no)
    ,FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
    ,FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
SELECT * FROM dept_manager;

----------------------------------------------------------------------------------- 

DROP TABLE salaries
--Table 'salaries'
CREATE TABLE salaries (
	emp_no INT NOT NULL
	,salary INT NOT NULL
	,FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
SELECT * FROM salaries;

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
JOIN departments as d ON dem.dept_no = d.dept_no;
	
----------------------------------------------------------------------------------- 

-- 5. List first name, last name, and sex of each employee whose first name is 
--    Hercules and whose last name begins with the letter B.
SELECT
	e.first_name
	,e.last_name
	,e.sex
FROM employees as e
WHERE e.first_name = 'Hercules' and e.last_name LIKE 'B%';

----------------------------------------------------------------------------------- 

-- 6. List each employee in the Sales department, including their employee number, 
--    last name, and first name.
SELECT
	dem.dept_no
	,dem.emp_no
	,e.first_name
	,e.last_name
FROM dept_emp as dem
JOIN employees as e ON dem.emp_no = e.emp_no
WHERE dem.dept_no = 'd007';

----------------------------------------------------------------------------------- 

-- 7. List each employee in the Sales and Development departments, including their 
--    employee number, last name, first name, and department name.
SELECT
	dem.dept_no
	,dem.emp_no
	,e.first_name
	,e.last_name
	,d.dept_name
FROM dept_emp as dem
JOIN employees as e ON dem.emp_no = e.emp_no
JOIN departments as d ON dem.dept_no = d.dept_no
WHERE dem.dept_no = 'd007' OR dem.dept_no = 'd005'

----------------------------------------------------------------------------------- 

-- 8. List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name).
SELECT 
	e.last_name
	,COUNT(e.last_name) as freq
FROM employees as e
GROUP BY e.last_name
ORDER BY freq DESC

