/* Question 1: Using the function you found in the websites above, write a query that
will output one column with the original created_at time stamp from each row in the
completed_tests table, and another column with a number that represents the day of the 
week associated with each of those time stamps. Limit your output to 200 rows starting
at row 50. */

SELECT created_at, DAYOFWEEK(created_at)
FROM complete_tests
LIMIT 49, 200;

/* Question 2: Include a CASE statement in the query you wrote in Question 1 to output a 
third column that provides the weekday name (or an appropriate abbreviation) associated
with each created_at time stamp. */

SELECT created_at, DAYOFWEEK(created_at),
CASE
WHEN DAYOFWEEK(created_at)="1" THEN "Sunday"
WHEN DAYOFWEEK(created_at)="2" THEN "Monday"
WHEN DAYOFWEEK(created_at)="3" THEN "Tuesday"
WHEN DAYOFWEEK(created_at)="4" THEN "Wednesday"
WHEN DAYOFWEEK(created_at)="5" THEN "Thursday"
WHEN DAYOFWEEK(created_at)="6" THEN "Friday"
WHEN DAYOFWEEK(created_at)="7" THEN "Saturday"
END AS Day
FROM complete_tests
LIMIT 49, 200;

/* Question 3: Adapt the query you wrote in Question 2 to report the total number of tests 
completed on each weekday. Sort the results by the total number of tests completed in 
descending order. You should get a total of 33,190 tests in the Sunday row of your output. */

SELECT COUNT(created_at) AS numTests,
(CASE
WHEN DAYOFWEEK(created_at)="1" THEN "Sunday"
WHEN DAYOFWEEK(created_at)="2" THEN "Monday"
WHEN DAYOFWEEK(created_at)="3" THEN "Tuesday"
WHEN DAYOFWEEK(created_at)="4" THEN "Wednesday"
WHEN DAYOFWEEK(created_at)="5" THEN "Thursday"
WHEN DAYOFWEEK(created_at)="6" THEN "Friday"
WHEN DAYOFWEEK(created_at)="7" THEN "Saturday"
END) AS Day
FROM complete_tests
GROUP BY Day
ORDER BY numTests DESC;

/* Question 4: Rewrite the query in Question 3 to exclude the dog_guids that have a value of
"1" in the exclude column (Hint: this query will require a join.) This time you should get a
total of 31,092 tests in the Sunday row of your output. */

SELECT DAYOFWEEK(complete_tests.created_at), COUNT(complete_tests.created_at) AS numTests,
(CASE
WHEN DAYOFWEEK(complete_tests.created_at)="1" THEN "Sunday"
WHEN DAYOFWEEK(complete_tests.created_at)="2" THEN "Monday"
WHEN DAYOFWEEK(complete_tests.created_at)="3" THEN "Tuesday"
WHEN DAYOFWEEK(complete_tests.created_at)="4" THEN "Wednesday"
WHEN DAYOFWEEK(complete_tests.created_at)="5" THEN "Thursday"
WHEN DAYOFWEEK(complete_tests.created_at)="6" THEN "Friday"
WHEN DAYOFWEEK(complete_tests.created_at)="7" THEN "Saturday"
END) AS Day
FROM complete_tests join dogs
ON complete_tests.dog_guid=dogs.dog_guid
WHERE dogs.exclude=0 OR dogs.exclude IS NULL
GROUP BY Day
ORDER BY numTests DESC;

/* Question 5: Write a query to retrieve all the dog_guids common to the dogs and users table
using the traditional inner join syntax (your output will have 950,331 rows). */

SELECT dogs.dog_guid
FROM dogs JOIN users
ON dogs.user_guid=users.user_guid;

/* Question 6: Write a query to retrieve all the distinct dog_guids common to the dogs and users
table using the traditional inner join syntax (your output will have 35,048 rows). */

SELECT DISTINCT dogs.dog_guid
FROM dogs JOIN users
ON dogs.user_guid=users.user_guid;

