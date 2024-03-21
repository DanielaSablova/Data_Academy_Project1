Engeto Data Academy - Final Project 1
---

# Project Structure

1. Commentary and answers
2. File with tables
3. File with answers to research questions

# How to proceed
1. Read the assignment and description below
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
