
----------------------------- {Student Name : Fatima Nawab} ---------------------------------
 
USE employees;

----------------------------- (Case File A: The Curious Cases of Employee Records) -------------------- 

-- Q1: List of newest 10 employees ?

(SELECT emp_no, first_name, last_name, hire_date
FROM employees
ORDER BY hire_date DESC
LIMIT 10);
-- here i am selecting employees no, first name,last name and hire date from employees table and 
-- ORDER BY ordering the hire date in descending order to get the newest employees and applying 
 -- LIMIT to get only 10 latest entries.

-- Q2: All the employees new hired post-Y2K?
 -- after year 2000
 
(SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '2000-01-01');
-- here i am selecting emp_no ,full name , hire date after year 2000
-- WHERE clause to filter dates 

-- Q3: How many employees named John? 

(SELECT COUNT(*) AS all_johns_in_office
 FROM employees
 WHERE first_name = 'John' or last_name = 'john');
 -- here i have used COUNT(*) with a WHERE condition to filter only employees named John.
-- note:: Answer : there is no employee named 'john'



----------------------------- Case File B: Following the Data Trails ---------------------

-- Q4: Match employees with departments?

(select  CONCAT(e.first_name, ' ', e.last_name) as employee_ful_name ,(dp.dept_name) AS employee_department
from employees e
join dept_emp d on e.emp_no = d.emp_no
JOIN departments dp ON dp.dept_no = d.dept_no);
-- here i have used CONCAT to join two cols and give it a single name usig AS 
-- then i used JOIN  to get employee department by connecting two seperate tables employees and dept_emp 
-- then i used join again to get dept_name by connecting tables, dept_emp and departments to match employees with their department name. 
 
-- Q5: Managers and departments?
 
(SELECT dp.dept_name,
       CONCAT(e.first_name, ' ', e.last_name) AS manager_name
FROM departments dp
JOIN dept_manager dm ON dp.dept_no = dm.dept_no
JOIN employees e ON dm.emp_no = e.emp_no);
-- here i have used CONCAT to join two col values adn used AS to give it a single name manager_name  
-- then i used JOIN TO connect to tables managers and departments to get managers info 
-- the i used JOIN on employees departments to get managers fulll name because we dont have a seperate list of managers name so we got the emp_no from the managers table and then checked the full name of that employee against emp_no.

-- Q6: Employees' current title?

SELECT e.emp_no,
       CONCAT( e.first_name,' ', e.last_name) AS employee_full_name,
       t.title
FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
WHERE t.to_date = '9999-01-01';
-- here again i used CONCAT 
-- then i used JOIN to connect titles with emp_no 
-- then i used WHERE condition to filter to_date '9999-01-01' to get the current roles of employees and skip the previous one  

-------------------------------- Case File C: Crunching Numbers for the CFO -------------------------

-- Q7: Number of people in each department ?

(select COUNT(d.emp_no) as total_employees, dp.dept_name
from departments dp
join dept_emp d on dp.dept_no = d.dept_no
group by dp.dept_name);
-- here i have used COUNTfunction to cout the total no of employees 
-- then i have connected dept_emp no and departments tables to get the department name from departments table againts dept_no.
-- then i used GROUP BY function to the result in the group form of departments 

-- Q8: Average salary?

(select avg(salary)
from salaries
WHERE to_date = '9999-01-01'
);
-- here i just used the AVG function on salary col to get the avg salary, yeah it was so easy ;)
-- :: note :Answer: avg salary is "63810.7448"

-- Q9: Top salary by department?
 
(SELECT dp.dept_name,
       MAX(s.salary) AS top_salary
FROM departments dp
JOIN dept_emp d ON dp.dept_no = d.dept_no
JOIN salaries s ON d.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'
GROUP BY dp.dept_name
ORDER BY top_salary DESC
limit 1);

-- here i have used the MAX function to get the max value of salary col
-- then i join  tables to get the deartment with epmployee  
-- then we connected through JOIN salaries and department 
-- GROUP BY to get departmentnames grouped 
-- ORDER BY to geth the highest salary on the top.

----------------------------------- Case File D: Salary Secret Levels -----------------------------

-- Q10: Classify employees into salary bands ?

(SELECT emp_no,
       CASE
           WHEN salary < 40000 THEN 'Low'
           WHEN salary BETWEEN 40000 AND 80000 THEN 'Medium'
           ELSE 'High'
       END AS pay_band
FROM salaries 
WHERE to_date = '9999-01-01');
-- here i have simple used CASE statement for havig multiple conditions executed together.

----------------------------------------------------- end of assignment -------------------------------

-- rough work 

SELECT  count(emp_no)
from employees;

select * from employees;
select * from salaries;
select * from departments ;

select avg(emp_no)
from employees ;
 
 
select first_name , last_name 
from employees 
where emp_no = '110022';
