Engeto Data Academy - Final Project 1
---
discord name: daniela.sablova
-

# Project Structure

1. Readme commentary 
2. File with tables
3. File with answers to research questions
4. Answers

# How to proceed
1. Read the assignment and commentary below
2. Take a look at the source tables (primary and secondary table) and SQL for the answers
3. Read the file with answers to the research questions

# Assignment
V rámci projektu zaměřujícího se na dostupnost základních potravin široké veřejnosti, jsem připravila odpovědi na dané výzkumné otázky pro tiskové oddělení. 
Výstupem jsou 2 tabulky k databázi (1. tabulka - data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období 2.tabulka - HDP, GINI koeficient a populace dalších evropských států ve stejném období, jako primární tabulka) a sada SQL, díky kterým získáme z tabulek odpovědi na výzkumné otázky.
Výzkumné otázky: 
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

# Data sets for the Project
Primární tabulky:
1.	czechia_payroll – Informace o mzdách v různých odvětvích za několikaleté období. 
	Datová sada pochází z Portálu otevřených dat ČR.
2.	czechia_payroll_calculation – Číselník kalkulací v tabulce mezd.
3.	czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd.
4.	czechia_payroll_unit – Číselník jednotek hodnot v tabulce mezd.
5.	czechia_payroll_value_type – Číselník typů hodnot v tabulce mezd.
6.	czechia_price – Informace o cenách vybraných potravin za několikaleté období. 
	Datová sada pochází z Portálu otevřených dat ČR.
7.	czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu.

Číselníky sdílených informací o ČR:
1.	czechia_region – Číselník krajů České republiky dle normy CZ-NUTS 2.
2.	czechia_district – Číselník okresů České republiky dle normy LAU.
   
Dodatečné tabulky:
1.	countries - Všemožné informace o zemích na světě, například hlavní město, měna, 
	národní jídlo nebo průměrná výška populace.
2.	economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.



# Data and tables description

Table 1
-
Data využijeme pouze z let 2006-2018 (data o mzdách máme pro roky 2000 - 2021, o cenách pro roky 2006 až 2018), jelikož mají být sjednocená na totožné porovnatelné období – společné roky.
V primární tabulce byly využity data z data sad: czechia_payroll, czechia_payroll_industry_branch, czechia_price, czechia_price_category
Pro vytvoření tabulky je použita funkce UNION, čímž pod sebe seřadíme data o cenách a mzdách. O jaký typ údaje je rozlišeno ve sloupci data_type
Popis sloupců:
measured_year - určuje, v jakém roce byly hodnoty naměřeny
average_value - daná hodnota mzdy či ceny zaokrouhlené na 1 des. místo 
data_type - určuje zda se jedná o průměrnou mzdu nebo cenu zboží v dané kategorii
category_name - název kategorie pro potraviny / název odvětví pro mzdy
Hodnoty z tabulky czechia_payroll o průměrném množství zaměstnanců byly odstraněny pomocí  'WHERE cp.value_type_code = 5958'. Tímto získáme pouze data o průměrných mzdách. 
Byly zjištěny také záznamy s nevyplněným industry_branch_code, které je pro některé otázky klíčové. Toto bylo upraveno vyloučením těchto záznamů 'cp.industry_branch_code IS NOT NULL.'
Hodnoty cen a mezd byly zprůměrovány a seskupeny dle náležitých kategorií k zmenšení data setu a urychlení následujících dotazů.

Table 2
-
Sekundární tabulka obsahuje přehled o HDP, GINI koeficientu a populaci jako přehled primární tabulky. Roky jsou tedy omezeny na 2006-2018. Tabulka obsahuje data z 'economies' a 'countries'
Tabulka 'countries' byla napojena pro snadné vyfiltrování evropských zemí. 
Popis sloupců:
Country - daná evropská země
Year - rok měření
GDP - hodnota HDP
GINI - GINI koeficient
Population - Počet obyvatel dané země v daném roce!

# Commentary for Question SQL queries
Question 1
K výpočtu, zda mzda rostla nebo klesala, vytvoříme sloupec Last_year_salary pomocí funkce LAG, která nám vybere hodnoty o jeden řádek výš. 
Ve sloupci salary_in_time je následně uvedeno, zda mzda v daném roce v porovnání s předchotím roce vzrostla nebo klesla

Question 2
První a poslední srovnatelné období jsou roky 2006 a 2018. 
Jedná se o hodnoty cen zprůměrované za celý rok a z celé republiky.
Hodnoty kilo chleba a litrů mléka jsou zaokrouhlené na nejbližší číslo dolů, jelikož případné zaokrouhlení nahoru by nedávalo smyls. 
Je napojena znovu primární tabulku pomocí funkce JOIN přes rok měření, abychom spojili data o cenách a mzdách. 
Nejdůležitější je sloupec units, který ukazuje za kolik by si průměrně v daném roce bylo  možné za průměrnou mzdu kilo chleba či litrů mléka).

Question 3 
Z Primární tabulky jsou vyfiltrovaná data pouze pro ceny potravin. K výpočtu meziročního růstu je využit LAG. Meziroční nárůsty (poklesy) byly následně zprůměrovány, abychom zjistili průměrný meziroční nárůst. K tomu bylo také nutné využít vnořený select.

Question 4
Nejprve je zjištěn meziroční nárůst mezd pomocí VIEW. Data o mzdách zprůměrujeme na roční mzdu, pomocí JOIN získáme meziroční srovnání.
Stejný postup je aplikován u zjištění meziročního nárůstu mezd.

Poslední  příkaz spojuje informace o obou ukazatelích a je zde přidán sloupec k výpočtu rozdílu růstu cen a mezd.
 Data ve sloupi yearly_selery_increase a yearly_price_increase jsou v procentech.
Question 5
Je vytvořeno VIEW pro jednodušší následnou manipulaci s daty o HDP. Pro získání dat o HDP je využita sekundární tabulka. Pomocí JOIN stejné tabulky získáme srovnání a vypočítáme meziroční nárůst HDP.  
Data o hdp jsou vyselektována pouze pro Českou republiku. 
Následně porovnáváme percentuální meziroční rozdíly pro ceny, mzdy a HDP. Pro data o mzdách a cenách jsou využity pohledy z předchozí otázky.
 Data ve sloupi yearly_selery_increase, yearly_price_increase a yearly_GDP_difference jsou v procentech.
Výraznější změna HDP byla určena jako pokles nebo nárůst o 4 %. Do tabulky byl doplněn sloupec, který určuje, v kterých letech nastala výrazná změna v HDP. 



