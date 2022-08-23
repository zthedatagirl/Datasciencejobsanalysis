--Checking the dataset to be sure that it was imported correctly
SELECT *
FROM SQLPortfolio1..DsSalary

--How many job title was included in the dataset?
SELECT COUNT(DISTINCT job_title) AS no_of_job
FROM SQLPortfolio1..DsSalary

--Does the experience level affect salary?
SELECT CASE WHEN experience_level = 'MI' THEN 'Mid level'
            WHEN experience_level = 'SE' THEN 'Senior level'
			WHEN experience_level = 'EN' THEN 'Entry level'
			WHEN experience_level = 'EX' THEN 'Executive level'
		ELSE NULL END AS experience_category, COUNT(1) AS no_of_category,
		ROUND(AVG(salary_in_usd), 2) AS average_salary
FROM SQLPortfolio1..DsSalary
GROUP BY CASE WHEN experience_level = 'MI' THEN 'Mid level'
            WHEN experience_level = 'SE' THEN 'Senior level'
			WHEN experience_level = 'EN' THEN 'Entry level'
			WHEN experience_level = 'EX' THEN 'Executive level'
		ELSE NULL END 
ORDER BY average_salary DESC

--Which category has the highest salary
SELECT CASE WHEN experience_level = 'MI' THEN 'Mid level'
            WHEN experience_level = 'SE' THEN 'Senior level'
			WHEN experience_level = 'EN' THEN 'Entry level'
			WHEN experience_level = 'EX' THEN 'Executive level'
		ELSE NULL END AS experience_category, COUNT(1) AS no_of_category,
		ROUND(MAX(salary_in_usd), 2) AS highest_salary
FROM SQLPortfolio1..DsSalary
GROUP BY CASE WHEN experience_level = 'MI' THEN 'Mid level'
            WHEN experience_level = 'SE' THEN 'Senior level'
			WHEN experience_level = 'EN' THEN 'Entry level'
			WHEN experience_level = 'EX' THEN 'Executive level'
		ELSE NULL END 
ORDER BY highest_salary DESC


--What is the average salary per job_title in USD
SELECT job_title, ROUND(AVG(salary_in_usd), 2) AS Average_salary
FROM SQLPortfolio1..DsSalary
GROUP BY job_title
ORDER BY average_salary DESC

--What is the highest salary per job title in USD
SELECT TOP 5 job_title,  ROUND(MAX(salary_in_usd), 2) AS highest_salary
FROM SQLPortfolio1..DsSalary
GROUP BY job_title
ORDER BY highest_salary DESC

--What is the highest paying entry level data science job
WITH table1 (job_title, experience_level, salary_in_usd, job_rank)
AS(
SELECT job_title, experience_level, salary_in_usd, 
		RANK() OVER (PARTITION BY job_title, experience_level ORDER BY salary_in_usd DESC) AS job_rank
		 FROM SQLPortfolio1..clean_ds_salaries
WHERE experience_level = 'EN')

SELECT job_rank, job_title, experience_level, salary_in_usd
FROM table1
WHERE job_rank = 1
ORDER BY salary_in_usd DESC 
--ANS: Machine Learning Engineer, 250,000


--What is the highest paying mid level data science job

SELECT  MAX(salary_in_usd) AS highest_salary, job_title
FROM SQLPortfolio1..clean_ds_salaries
WHERE experience_level = 'MI'
GROUP BY job_title
ORDER BY highest_salary DESC
--ANS: Financial Data Analyst and Research Scientist, 450,000


--What is the highest paying senior level data science job

SELECT  MAX(salary_in_usd) AS highest_salary, job_title
FROM SQLPortfolio1..clean_ds_salaries
WHERE experience_level = 'SE'
GROUP BY job_title
ORDER BY highest_salary DESC

--ANS Data Scientist at 412,000

--What is the highest paying Executive level data science job

SELECT TOP 5 job_title,MAX(salary_in_usd) AS highest_salary
FROM SQLPortfolio1..clean_ds_salaries 
WHERE experience_level = 'EX'
GROUP BY job_title
ORDER BY highest_salary DESC

--ANS - Principal Data Engineer at 600,000

--Average salary per experience level
SELECT CASE WHEN experience_level = 'MI' THEN 'Mid level'
            WHEN experience_level = 'SE' THEN 'Senior level'
			WHEN experience_level = 'EN' THEN 'Entry level'
			WHEN experience_level = 'EX' THEN 'Executive level'
		ELSE NULL END AS experience_category, ROUND(AVG(salary_in_usd) , 2) AS average_salary
FROM SQLPortfolio1..clean_ds_salaries
GROUP BY CASE WHEN experience_level = 'MI' THEN 'Mid level'
            WHEN experience_level = 'SE' THEN 'Senior level'
			WHEN experience_level = 'EN' THEN 'Entry level'
			WHEN experience_level = 'EX' THEN 'Executive level'
		ELSE NULL END 
ORDER BY average_salary DESC


--What is the lowest paying entry level data science job?

SELECT MIN(salary_in_usd) AS lowest_salary, job_title
FROM SQLPortfolio1..clean_ds_salaries
WHERE experience_level = 'EN'
GROUP BY job_title
ORDER BY lowest_salary 

--ANS: Data Scientist, 4000


