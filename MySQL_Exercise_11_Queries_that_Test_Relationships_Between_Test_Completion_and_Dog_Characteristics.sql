/* Question 1: To get a feeling for what kind of values exist in the Dognition personality dimension column, write a query that will
output all of the distinct values in the dimension column. Use your relational schema or the course materials to determine what table
the dimension column is in. Your output should have 11 rows. */

SELECT DISTINCT dimension
FROM dogs;

/* Question 2: Use the equijoin syntax (described in MySQL Exercise 8) to write a query that will output the Dognition personality
dimension and total number of tests completed by each unique DogID. This query will be used as an inner subquery in the next question.
LIMIT your output to 100 rows for troubleshooting purposes. */

SELECT dogs.dimension, dogs.dog_guid, count(complete_tests.created_at)
FROM dogs, complete_tests
WHERE dogs.dog_guid=complete_tests.dog_guid
GROUP BY dogs.dog_guid
LIMIT 100;

/* Question 3: Re-write the query in Question 2 using traditional join syntax (described in MySQL Exercise 8). */

SELECT dogs.dimension, dogs.dog_guid, count(complete_tests.created_at)
FROM dogs JOIN complete_tests
ON dogs.dog_guid=complete_tests.dog_guid
GROUP BY dogs.dog_guid
LIMIT 100;

/* Question 4: To start, write a query that will output the average number of tests completed by unique dogs in each Dognition personality
dimension. Choose either the query in Question 2 or 3 to serve as an inner query in your main query. If you have trouble, make sure you
use the appropriate aliases in your GROUP BY and SELECT statements. */

SELECT dimension, AVG(Count_Test.numtests) AS avg_test_completed
FROM
(SELECT dogs.dimension AS dimension, dogs.dog_guid AS dogID, count(complete_tests.created_at) AS numtests
FROM dogs, complete_tests
WHERE dogs.dog_guid=complete_tests.dog_guid
GROUP BY dogID) AS Count_Test
GROUP BY Count_Test.dimension;

/* Question 5: How many unique DogIDs are summarized in the Dognition dimensions labeled "None" or ""? (You should retrieve values of 13,705 and 71) */

SELECT dimension, count(DISTINCT dog_guid) AS num_dogs
FROM (SELECT dogs.dog_guid, dogs.dimension AS dimension
FROM dogs JOIN complete_tests
ON dogs.dog_guid=complete_tests.dog_guid
WHERE dimension IS NULL OR dimension=''
GROUP BY dogs.dog_guid) AS dogs_in_complete_tests 
GROUP BY dimension;

/* Question 6: To determine whether there are any features that are common to all dogs that have non-NULL empty strings in the dimension column,
write a query that outputs the breed, weight, value in the "exclude" column, first or minimum time stamp in the complete_tests table, last or maximum
time stamp in the complete_tests table, and total number of tests completed by each unique DogID that has a non-NULL empty string in the dimension column. */

SELECT dogs.breed AS breed, dogs.weight AS weight, dogs.exclude AS exclude, 
MIN(complete_tests.created_at) AS minimum, MAX(complete_tests.created_at) AS maximum, 
count(complete_tests.created_at) AS numtests
FROM dogs JOIN complete_tests
ON dogs.dog_guid=complete_tests.dog_guid
WHERE dogs.dimension=''
GROUP BY dogs.dog_guid;

/* Question 7: Rewrite the query in Question 4 to exclude DogIDs with (1) non-NULL empty strings in the dimension column, (2) NULL values in the dimension column,
and (3) values of "1" in the exclude column. NOTES AND HINTS: You cannot use a clause that says d.exclude does not equal 1 to remove rows that have exclude flags,
because Dognition clarified that both NULL values and 0 values in the "exclude" column are valid data. A clause that says you should only include values that are
not equal to 1 would remove the rows that have NULL values in the exclude column, because NULL values are never included in equals statements (as we learned in the
join lessons). In addition, although it should not matter for this query, practice including parentheses with your OR and AND statements that accurately reflect the
logic you intend. Your results should return 402 DogIDs in the ace dimension and 626 dogs in the charmer dimension. */

