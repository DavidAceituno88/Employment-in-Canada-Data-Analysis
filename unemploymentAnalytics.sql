
SELECT DISTINCT "month" , province, year, 
CAST(AVG(employment_rate) OVER(PARTITION BY Province,YEAR,MONTH ORDER BY Year) AS DECIMAL(10,2)) AS avg_employment_rate_per_year_and_month,
CAST(AVG(unemployment_rate) OVER(PARTITION BY Province,YEAR,MONTH ORDER BY Year) AS DECIMAL(10,2)) AS avg_unemployment_rate_per_year_and_month,
CAST(AVG(employment_rate) OVER(PARTITION BY Province,YEAR ORDER BY Year) AS DECIMAL(10,2)) AS avg_employment_rate_per_year,
CAST(AVG(unemployment_rate) OVER(PARTITION BY Province,YEAR ORDER BY Year) AS DECIMAL(10,2)) AS avg_unemployment_rate_per_year,
CAST(AVG(employment_rate) OVER(PARTITION BY Province ORDER BY Province) AS DECIMAL(10,2)) AS avg_employment_rate_per_province,
CAST(AVG(unemployment_rate) OVER(PARTITION BY Province ORDER BY Province) AS DECIMAL(10,2)) AS avg_unemployment_rate_per_province
INTO unemploymentCanadaAnalytics
FROM Unemploymentcanada
ORDER BY PROVINCE, YEAR;

SELECT * FROM unemploymentCanadaAnalytics
