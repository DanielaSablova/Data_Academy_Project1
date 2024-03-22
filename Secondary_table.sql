CREATE OR REPLACE TABLE t_daniela_sablova_project_sql_secondary_final
SELECT e.country,
	e.`year` AS measured_year,
	e.GDP, 
	e.gini,
	e.population 
FROM economies e
JOIN countries c ON
	e.country = c.country 
WHERE `year` BETWEEN 2006 AND 2018
	AND c.continent = 'Europe'; 
	