/* Question 7: Start by writing a query that retrieves distinct dog_guids common to the dogs and
users table, excuding dog_guids and user_guids with a "1" in their respective exclude columns
(your output will have 34,121 rows). */

SELECT DISTINCT dogs.dog_guid
FROM dogs JOIN users
ON dogs.user_guid=users.user_guid
WHERE (dogs.exclude=0 OR dogs.exclude IS NULL) AND (users.exclude=0 OR users.exclude IS NULL);

/* Question 8: Now adapt your query from Question 4 so that it inner joins on the result of the
subquery you wrote in Question 7 instead of the dogs table. This will give you a count of the number
of tests completed on each day of the week, excluding all of the dog_guids and user_guids that the
Dognition team flagged in the exclude columns. */

SELECT DAYOFWEEK(complete_tests.created_at), COUNT(complete_tests.created_at) AS numTests,
(CASE
WHEN DAYOFWEEK(complete_tests.created_at)="1" THEN "Sunday"
WHEN DAYOFWEEK(complete_tests.created_at)="2" THEN "Monday"
WHEN DAYOFWEEK(complete_tests.created_at)="3" THEN "Tuesday"
WHEN DAYOFWEEK(complete_tests.created_at)="4" THEN "Wednesday"
WHEN DAYOFWEEK(complete_tests.created_at)="5" THEN "Thursday"
WHEN DAYOFWEEK(complete_tests.created_at)="6" THEN "Friday"
WHEN DAYOFWEEK(complete_tests.created_at)="7" THEN "Saturday"
END) AS Day
FROM complete_tests JOIN
(SELECT DISTINCT dog_guid
FROM dogs JOIN users
ON dogs.user_guid=users.user_guid
WHERE (dogs.exclude=0 OR dogs.exclude IS NULL) AND (users.exclude=0 OR users.exclude IS NULL)) AS dog_cleaned
ON complete_tests.dog_guid=dog_cleaned.dog_guid
GROUP BY Day
ORDER BY numTests DESC;

/* Question 9: Adapt your query from Question 8 to provide a count of the number of tests completed on
each weekday of each year in the Dognition data set. Exclude all dog_guids and user_guids with a value
of "1" in their exclude columns. Sort the output by year in ascending order, and then by the total number
of tests completed in descending order. */

SELECT DAYOFWEEK(complete_tests.created_at) AS dayasnum,YEAR(complete_tests.created_at) AS Year,
COUNT(complete_tests.created_at) AS numTests,
(CASE
WHEN DAYOFWEEK(complete_tests.created_at)="1" THEN "Sunday"
WHEN DAYOFWEEK(complete_tests.created_at)="2" THEN "Monday"
WHEN DAYOFWEEK(complete_tests.created_at)="3" THEN "Tuesday"
WHEN DAYOFWEEK(complete_tests.created_at)="4" THEN "Wednesday"
WHEN DAYOFWEEK(complete_tests.created_at)="5" THEN "Thursday"
WHEN DAYOFWEEK(complete_tests.created_at)="6" THEN "Friday"
WHEN DAYOFWEEK(complete_tests.created_at)="7" THEN "Saturday"
END) AS Day
FROM complete_tests JOIN
(SELECT DISTINCT dog_guid
FROM dogs JOIN users
ON dogs.user_guid=users.user_guid
WHERE (dogs.exclude=0 OR dogs.exclude IS NULL) AND (users.exclude=0 OR users.exclude IS NULL)) AS dog_cleaned
ON complete_tests.dog_guid=dog_cleaned.dog_guid
GROUP BY Year, Day
ORDER BY Year ASC, numTests DESC;

/* Question 10: First, adapt your query from Question 9 so that you only examine customers located in the United States,
with Hawaii and Alaska residents excluded. HINTS: In this data set, the abbreviation for the United States is "US", the
abbreviation for Hawaii is "HI" and the abbreviation for Alaska is "AK". You should have 5,916 tests completed on Sunday
of 2013. */

