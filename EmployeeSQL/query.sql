--1. List the following details of each employee: employee number, last name, 
--   first name, sex, and salary.
SELECT emp_no, last_name, first_name, sex, salary
FROM employees
JOIN salaries USING (emp_no)
ORDER BY emp_no;

--2. List first name, last name, and hire date for employees who were hired in 
--   1986.
SELECT first_name, last_name, sex, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDer by hire_date;

--3. List the manager of each department with the following information: department 
--   number, department name, the manager's employee number, last name, first name.
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, last_name, first_name
FROM employees
RIGHT JOIN dept_manager ON employees.emp_no=dept_manager.emp_no
LEFT JOIN departments ON dept_manager.dept_no=departments.dept_no
ORDER BY dept_manager.dept_no;

--4. List the department of each employee with the following information: employee number,
--   last name, first name, and department name.
SELECT employees.emp_no, last_name, first_name, dept_name
FROM employees
LEFT JOIN dept_emp ON employees.emp_no=dept_emp.emp_no
LEFT JOIN departments ON dept_emp.dept_no=departments.dept_no
ORDER BY employees.emp_no;

-- Some people are in two(2) departments. Let's see!
SELECT emp_no, COUNT(dept_no) AS total
FROM dept_emp
GROUP BY emp_no
ORDER BY total DESC, emp_no ASC;

--5. List first name, last name, and sex for employees whose first name is "Hercules"
--   and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name='Hercules' AND last_name LIKE 'B%'
ORDER BY last_name;

--6. List all employees in the Sales department, including their employee number, 
--   last name, first name, and department name.
SELECT de.emp_no, last_name, first_name, dept_name
FROM employees e
LEFT JOIN dept_emp de ON e.emp_no=de.emp_no
LEFT JOIN departments d ON d.dept_no=de.dept_no
WHERE de.dept_no = 'd007' 		--Sales Department is d007.
ORDER BY de.emp_no;

-- This is a count of employees in Sales Department using subquery.
SELECT COUNT (*) AS "Employees in Sales"
FROM employees
WHERE emp_no IN 
(SELECT emp_no
 FROM dept_emp
 WHERE dept_no IN 
 (SELECT dept_no
  FROM departments
  WHERE dept_no='d007'
 )
);

--7. List all employees in the Sales and Development departments, including their 
--   employee number, last name, first name, and department name.
SELECT de.emp_no, last_name, first_name, dept_name
FROM employees e
LEFT JOIN dept_emp de ON e.emp_no=de.emp_no
LEFT JOIN departments d ON d.dept_no=de.dept_no
--Sales Department is d007 and Development Department is d005.
WHERE de.dept_no = 'd007' OR de.dept_no = 'd005'
ORDER BY dept_name ASC, de.emp_no ASC;

-- This is a count of employees in Sales or Development Departments using subqueries.
SELECT COUNT (*) AS "Employees in Sales or Development"
FROM employees
WHERE emp_no IN 
(SELECT emp_no
 FROM dept_emp
 WHERE dept_no IN 
 (SELECT dept_no
  FROM departments
  WHERE dept_no='d007' OR dept_no = 'd005'
 )
);

--8. In descending order, list the frequency count of employee last names, 
--   i.e., how many employees share each last name.
SELECT last_name, COUNT(*) AS emp_count
FROM employees
GROUP BY last_name
ORDER BY emp_count DESC;