SELECT dimension, AVG(Count_Test.numtests) AS avg_test_completed, COUNT(distinct dogID) AS Num_dogs
FROM
(SELECT dogs.dimension AS dimension, dogs.dog_guid AS dogID, count(complete_tests.created_at) AS numtests
FROM dogs JOIN complete_tests
ON dogs.dog_guid=complete_tests.dog_guid
WHERE (dogs.exclude='0'OR dogs.exclude IS NULL) AND (dogs.dimension!='' OR dogs.dimension IS NOT NULL)
GROUP BY dogID) AS Count_Test
GROUP BY Count_Test.dimension;

/* Questions 8: Write a query that will output all of the distinct values in the breed_group field. */

SELECT DISTINCT breed_group
FROM dogs;

/* Question 9: Write a query that outputs the breed, weight, value in the "exclude" column, first or minimum time stamp in the complete_tests table, last or
maximum time stamp in the complete_tests table, and total number of tests completed by each unique DogID that has a NULL value in the breed_group column. */

SELECT dogs.breed AS breed, dogs.weight AS weight, dogs.exclude AS exclude, 
MIN(complete_tests.created_at) AS minimum, MAX(complete_tests.created_at) AS maximum, 
count(complete_tests.created_at) AS numtests
FROM dogs JOIN complete_tests
ON dogs.dog_guid=complete_tests.dog_guid
WHERE dogs.breed_group IS NULL
GROUP BY dogs.dog_guid;

/* Question 10: Adapt the query in Question 7 to examine the relationship between breed_group and number of tests completed. Exclude DogIDs with values of "1"
 in the exclude column. Your results should return 1774 DogIDs in the Herding breed group. */

 SELECT breed_group, AVG(Count_Test.numtests) AS avg_test_completed, COUNT(distinct dogID) AS Num_dogs
FROM
(SELECT dogs.breed_group AS breed_group, dogs.dog_guid AS dogID, count(complete_tests.created_at) AS numtests
FROM dogs JOIN complete_tests
ON dogs.dog_guid=complete_tests.dog_guid
WHERE dogs.exclude='0'OR dogs.exclude IS NULL 
GROUP BY dogID) AS Count_Test
GROUP BY Count_Test.breed_group;

/* Question 11: Adapt the query in Question 10 to only report results for Sporting, Hound, Herding, and Working breed_groups using an IN clause. */

SELECT breed_group, AVG(Count_Test.numtests) AS avg_test_completed, COUNT(distinct dogID) AS Num_dogs
FROM
(SELECT dogs.breed_group AS breed_group, dogs.dog_guid AS dogID, count(complete_tests.created_at) AS numtests
FROM dogs JOIN complete_tests
ON dogs.dog_guid=complete_tests.dog_guid
WHERE dogs.exclude='0'OR dogs.exclude IS NULL 
GROUP BY dogID) AS Count_Test
WHERE Count_Test.breed_group IN ('Sporting','Hound','Herding', 'Working')
GROUP BY Count_Test.breed_group;

/* Question 12: Begin by writing a query that will output all of the distinct values in the breed_type field. */

SELECT DISTINCT breed_type
FROM dogs;

/* Question 13: Adapt the query in Question 7 to examine the relationship between breed_type and number of tests completed. Exclude 
DogIDs with values of "1" in the exclude column. Your results should return 8865 DogIDs in the Pure Breed group. */

SELECT breed_type, AVG(Count_Test.numtests) AS avg_test_completed, COUNT(distinct dogID) AS Num_dogs
FROM
(SELECT dogs.breed_type AS breed_type, dogs.dog_guid AS dogID, count(complete_tests.created_at) AS numtests
FROM dogs JOIN complete_tests
ON dogs.dog_guid=complete_tests.dog_guid
WHERE dogs.exclude='0'OR dogs.exclude IS NULL 
GROUP BY dogID) AS Count_Test
GROUP BY Count_Test.breed_type;

/* Question 14: For each unique DogID, output its dog_guid, breed_type, number of completed tests, and use a CASE statement to include
an extra column with a string that reads "Pure_Breed" whenever breed_type equals 'Pure Breed" and "Not_Pure_Breed" whenever breed_type
equals anything else. LIMIT your output to 50 rows for troubleshooting. */

