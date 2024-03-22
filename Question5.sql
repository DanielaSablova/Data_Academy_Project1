/* Q5: Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce,
projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem? 
*/

CREATE OR REPLACE VIEW GDP_increase
AS
	(SELECT 
		t_a.measured_year AS year_a,
		t_a.GDP AS GDP_a,
		t_b.measured_year AS year_b,
		t_b.GDP AS GDP_b,
		((t_b.GDP - t_a.GDP)/t_a.GDP)*100 AS yearly_GDP_increase
	FROM
		(SELECT 
			measured_year,
			GDP
		FROM t_daniela_sablova_project_sql_secondary_final tdspssf 
		WHERE 
			country = 'Czech republic')
		AS t_a
	JOIN 
		(SELECT  
			measured_year,
			GDP
		FROM t_daniela_sablova_project_sql_secondary_final tdspssf
		WHERE 
			country = 'Czech republic')
		AS t_b
	ON 
		t_a.measured_year = t_b.measured_year - 1)
;

SELECT 
	price.year_a AS previous_year,
	price.year_b AS measured_year,
	ROUND(price.yearly_price_increase,2)AS yearly_price_increase,
	ROUND(salary.yearly_salary_increase, 2) AS yearly_salary_increase,
	ROUND(GDP.yearly_GDP_increase,2) AS yearly_GDP_increase, 
	CASE 
		WHEN GDP.yearly_GDP_increase BETWEEN -4 AND 4 THEN 'Non-significant GDP change'
		ELSE 'Significant GDP change'
	END AS GDP_change_evaluation
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
	JOIN 
		(SELECT 
			year_a,
			year_b, 
			yearly_GDP_increase
		FROM GDP_increase)
		 AS GDP
	ON price.year_a = GDP.year_a
	ORDER BY price.year_a;

		


