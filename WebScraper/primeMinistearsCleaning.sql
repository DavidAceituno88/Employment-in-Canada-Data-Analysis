 /*Clean Data*/
 SELECT column1 AS Name, 
		--We get the year from the original date format wich was dd-mm-yy--
		RIGHT(column2,2) AS Start_mandate, 
		/*Since the last minister is still elected there was a string in the End_mandate field, 
		so we need to replace any string with the actual year*/
		CASE WHEN column3 NOT LIKE '[a-z]%' 
		THEN RIGHT(column3,2) ELSE 2023 END AS End_mandate, column5 AS Political_party
  INTO primeMinisters
  FROM primeMinistersTbl
  /*We get rid of the ministers from the 1800s, get rid of those weird duplicates with text related to the prime minister
  and lastly we get rid of a weird Pierre Trudeao duplicate column*/
  WHERE column2 NOT LIKE '%18%' AND column2 LIKE '[0-9]%' AND column2 NOT LIKE '% [A-Z]%'

 ALTER TABLE primeMinisters
 ADD Number int IDENTITY(1,1)

 WITH CTE AS(
 SELECT MAX(number) AS lastCentury 
 FROM primeMinisters
 WHERE start_mandate = (SELECT MAX(Start_mandate) FROM primeMinisters)
 )
 SELECT Name, CASE WHEN number > (SELECT lastCentury FROM CTE)
			 THEN '20'+start_mandate ELSE '19'+Start_mandate
			END AS start_mandate,
			CASE WHEN number < (SELECT lastCentury FROM CTE)
			 THEN '1900'+End_mandate ELSE '2000'+End_mandate
			END AS end_mandate
			,Political_party
FROM primeMinisters

 SELECT *
  FROM primeMinisters
