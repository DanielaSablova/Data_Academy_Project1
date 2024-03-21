-- Q3: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?


SELECT 
	category_name AS food_category,
	average_value AS average_price, 
	AVG(price_increase) AS avg_price_increase
FROM 
	(SELECT 
		category_name,
		average_value, 
		measured_year,
		CASE 
			WHEN measured_year = 2006 THEN NULL 
			ELSE ((average_value - LAG(average_value) OVER (ORDER BY category_name, measured_year))/
			(LAG(average_value) OVER (ORDER BY category_name, measured_year)))*100
		END	AS price_increase
	FROM t_daniela_sablova_project_sql_primary_final tdspspf 
	WHERE data_type = 'price in CZK'
	ORDER BY category_name, measured_year) AS subquers
GROUP BY food_category
ORDER BY avg_price_increase
;
	