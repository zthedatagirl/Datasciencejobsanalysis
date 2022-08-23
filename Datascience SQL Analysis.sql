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