SELECT DAYOFWEEK(complete_tests.created_at) AS dayasnum,YEAR(complete_tests.created_at) AS Year,
COUNT(complete_tests.created_at) AS numTests,
(CASE
WHEN DAYOFWEEK(complete_tests.created_at)="1" THEN "Sunday"
WHEN DAYOFWEEK(complete_tests.created_at)="2" THEN "Monday"
WHEN DAYOFWEEK(complete_tests.created_at)="3" THEN "Tuesday"
WHEN DAYOFWEEK(complete_tests.created_at)="4" THEN "Wednesday"
WHEN DAYOFWEEK(complete_tests.created_at)="5" THEN "Thursday"
WHEN DAYOFWEEK(complete_tests.created_at)="6" THEN "Friday"
WHEN DAYOFWEEK(complete_tests.created_at)="7" THEN "Saturday"
END) AS Day
FROM complete_tests JOIN
(SELECT DISTINCT dog_guid
FROM dogs JOIN users
ON dogs.user_guid=users.user_guid
WHERE ((dogs.exclude=0 OR dogs.exclude IS NULL)
AND (users.exclude=0 OR users.exclude IS NULL) 
AND users.country="US"
AND (users.state!="HI" AND users.state!="AK"))) AS dog_cleaned
ON complete_tests.dog_guid=dog_cleaned.dog_guid
GROUP BY Year, Day
ORDER BY Year ASC, numTests DESC;

/* Question 11: Write a query that extracts the original created_at time stamps for rows in the complete_tests table
in one column, and the created_at time stamps with 6 hours subtracted in another column. Limit your output to 100 rows. */

SELECT created_at, DATE_SUB(created_at,INTERVAL 6 HOUR)
FROM complete_tests
LIMIT 100;

/* Question 12: Use your query from Question 11 to adapt your query from Question 10 in order to provide a count of the number
of tests completed on each day of the week, with approximate time zones taken into account, in each year in the Dognition 
data set. Exclude all dog_guids and user_guids with a value of "1" in their exclude columns. Sort the output by year in ascending
order, and then by the total number of tests completed in descending order. HINT: Don't forget to adjust for the time zone in your
DAYOFWEEK statement and your CASE statement. */

SELECT DAYOFWEEK(DATE_SUB(created_at,INTERVAL 6 HOUR)) AS dayasnum,YEAR(complete_tests.created_at) AS Year,
COUNT(complete_tests.created_at) AS numTests,
(CASE
WHEN DAYOFWEEK(DATE_SUB(created_at,INTERVAL 6 HOUR))="1" THEN "Sunday"
WHEN DAYOFWEEK(DATE_SUB(created_at,INTERVAL 6 HOUR))="2" THEN "Monday"
WHEN DAYOFWEEK(DATE_SUB(created_at,INTERVAL 6 HOUR))="3" THEN "Tuesday"
WHEN DAYOFWEEK(DATE_SUB(created_at,INTERVAL 6 HOUR))="4" THEN "Wednesday"
WHEN DAYOFWEEK(DATE_SUB(created_at,INTERVAL 6 HOUR))="5" THEN "Thursday"
WHEN DAYOFWEEK(DATE_SUB(created_at,INTERVAL 6 HOUR))="6" THEN "Friday"
WHEN DAYOFWEEK(DATE_SUB(created_at,INTERVAL 6 HOUR))="7" THEN "Saturday"
END) AS Day
FROM complete_tests JOIN
(SELECT DISTINCT dog_guid
FROM dogs JOIN users
ON dogs.user_guid=users.user_guid
WHERE ((dogs.exclude=0 OR dogs.exclude IS NULL)
AND (users.exclude=0 OR users.exclude IS NULL) 
AND users.country="US"
AND (users.state!="HI" AND users.state!="AK"))) AS dog_cleaned
ON complete_tests.dog_guid=dog_cleaned.dog_guid
GROUP BY Year, Day
ORDER BY Year ASC, numTests DESC;

