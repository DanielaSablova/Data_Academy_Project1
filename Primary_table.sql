CREATE OR REPLACE TABLE t_daniela_sablova_project_sql_primary_final 
AS
	(SELECT 
		cp.payroll_year AS measured_year,
		ROUND(AVG(cp.value),1) AS average_value,
		CONCAT('average monthly salary in CZK') AS data_type,
		cpib.name AS category_name
	FROM czechia_payroll cp 
	JOIN czechia_payroll_industry_branch cpib 
		ON cp.industry_branch_code = cpib.code
	WHERE 
		cp.value_type_code = 5958               -- bere v potaz pouze hodnoty "Průměrná hrubá mzda na zaměstnance"
		AND cp.payroll_year > 2005 AND cp.payroll_year < 2019
		AND cp_industry_branch_code IS NOT NULL   -- eliminace záznamů bez kodu
	GROUP BY
		cp.payroll_year,
		cp.industry_branch_code
	ORDER BY 
		cp.payroll_year,
		cp.industry_branch_code)
UNION 
	(SELECT
		YEAR(cpr.date_from) AS measured_year,
		ROUND(AVG(cpr.value),1) AS average_value,
		CONCAT('price in CZK') AS data_type,
		cpc.name AS category_name
	FROM czechia_price cpr
	JOIN czechia_price_category cpc
		ON cpr.category_code = cpc.code
	WHERE cpc.name != 'Jakostní víno bílé'
	GROUP BY
		YEAR(cpr.date_from),
		cpr.category_code)
	;