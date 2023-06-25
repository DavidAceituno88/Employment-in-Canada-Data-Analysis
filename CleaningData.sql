SELECT *
FROM UnemploymentCanada

/*Standarize Date Format*/
ALTER TABLE unemploymentCanada
Add Year Int;

UPDATE UnemploymentCanada
SET Year = CAST(LEFT(REF_DATE,CHARINDEX('-',REF_DATE)-1) AS INT)

ALTER TABLE unemploymentCanada
Add Month VARCHAR (20);

UPDATE UnemploymentCanada
SET Month = CASE WHEN week =1 THEN 'JAN'
				 WHEN week =2 THEN 'FEB'
				 WHEN week =3 THEN 'MAR'
				 WHEN week =4 THEN 'APR'
				 WHEN week =5 THEN 'MAY'
				 WHEN week =6 THEN 'JUN'
				 WHEN week =7 THEN 'JUL'
				 WHEN week =8 THEN 'AUG'
				 WHEN week =9 THEN 'SEP'
				 WHEN week =10 THEN 'OCT'
				 WHEN week =11 THEN 'NOV'
				 WHEN week =12 THEN 'DEC'
END;

ALTER TABLE unemploymentCanada
DROP COLUMN ref_date ;
------------------------------------------------------------------------------------------------

/*Giving more proper names to some columns*/

ALTER TABLE unemploymentCanada
ADD Province VARCHAR(50)

UPDATE UnemploymentCanada
SET Province = GEO

ALTER TABLE unemploymentCanada
DROP COLUMN GEO;

------------------------------------------------------------------------------------------------

/*Standarize the AGE GROUP*/
/*Divide the age grop from one big string to 2 values minimum age and maximum age or FROM AGE , TO AGE*/

SELECT "age group" ,LEFT("age group",2), RIGHT(LEFT("age group",PATINDEX('% YEARS%',"Age group")),3) 
FROM UnemploymentCanada;

ALTER TABLE unemploymentCanada
ADD fromAge int,
toAge INT;

UPDATE UnemploymentCanada
SET fromAge = CAST(LEFT("age group",2) AS INT),
toAge = CAST(RIGHT(LEFT("age group",PATINDEX('% YEARS%',"Age group")),3) AS INT);

ALTER TABLE unemploymentCanada
DROP COLUMN "age group";

------------------------------------------------------------------------------------------------

/*Standarize Employment related columns*/
ALTER TABLE unemploymentCanada
ADD employment_num DECIMAL(10,2),
	fullTime_Emp DECIMAL(10,2),
	labour_force DECIMAL(10,2),
	part_time_emp DECIMAL(10,2),
	population_total DECIMAL(10,2),
	unemployment_num DECIMAL(10,2),
	employment_rate DECIMAL(10,2),
	unemployment_rate DECIMAL(10,2),
	participation_rate DECIMAL(10,2);

UPDATE UnemploymentCanada
SET employment_num = TRY_CAST(employment AS decimal(10,2)),
	fullTime_Emp = TRY_CAST("Full-time employment" AS decimal(10,2)),
	labour_force = TRY_CAST("Labour force" AS decimal(10,2)),
	part_time_emp = TRY_CAST("Part-time employment " AS decimal(10,2)),
	population_total = TRY_CAST("Population" AS decimal(10,2)),
	unemployment_num = TRY_CAST(Unemployment AS decimal(10,2)),
	employment_rate = TRY_CAST("Employment rate" AS decimal(10,2)),
	participation_rate = TRY_CAST("Participation rate" AS decimal(10,2)),
	unemployment_rate = TRY_CAST("Unemployment rate" AS decimal(10,2));
	
	---Get rid of null values--
UPDATE UnemploymentCanada
SET "employment_num" = ISNULL("employment_num", 0),
"fullTime_Emp" = ISNULL("fullTime_Emp", 0),
"labour_force" = ISNULL("labour_force", 0),
"part_time_emp" = ISNULL("part_time_emp", 0),
"population_total" = ISNULL("population_total", 0),
"unemployment_num" = ISNULL("unemployment_num", 0),
"employment_rate" = ISNULL("employment_rate", 0),
"unemployment_rate" = ISNULL("unemployment_rate", 0),
"participation_rate" = ISNULL("participation_rate", 0);

ALTER TABLE unemploymentCanada
DROP COLUMN "employment",
"full-time employment",
"labour force",
"Part-time employment ",
"Population",
"Unemployment",
"Employment rate",
"Participation rate",
"Unemployment rate";

------------------------------------------------------------------------------------------------
/*Data analysis*/

SELECT year, AVG(employment_rate) OVER(PARTITION BY year ORDER BY year) ,AVG(unemployment_rate) OVER(PARTITION BY YEAR ORDER BY YEAR) 
FROM UnemploymentCanada

SELECT *
FROM UnemploymentCanada 
