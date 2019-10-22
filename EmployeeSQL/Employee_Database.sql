DROP TABLE employees;

CREATE TABLE employees (
    emp_no INT NOT NULL,
    birth_date  VARCHAR (255) NOT NULL,
    first_name  VARCHAR(255) NOT NULL,
    last_name   VARCHAR(255) NOT NULL,
    gender      VARCHAR(255) NOT NULL,    
    hire_date   VARCHAR (255) NOT NULL,
    PRIMARY KEY (emp_no)
);

SELECT * FROM employees

DROP TABLE departments;

CREATE TABLE departments (
    dept_no     VARCHAR(255) NOT NULL,
    dept_name   VARCHAR(255) NOT NULL,
    PRIMARY KEY (dept_no)
    
);

SELECT * FROM departments;

DROP TABLE dept_manager;

CREATE TABLE dept_manager (
   dept_no VARCHAR(255) NOT NULL,
   emp_no INT NOT NULL,
   from_date VARCHAR (255) NOT NULL,
   to_date VARCHAR (255) NOT NULL,
   FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
   FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
   PRIMARY KEY (emp_no,dept_no)
); 

select * from dept_manager

DROP TABLE dept_emp

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(255) NOT NULL,
    from_date VARCHAR (255) NOT NULL,
    to_date VARCHAR (255) NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no,dept_no)
);

SELECT * FROM dept_emp;

DROP TABLE titles;

CREATE TABLE titles (
    emp_no      INT NOT NULL,
    title       VARCHAR(255) NOT NULL,
    from_date   VARCHAR (255) NOT NULL,
    to_date     VARCHAR (255) NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no,title, from_date)
); 

SELECT * FROM titles;

DROP TABLE salaries;

CREATE TABLE salaries (
    emp_no      INT  NOT NULL,
    salary      INT  NOT NULL,
    from_date   VARCHAR (255) NOT NULL,
    to_date     VARCHAR (255) NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no, from_date)
) ;

select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select* from titles;

-- 1. 

SELECT 
e.emp_no,
e.last_name,
e.first_name,
e.gender,
s.salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no;

-- 2.

SELECT
hire_date
FROM employees
WHERE extract(year from hire_date) = '1986'; 

-- 3. 

SELECT
m.dept_no,
dept_name,
m.emp_no,
first_name,
last_name,
m.from_date,
m.to_date
FROM dept_manager m
LEFT JOIN departments on m.dept_no = departments.dept_no
LEFT JOIN employees on m.emp_no = employees.emp_no;

-- 4.

SELECT
e.emp_no, 
first_name, 
last_name,
dept_name
FROM employees e
LEFT JOIN dept_emp d
ON e.emp_no = d.emp_no
LEFT JOIN departments
ON d.dept_no = departments.dept_no;

select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select* from titles;

-- 5.

SELECT * FROM employees
WHERE(first_name LIKE 'Hercules' AND last_name LIKE '%B%');

-- 6.

Select
e.emp_no, 
first_name, 
last_name,
dept_name
FROM employees e
LEFT JOIN dept_emp d
ON e.emp_no = d.emp_no
LEFT JOIN departments
ON d.dept_no = departments.dept_no 
WHERE departments.dept_name lIKE 'Sales';

-- 7.

Select
e.emp_no, 
first_name, 
last_name,
dept_name
FROM employees e
LEFT JOIN dept_emp d
ON e.emp_no = d.emp_no
LEFT JOIN departments
ON d.dept_no = departments.dept_no 
WHERE departments.dept_name lIKE 'Sales'
OR departments.dept_name LIKE  'Development';

-- 8.

SELECT
last_name,
COUNT(last_name) AS "name_count"
from employees
GROUP BY
last_name
ORDER BY name_count DESC;
