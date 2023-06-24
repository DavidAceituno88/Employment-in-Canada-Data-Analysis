 /*Clean Data*/
 SELECT column1 AS Name, 
		--I got the year from the original date format wich was dd-mm-yy--
		RIGHT(column2,2) AS Start_mandate, 
		/*Since the last minister is still elected there was a string in the End_mandate column, 
		so i need to replace any string with the actual year ex "Still elected"  in the end_mandate column*/
		CASE WHEN column3 NOT LIKE '[a-z]%' 
		THEN RIGHT(column3,2) ELSE 2023 END AS End_mandate, column5 AS Political_party
  INTO primeMinisters
  FROM primeMinistersTbl
  /*I got rid of the ministers from the 1800s, get rid of those weird duplicates with text related to the prime minister
  and lastly we get rid of a weird Pierre Trudeao duplicate column*/
  WHERE column2 NOT LIKE '%18%' AND column2 LIKE '[0-9]%' AND column2 NOT LIKE '% [A-Z]%'

  -------------------------------------------- DATE CHALLENGE!!!!--------------------------------------------
 /*Challenges:Date format and different centuries
 Since in the original wikipedia table the date format came in dd-mm-yy and the dates where from the 1800s
 I faced two challenges:
 1) First the date format from wikipedia came in dd-mm-yy
 When i trimmed it i had to keep it as a string, because if i Casted it into an INT
 it will eliminate the zeros on the left and then complicate my second challenge
 
 2) Adding the prefix 19 or 20 TO THE YEAR: Since the dates that where from the 1900s to the present date
	i had to tell SQL how to differenciate wich years should be 19 + YEAR OR 20 + YEAR
	SOLUTION: 
		1- ADD A "ORDER" Column wich will be an auto increment on the order of Ministers 
		2- Get the max Year why? because the max year from the last century will be bigger 
		than the actual year.
		3- Then get the Order number of that year field 
		4- Compare if the year's ORDER value is bigger than the MAX(YEAR)'s ORDER value then add 20
		Else add 19
	*/
--Step 1--
 ALTER TABLE primeMinisters
 ADD Number int IDENTITY(1,1)
 /*Step 2 and 3 Get the max(Number) from the MAX(YEAR) (because i was getting more than one max year)
	Name it lastCentury*/
 WITH CTE AS(
 SELECT MAX(number) AS lastCentury 
 FROM primeMinisters
 WHERE start_mandate = (SELECT MAX(Start_mandate) FROM primeMinisters)
 )
 SELECT Name, CASE WHEN number > (SELECT lastCentury FROM CTE) --STEP 4 for start_mandate and end_mandate
			 THEN CAST(('20'+start_mandate) AS INT ) ELSE CAST(('19'+Start_mandate) AS INT)
			 END AS start_mandate,
			 CASE WHEN number < (SELECT lastCentury FROM CTE)
			 THEN CAST(('1900'+End_mandate) AS INT)
			 WHEN end_mandate = 2023 THEN End_mandate
			 ELSE CAST(('2000'+End_mandate) AS INT)
			 END AS end_mandate
			 --Clean the political party column get rid of any "(ahdaisudha iasduhasd)"--
			,LEFT(Political_party, CHARINDEX('(',Political_party+'(') -1) as Political_party
		INTO primeMinistersClean
FROM primeMinisters

SELECT * FROM primeMinistersClean

 
  
