/* Question 1: Try combining this query with a WHERE clause to find how many individual dogs completed tests after March 1, 2014 
(the answer should be 13,289): */

SELECT COUNT(DISTINCT Dog_Guid)
FROM complete_tests
WHERE created_at > '2014-03-01';

/* Question 2: To observe the second difference yourself first, count the number of rows in the dogs table using COUNT(*): */

SELECT COUNT(*)
FROM dogs;

/* Question 3: Now count the number of rows in the exclude column of the dogs table: */

SELECT COUNT(exclude)
FROM dogs;

/* Question 4: How many distinct dogs have an exclude flag in the dogs table (value will be "1")? (the answer should be 853) */

SELECT COUNT(DISTINCT dog_guid)
FROM dogs
WHERE exclude = 1;

/* Question 5: What is the average, minimum, and maximum ratings given to "Memory versus Pointing" game? (Your answer should be 
3.5584, 0, and 9, respectively) */

SELECT test_name, 
AVG(rating) AS AVG_Rating, 
MIN(rating) AS MIN_Rating, 
MAX(rating) AS MAX_Rating
FROM reviews
WHERE test_name="Memory versus Pointing";

/* Question 6: How would you query how much time it took to complete each test provided in the exam_answers table, in minutes? 
Title the column that represents this data "Duration." */

SELECT test_name,
TIMESTAMPDIFF(minute,start_time,end_time)AS Duration
FROM exam_answers
LIMIT 10;

/* Question 7: Include a column for Dog_Guid, start_time, and end_time in your query, and examine the output. Do you notice anything strange? */

SELECT test_name,
Dog_Guid,
start_time,
end_time,
TIMESTAMPDIFF(minute,start_time,end_time)AS Duration
FROM exam_answers
LIMIT 2000;

/* Question 8: What is the average amount of time it took customers to complete all of the tests in the exam_answers table, if you do not
exclude any data (the answer will be approximately 587 minutes)? */

SELECT
AVG(TIMESTAMPDIFF(minute,start_time,end_time))AS Duration
FROM exam_answers;

/* Question 9: What is the average amount of time it took customers to complete the "Treat Warm-Up" test, according to the exam_answers table
(about 165 minutes, if no data is excluded)? */

SELECT
test_name,
AVG(TIMESTAMPDIFF(minute,start_time,end_time))AS Duration
FROM exam_answers
WHERE test_name='Treat Warm-Up';

/* Question 10: How many possible test names are there in the exam_answers table? */

SELECT COUNT(DISTINCT test_name)
FROM exam_answers;

/* Question 11: What is the minimum and maximum value in the Duration column of your query that included the data from the entire table? */

SELECT
MIN(TIMESTAMPDIFF(minute,start_time,end_time))AS MIN,
MAX(TIMESTAMPDIFF(minute,start_time,end_time))AS MAX
FROM exam_answers;

/* Question 12: How many of these negative Duration entries are there? (the answer should be 620) */

SELECT COUNT(TIMESTAMPDIFF(minute,start_time,end_time)) as number
FROM exam_answers
WHERE TIMESTAMPDIFF(minute,start_time,end_time)<0;

/* Question 13: How would you query all the columns of all the rows that have negative durations so that you could examine whether they share any 
features that might give you clues about what caused the entry mistake? */

SELECT *
FROM exam_answers
WHERE TIMESTAMPDIFF(minute,start_time,end_time)<0;

/* Question 14: What is the average amount of time it took customers to complete all of the tests in the exam_answers table when the negative durations
are excluded from your calculation (you should get 11233 minutes)? */

SELECT
AVG(TIMESTAMPDIFF(minute,start_time,end_time))AS Duration
FROM exam_answers
WHERE TIMESTAMPDIFF(minute,start_time,end_time)>0;

