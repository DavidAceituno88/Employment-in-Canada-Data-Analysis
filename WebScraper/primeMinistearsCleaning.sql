 /*Clean Data*/
 SELECT column1 AS Name, 
		--We get the year from the original date format wich was dd-mm-yy--
		RIGHT(column2,2) AS Start_mandate, 
		/*Since the last minister is still elected there was a string in the End_mandate field, 
		so we need to replace any string with the actual year*/
		CASE WHEN column3 NOT LIKE '[a-z]%' 
		THEN RIGHT(column3,2) ELSE 2023 END AS End_mandate, column5 AS Political_party
  FROM primeMinistersTbl
  /*We get rid of the ministers from the 1800s, get rid of those weird duplicates with text related to the prime minister
  and lastly we get rid of a weird Pierre Trudeao duplicate column*/
  WHERE column2 NOT LIKE '%18%' AND column2 LIKE '[0-9]%' AND column2 NOT LIKE '% [A-Z]%'

  /*SELECT THE MAX DATE 
  ASSIGN A FLAG TO THAT FIELD AND THOSE BEFORE THAT ROW
  */ 
  