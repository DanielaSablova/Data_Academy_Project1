-- Q4: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

CREATE OR REPLACE VIEW salary_increase
AS 
	(SELECT 
	t_a.measured_year AS year_a,	
	t_a.average_salary AS salary_a,
	t_b.measured_year AS year_b,
	t_b.average_salary AS salary_b,
	((t_b.average_salary - t_a.average_salary)/t_a.average_salary)*100 AS yearly_salary_increase
	FROM 
		(SELECT 
			measured_year,
			avg(average_value) AS average_salary
		FROM t_daniela_sablova_project_sql_primary_final tdspspf 
		WHERE data_type = 'average monthly salary in CZK'
		GROUP BY measured_year) AS t_a
	JOIN 
		(SELECT 
			measured_year,
			avg(average_value) AS average_salary
		FROM t_daniela_sablova_project_sql_primary_final tdspspf 
		WHERE data_type = 'average monthly salary in CZK'
		GROUP BY measured_year) AS t_b
	ON t_a.measured_year = t_b.measured_year - 1)
	;

CREATE OR REPLACE VIEW price_increase
AS 
	(SELECT 
	t_a.measured_year AS year_a,	
	t_a.average_price AS price_a,
	t_b.measured_year AS year_b,
	t_b.average_price AS price_b,	
	((t_b.average_price - t_a.average_price)/t_a.average_price)*100 AS yearly_price_increase
	FROM 
		(SELECT 
			measured_year,
			avg(average_value) AS average_price
		FROM t_daniela_sablova_project_sql_primary_final tdspspf 
		WHERE data_type = 'price in CZK'
		GROUP BY measured_year) AS t_a
	JOIN 
		(SELECT 
			measured_year,
			avg(average_value) AS average_price
		FROM t_daniela_sablova_project_sql_primary_final tdspspf 
		WHERE data_type = 'price in CZK'
		GROUP BY measured_year) AS t_b
	ON t_a.measured_year = t_b.measured_year - 1)
	;


SELECT 
	price.year_a AS previuos_year,
	price.year_b AS measured_year,
	ROUND(price.yearly_price_increase,2)AS yearly_price_increase,
	ROUND(salary.yearly_salary_increase, 2) AS yearly_salary_increase,
	ROUND(price.yearly_price_increase - salary.yearly_salary_increase,2) AS Difference
FROM 
	(SELECT 
		year_a,
		year_b,
		yearly_price_increase
	FROM price_increase pi2  
	) AS price
JOIN 
	(SELECT 
		year_a,
		year_b, 
		yearly_salary_increase
	FROM salary_increase si  
	) AS salary
ON price.year_a = salary.year_a
;