--What is the lowest paying Mid level Data Science Job
SELECT MIN(salary_in_usd) AS lowest_salary, job_title
FROM SQLPortfolio1..clean_ds_salaries
WHERE experience_level = 'MI'
GROUP BY job_title
ORDER BY lowest_salary 
--ANS: Data Scientist, 2859 


--What is the lowest paying Senior level data science job?
SELECT MIN(salary_in_usd) AS lowest_salary, job_title
FROM SQLPortfolio1..clean_ds_salaries
WHERE experience_level = 'SE'
GROUP BY job_title
ORDER BY lowest_salary 

--ANS: Computer Vision Engineer, 18,907


--What is the lowest paying Executive level data science job?
SELECT MIN(salary_in_usd) AS lowest_salary, job_title
FROM SQLPortfolio1..clean_ds_salaries
WHERE experience_level = 'EX'
GROUP BY job_title
ORDER BY lowest_salary 

--Ans: Data Science Consultant, 69,741

--Does experience level affect the data science job salary
SELECT CASE WHEN experience_level = 'MI' THEN 'Mid level'
            WHEN experience_level = 'SE' THEN 'Senior level'
			WHEN experience_level = 'EN' THEN 'Entry level'
			WHEN experience_level = 'EX' THEN 'Executive level'
		ELSE NULL END AS experience_category, COUNT(1) AS no_of_category,
		ROUND(AVG(salary_in_usd), 2) AS average_salary
FROM SQLPortfolio1..clean_ds_salaries
GROUP BY CASE WHEN experience_level = 'MI' THEN 'Mid level'
            WHEN experience_level = 'SE' THEN 'Senior level'
			WHEN experience_level = 'EN' THEN 'Entry level'
			WHEN experience_level = 'EX' THEN 'Executive level'
		ELSE NULL END 
ORDER BY average_salary DESC


--Does company size affect salary?
SELECT CASE WHEN employment_type = 'FT' THEN 'Full time'
            WHEN employment_type = 'PT' THEN 'Part time'
			WHEN employment_type = 'FL' THEN 'Freelance'
			WHEN employment_type = 'CT' THEN 'Contract'
		ELSE NULL END AS employment_type,
		ROUND(AVG(salary_in_usd), 2) AS average_salary
FROM SQLPortfolio1..clean_ds_salaries 
GROUP BY CASE WHEN employment_type = 'FT' THEN 'Full time'
            WHEN employment_type = 'PT' THEN 'Part time'
			WHEN employment_type = 'FL' THEN 'Freelance'
			WHEN employment_type = 'CT' THEN 'Contract'
		ELSE NULL END 
ORDER BY average_salary DESC

--Average salary per year
SELECT CASE WHEN work_year = '2020' THEN 'Year 2020'
			WHEN work_year = '2021' THEN 'Year 2021'
			WHEN work_year = '2022' THEN 'Year 2022'
		ELSE NULL END AS year_of_work,  
		ROUND(AVG(salary_in_usd), 2) AS average_salary
FROM SQLPortfolio1..clean_ds_salaries 
GROUP BY CASE WHEN work_year = '2020' THEN 'Year 2020'
			WHEN work_year = '2021' THEN 'Year 2021'
			WHEN work_year = '2022' THEN 'Year 2022'
		ELSE NULL END 
ORDER BY average_salary DESC
--ANS: Average salary progressed over the years

--What is the average salary of workers residing outside US

SELECT CASE WHEN employee_residence = 'US' THEN 'In the US'
		 ELSE 'Not in US' END AS residence_category,
		 ROUND(AVG(salary_in_usd), 2) AS avg_salary
FROM SQLPortfolio1..clean_ds_salaries 
WHERE employee_residence NOT LIKE '%US%'
GROUP BY CASE WHEN employee_residence = 'US' THEN 'In the US'
		 ELSE 'Not in US' END

--ANS: $67,469.79

--What is the average salary of workers residing in the US
SELECT CASE WHEN employee_residence = 'US' THEN 'In the US'
		 ELSE 'Not in US' END AS residence_category,
		 ROUND(AVG(salary_in_usd), 2) AS avg_salary
FROM SQLPortfolio1..clean_ds_salaries 
WHERE employee_residence  LIKE '%US%'
GROUP BY CASE WHEN employee_residence = 'US' THEN 'In the US'
		 ELSE 'Not in US' END
--ANS: $150,094.92

--Does Company Size affect salary
SELECT CASE WHEN company_size = 'L' THEN 'Large Company'
			WHEN company_size = 'M' THEN 'Medium Company'
			WHEN company_size = 'S' THEN 'Small Company'
		 ELSE NULL END AS new_company_size,
		 ROUND(AVG(salary_in_usd), 2) AS avg_salary
FROM SQLPortfolio1..clean_ds_salaries 
GROUP BY CASE WHEN company_size = 'L' THEN 'Large Company'
			WHEN company_size = 'M' THEN 'Medium Company'
			WHEN company_size = 'S' THEN 'Small Company'
		 ELSE NULL END

--ANS: Yes, it does. Larger company tend to pay more

--Does company location affect Salary
SELECT CASE WHEN company_location = 'US' THEN 'In the US'
		 ELSE 'Not in US' END AS company_loc_category,
		 ROUND(AVG(salary_in_usd), 2) AS avg_salary
FROM SQLPortfolio1..clean_ds_salaries 
GROUP BY CASE WHEN company_location = 'US' THEN 'In the US'
		 ELSE 'Not in US' END
--ANS: Yes, it does. Company in the US tend to pay more on the average
