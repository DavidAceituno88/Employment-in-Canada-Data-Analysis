SELECT u.Province, u.year, u.month, u.fromAge, u.toAge, u.employment_num, u.unemployment_num,
u.fullTime_Emp, u.part_time_emp, u.labour_force, u.population_total,
u.employment_rate, u.unemployment_rate, u.participation_rate,
uc.avg_employment_rate_per_year,uc.avg_unemployment_rate_per_year,
uc.avg_employment_rate_per_year_and_month, uc.avg_unemployment_rate_per_year_and_month,
uc.avg_employment_rate_per_province,uc.avg_unemployment_rate_per_province,
p.name, p.political_party
INTO employmentCanadaAnalysis
FROM UnemploymentCanada u
JOIN UnemploymentCanadaAnalytics uc ON u.province = uc.province AND u.year = uc.year AND u.month = uc.month
JOIN primeMinistersClean p ON u.year BETWEEN p.start_mandate AND p.end_mandate -1 --Substract a year to avoid OVERLAPING BETWEEN PRIME MINISTERS 
ORDER BY u.year

SELECT * FROM employmentCanadaAnalysis
