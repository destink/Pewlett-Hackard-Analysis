-- Challenge Queries
-- Part 1
-- Number of Retiring Employees by Title
SELECT e.emp_no, e.first_name, e.last_name, ti.title, ti.from_date, ti.to_date
INTO retirement_title
FROM employees as e 
INNER JOIN titles as ti 
ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Info from retirement titles table 
SELECT rt.emp_no, rt.first_name, rt.last_name, rt.title
FROM retirement_title as rt

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_title as rt
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- Number of employees by most recent job title
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT DESC;

-- Part 2
-- Mentorship Eligibility 
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e. last_name,
					e.birth_date, de.from_date, de.to_date, ti.title
-- INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_employee as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND de.to_date = '9999-01-01' 
ORDER BY emp_no 