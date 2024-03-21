-- Q1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

SELECT 
	measured_year,
	category_name AS industry,
	average_value AS average_salary,
	LAG(average_value) OVER (ORDER BY category_name, measured_year) AS last_year_salary,
	CASE 
		WHEN measured_year = 2006 THEN NULL 
		WHEN average_value > LAG(average_value) OVER (ORDER BY category_name, measured_year)
			THEN 'salary growth'
		WHEN average_value < LAG(average_value) OVER (ORDER BY category_name, measured_year)
			THEN 'salary decrease'
		ELSE FALSE
	END AS salary_in_time
FROM t_daniela_sablova_project_sql_primary_final tdspspf 
WHERE data_type = 'average monthly salary in CZK'
GROUP BY category_name, measured_year 
ORDER BY category_name ;