/* Question 13: Adapt your query from Question 12 so that the results are sorted by year in ascending order, and then by the day of
the week in the following order: Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday. */

SELECT YEAR(complete_tests.created_at) AS Year,
(CASE
WHEN DAYOFWEEK(DATE_SUB(created_at,INTERVAL 6 HOUR))="1" THEN "Sunday"
WHEN DAYOFWEEK(DATE_SUB(created_at,INTERVAL 6 HOUR))="2" THEN "Monday"
WHEN DAYOFWEEK(DATE_SUB(created_at,INTERVAL 6 HOUR))="3" THEN "Tuesday"
WHEN DAYOFWEEK(DATE_SUB(created_at,INTERVAL 6 HOUR))="4" THEN "Wednesday"
WHEN DAYOFWEEK(DATE_SUB(created_at,INTERVAL 6 HOUR))="5" THEN "Thursday"
WHEN DAYOFWEEK(DATE_SUB(created_at,INTERVAL 6 HOUR))="6" THEN "Friday"
WHEN DAYOFWEEK(DATE_SUB(created_at,INTERVAL 6 HOUR))="7" THEN "Saturday"
END) AS Day,
COUNT(complete_tests.created_at) AS numTests
FROM complete_tests JOIN
(SELECT DISTINCT dog_guid
FROM dogs JOIN users
ON dogs.user_guid=users.user_guid
WHERE ((dogs.exclude=0 OR dogs.exclude IS NULL)
AND (users.exclude=0 OR users.exclude IS NULL) 
AND users.country="US"
AND (users.state!="HI" AND users.state!="AK"))) AS dog_cleaned
ON complete_tests.dog_guid=dog_cleaned.dog_guid
GROUP BY Year, Day
ORDER BY Year ASC, FIELD(Day,"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday");

/* Question 14: Which 5 states within the United States have the most Dognition customers, once all dog_guids and user_guids with
a value of "1" in their exclude columns are removed? Try using the following general strategy: count how many unique user_guids are
associated with dogs in the complete_tests table, break up the counts according to state, sort the results by counts of unique
user_guids in descending order, and then limit your output to 5 rows. California ("CA") and New York ("NY") should be at the top of
your list. */

SELECT dog_cleaned.state AS State,
COUNT(DISTINCT dog_cleaned.user_guid) AS numUsers
FROM complete_tests JOIN
(SELECT DISTINCT dog_guid, users.user_guid, users.state
FROM dogs JOIN users
ON dogs.user_guid=users.user_guid
WHERE ((dogs.exclude=0 OR dogs.exclude IS NULL)
AND (users.exclude=0 OR users.exclude IS NULL)
AND users.country="US")) AS dog_cleaned
ON complete_tests.dog_guid=dog_cleaned.dog_guid
GROUP BY State
ORDER BY numUsers DESC
LIMIT 5;
 
/* Question 15: Which 10 countries have the most Dognition customers, once all dog_guids and user_guids with a value of "1" in their exclude
columns are removed? HINT: don't forget to remove the u.country="US" statement from your WHERE clause. */

SELECT dog_cleaned.country AS Country,
COUNT(DISTINCT dog_cleaned.user_guid) AS numUsers
FROM complete_tests JOIN
(SELECT DISTINCT dog_guid, users.user_guid, users.country
FROM dogs JOIN users
ON dogs.user_guid=users.user_guid
WHERE ((dogs.exclude=0 OR dogs.exclude IS NULL)
AND (users.exclude=0 OR users.exclude IS NULL))) AS dog_cleaned
ON complete_tests.dog_guid=dog_cleaned.dog_guid
GROUP BY Country
ORDER BY numUsers DESC
LIMIT 10;

