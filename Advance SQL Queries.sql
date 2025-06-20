DROP TABLE IF EXISTS Employee_new;

CREATE TABLE Employee_new(
           EMP_id SERIAL PRIMARY KEY,
		   EMP_name VARCHAR (100),
		   EMP_dept VARCHAR (50),
		   EMP_salary NUMERIC (10,2),
		   EMP_joining_date DATE
);
SELECT * FROM Employee_new;

INSERT INTO Employee_new (EMP_id, EMP_name, EMP_dept, EMP_salary, EMP_joining_date)
	  VALUES    ( 101, 'Amit Kumar', 'Finance', 34000, '2023-05-01' ),
				( 102, 'Aditi Verma', 'Finance', 39000, '2023-01-01'),
				(103, ' Rohit Sharma', 'Sales', 25000, '2024-07-02'),
				(104, 'Rakshit Gupta', 'HR', 42000, '2024-03-12'),
				(105, 'Preet Singh', 'Analyst', 75000, '2025-06-12'),
				(106, 'Jyoti Singh', 'Developer', 69000, '2025-02-17'),
				(107, 'Amanpreet Kaur', 'CA', 72000, '2024-11-01'),
				(108, 'Jaspreet Kaur', 'HR', 45000, '2024-12-11'),
				(109, 'Harjot Singh', 'Sales', 32000, '2023-01-01'),
				(110, 'Sanjana Kumar', 'Developer', 72000, '2024-11-10'),
				(111,'Sanjot Verma', 'Operations', 55000, '2025-03-01'),
				(112, 'Harmeet Singh', 'Event Planner', 40000, '2025-01-01'),
				(113, 'Boomika Gupta', 'Event palnner', 40000, '2025-03-01'),
				(114, 'Manjot Kaur', 'Analyst', 68000, '2025-04-02'),
				(115, 'Manmeet Singh', 'Event Planner', 46000, '2024-12-12'),
				(116, 'Abdul Shaikh', 'Marketing', 39000, '2024-05-01'),
				(117, 'Asif Shaikh', 'Marketing', 35000, '2025-01-01'),
				(118, 'Jahnvi Jethani', 'Social Media', 47000, '2025-05-01'),
				(119, 'Chandni Sharma', 'Product Management', 65000, '2024-11-15'),
				(120, 'Sarprit Singh', 'Editor', 55000, '2025-06-01');

SELECT * FROM Employee_new;


--SECOND HIGHEST SALARY 
SELECT MAX(emp_salary)AS second_highest_salary
FROM Employee_new
WHERE EMP_salary < (
SELECT MAX(emp_salary) FROM Employee_new);
--TOTAL SALARY OF EACH DEPARTMENT
SELECT EMP_dept, SUM(EMP_salary) AS total_salary
FROM Employee_new
GROUP BY EMP_dept;
--TOTAL SALARY BY TOTAL EMP AND DEPARTMENT
SELECT COUNT(*) AS total_emp, COUNT(DISTINCT(EMP_dept)) AS total_dept,
SUM(EMP_salary) AS total_month_salary
FROM Employee_new;
--THIRD HIGHEST SALARY 
SELECT MAX(EMP_salary) AS third_highest_salary
FROM Employee_new
WHERE EMP_salary <(SELECT MAX(EMP_salary) FROM Employee_new 
					WHERE EMP_salary < (SELECT MAX(EMP_salary)
					FROM Employee_new));
--TOTAL HIGHEST DEPARTMENT SALARY
SELECT EMP_dept AS Department, SUM(EMP_salary) AS total_salary
FROM Employee_new
GROUP BY EMP_dept
HAVING SUM(EMP_salary) = ( SELECT MAX(total_dept_salary) FROM 
     						( SELECT EMP_dept, SUM(EMP_salary) AS total_dept_salary
							  FROM employee_new 
							  GROUP BY EMP_dept)
							  AS HIGHEST_dept_salary);

--TOTAL LOWEST DEPARTMENT SALARY
SELECT DISTINCT(EMP_dept)AS Department, SUM(EMP_salary) AS total_dept_salary
FROM Employee_new
GROUP BY DISTINCT(EMP_dept)
HAVING SUM(EMP_salary)= (SELECT MIN (total_dept_salary) FROM
							(SELECT DISTINCT(EMP_dept), SUM(EMP_salary) AS total_dept_salary
								FROM Employee_new
								GROUP BY DISTINCT(EMP_dept)
								) AS LOWEST_dept_salary);
--TOTAL SECOND HIGHEST DEPARTMENT SALARY
SELECT EMP_DEPT,SUM(EMP_SALARY) AS SECOND_TOTAL_DEPT_SALARY
FROM EMPLOYEE_NEW
GROUP BY EMP_DEPT
HAVING SUM(EMP_SALARY) = 
		(SELECT MAX(HIGHEST_DEPT_SALARY)
		FROM(SELECT EMP_DEPT, SUM(EMP_SALARY) AS HIGHEST_DEPT_SALARY
			 FROM EMPLOYEE_NEW
			 GROUP BY EMP_DEPT
			 HAVING SUM(EMP_SALARY) < 
			  (SELECT MAX(HIGHEST_DEPT_SALARY)
			  FROM (SELECT EMP_DEPT,SUM(EMP_SALARY) AS HIGHEST_DEPT_SALARY
					FROM EMPLOYEE_NEW
					GROUP BY EMP_DEPT
					) AS DEPT_SALARY
				)
			) AS HIGH_SALARY
	);
-- TOTAL SECOND LOWEST DEPARTMENT SALARY
SELECT EMP_DEPT,SUM(EMP_SALARY) AS SECOND_TOTAL_DEPT_SALARY
FROM EMPLOYEE_NEW
GROUP BY EMP_DEPT
HAVING SUM(EMP_SALARY) = 
		(SELECT MIN(LOWEST_DEPT_SALARY)
		FROM(SELECT EMP_DEPT, SUM(EMP_SALARY) AS LOWEST_DEPT_SALARY
			 FROM EMPLOYEE_NEW
			 GROUP BY EMP_DEPT
			 HAVING SUM(EMP_SALARY) > 
			  (SELECT MIN(HIGHEST_DEPT_SALARY)
			  FROM (SELECT EMP_DEPT,SUM(EMP_SALARY) AS HIGHEST_DEPT_SALARY
					FROM EMPLOYEE_NEW
					GROUP BY EMP_DEPT
					) AS DEPT_SALARY
				)
			) AS HIGH_SALARY
	);
--FIND EMPLOYEES WHO HAVE SAME SALARY WITH SAME DEPARTMENT OR ANOTHER
SELECT e1.EMP_name,e1.EMP_salary, e1.EMP_dept 
FROM Employee_new e1
JOIN Employee_new e2
ON e1.EMP_salary = e2.EMP_salary
AND e1.EMP_dept<>e2.EMP_dept
ORDER BY EMP_salary ASC;
--INCREASE THE SALARY BY 10% FOR ALL EMPLOYEE WHOSE EXPERIENCE MORE THAN 2 YEAR IN THE COMPANY
SELECT EMP_name, EMP_dept,EMP_salary,(CURRENT_DATE - EMP_joining_date) AS Days_of_duration,
        CASE WHEN(CURRENT_DATE - EMP_joining_date)>730 THEN EMP_salary*0.10
		          ELSE 0 
			END AS increment_,
		EMP_salary+
		CASE WHEN (CURRENT_DATE - EMP_joining_date)>730 THEN  EMP_salary*0.10
		          ELSE 0 
			END AS EMP_new_salary
			FROM employee_new;
			




					



				
				

			
				
				