SELECT dogs.dog_guid AS dogID, dogs.breed_type AS breed_type,
CASE dogs.breed_type
WHEN 'Pure Breed' then 'pure_breed' 
ELSE 'not_Pure_Breed'
END AS pure_breed,
count(complete_tests.created_at) AS numtests
FROM dogs JOIN complete_tests
ON dogs.dog_guid=complete_tests.dog_guid
GROUP BY dogID
LIMIT 50;

/* Question 15: Adapt your queries from Questions 7 and 14 to examine the relationship between breed_type and number of tests completed by
Pure_Breed dogs and non_Pure_Breed dogs. Your results should return 8336 DogIDs in the Not_Pure_Breed group. */

SELECT numtests_per_dog.pure_breed AS pure_breed, AVG(numtests_per_dog.numtests) AS avg_test_completed, 
COUNT(distinct dogID) AS Num_dogs
FROM
(SELECT dogs.dog_guid AS dogID, dogs.breed_type AS breed_type,
CASE dogs.breed_type
WHEN 'Pure Breed' then 'pure_breed' 
ELSE 'not_Pure_Breed'
END AS pure_breed,
count(complete_tests.created_at) AS numtests
FROM dogs JOIN complete_tests
ON dogs.dog_guid=complete_tests.dog_guid
WHERE dogs.exclude IS NULL OR dogs.exclude=0
GROUP BY dogID) AS numtests_per_dog
GROUP BY pure_breed;

/* Question 16: Adapt your query from Question 15 to examine the relationship between breed_type, whether or not a dog was neutered (indicated in
the dog_fixed field), and number of tests completed by Pure_Breed dogs and non_Pure_Breed dogs. There are DogIDs with null values in the
dog_fixed column, so your results should have 6 rows, and the average number of tests completed by non-pure-breeds who are neutered is 10.5681. */

SELECT numtests_per_dog.pure_breed AS pure_breed, neutered,
AVG(numtests_per_dog.numtests) AS avg_test_completed, 
COUNT(distinct dogID) AS Num_dogs
FROM
(SELECT dogs.dog_guid AS dogID, dogs.breed_type AS breed_type, dogs.dog_fixed AS neutered,
CASE dogs.breed_type
WHEN 'Pure Breed' then 'pure_breed' 
ELSE 'not_Pure_Breed'
END AS pure_breed,
count(complete_tests.created_at) AS numtests
FROM dogs JOIN complete_tests
ON dogs.dog_guid=complete_tests.dog_guid
WHERE dogs.exclude IS NULL OR dogs.exclude=0
GROUP BY dogID) AS numtests_per_dog
GROUP BY pure_breed, neutered;

/* Question 17: Adapt your query from Question 7 to include a column with the standard deviation for the number of tests completed by each Dognition
personality dimension. */

SELECT dimension, AVG(Count_Test.numtests) AS avg_test_completed, COUNT(distinct dogID) AS Num_dogs,
STDDEV(Count_Test.numtests) AS STDEV
FROM
(SELECT dogs.dimension AS dimension, dogs.dog_guid AS dogID, count(complete_tests.created_at) AS numtests
FROM dogs JOIN complete_tests
ON dogs.dog_guid=complete_tests.dog_guid
WHERE (dogs.exclude='0'OR dogs.exclude IS NULL) AND (dogs.dimension!='' OR dogs.dimension IS NOT NULL)
GROUP BY dogID) AS Count_Test
GROUP BY Count_Test.dimension;

/* Question 18: Write a query that calculates the average amount of time it took each dog breed_type to complete all of the tests in the exam_answers
table. Exclude negative durations from the calculation, and include a column that calculates the standard deviation of durations for each breed_type
group: */

SELECT dogs.breed_type AS breed_type, AVG(TIMESTAMPDIFF(minute,exam_answers.start_time,exam_answers.end_time)) 
AS AVG_duration, STDDEV(TIMESTAMPDIFF(minute,exam_answers.start_time,exam_answers.end_time)) AS STDDEV_Duration
FROM dogs JOIN exam_answers
ON dogs.dog_guid=exam_answers.dog_guid
WHERE TIMESTAMPDIFF(minute,exam_answers.start_time,exam_answers.end_time)>=0
GROUP BY breed_type;


