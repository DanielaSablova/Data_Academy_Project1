-- Q2: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období

SELECT 
	price.year,
	food_category,
	average_price_CZK,
	average_salary_CZK,
	FLOOR(average_salary_CZK/average_price_CZK) AS units
FROM 
	(SELECT
		measured_year,
		ROUND(AVG(average_value),1) AS average_salary_CZK
	FROM t_daniela_sablova_project_sql_primary_final tdspspf 
	WHERE 
		measured_year IN (2006, 2018)
		AND data_type = 'average monthly salary in CZK'
	GROUP BY measured_year)
	AS salary
JOIN 
	(SELECT 
		measured_year AS 'year',
		category_name AS food_category,
		average_value AS average_price_CZK
	FROM t_daniela_sablova_project_sql_primary_final tdspspf 
	WHERE 
		measured_year IN (2006, 2018)
		AND data_type = 'price in CZK'
		AND category_name IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované'))
	AS price
ON salary.measured_year = price.year
;

