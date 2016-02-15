/* Here's an example of a different query we used in the last lesson that employed the equijoin syntax:
SELECT d.user_guid AS UserID, d.dog_guid AS DogID, 
       d.breed, d.breed_type, d.breed_group
FROM dogs d, complete_tests c
WHERE d.dog_guid=c.dog_guid AND test_name='Yawn Warm-up';
Question 1: How would you re-write this query using the traditional join syntax? */

SELECT d.user_guid AS UserID, d.dog_guid AS DogID, 
       d.breed, d.breed_type, d.breed_group
FROM dogs d JOIN complete_tests c
    ON d.dog_guid=c.dog_guid
WHERE test_name='Yawn Warm-up';

/* The inner join we executed resulted in 389 rows of output, because it only included the data from rows that have equivalent values
in both tables being joined. But what if we wanted the full list of dogs in the reviews table and an indication of whether or not they
were in the dogs table, rather than only a list of review information from dogs in the dogs table? To achieve this list, we could execute
an outer join.
Let's start by using a left outer join to get the list we want. When we use the traditional join syntax to write inner joins, the order
you enter the tables in your query doesn't matter. In outer joins, however, the order matters a lot. A left outer join will include all 
of the rows of the table to the left of the ON clause. A right outer join will include all of the rows of the table to the right of the
ON clause. So in order to retrieve a full list of dogs who completed at least 10 tests in the reviews table, and include as much breed
information as possible, we could query:
SELECT r.dog_guid AS rDogID, d.dog_guid AS dDogID, r.user_guid AS rUserID, d.user_guid AS dUserID, AVG(r.rating) AS AvgRating,
COUNT(r.rating) AS NumRatings, d.breed, d.breed_group, d.breed_type
FROM reviews r LEFT JOIN dogs d
  ON r.dog_guid=d.dog_guid AND r.user_guid=d.user_guid
WHERE r.dog_guid IS NOT NULL
GROUP BY r.dog_guid
HAVING NumRatings >= 10
ORDER BY AvgRating DESC;
Question 2: How could you retrieve this same information using a RIGHT JOIN? */

SELECT r.dog_guid AS rDogID, d.dog_guid AS dDogID, r.user_guid AS rUserID,
d.user_guid AS dUserID, AVG(r.rating) AS AvgRating, COUNT(r.rating) AS
NumRatings, d.breed, d.breed_group, d.breed_type
FROM dogs d RIGHT JOIN reviews r
ON d.dog_guid=r.dog_guid AND d.user_guid=r.user_guid
WHERE r.dog_guid IS NOT NULL
GROUP BY r.dog_guid
HAVING NumRatings >= 10
ORDER BY AvgRating DESC;

/* Question 4: Repeat the query you ran in Question 3, but intentionally use the dog_guids from the completed_tests table to group your
results instead of the dog_guids from the dogs table. (Your output should contain 17987 rows) */

SELECT d.dog_guid AS dDogID, t.dog_guid AS tDogID, d.user_guid AS dUserID, t.user_guid AS tUserID,
COUNT(test_name) AS number_test
FROM dogs d LEFT JOIN complete_tests t
    ON d.dog_guid=t.dog_guid 
GROUP BY t.dog_guid;

/* Question 5: Write a query using COUNT DISTINCT to determine how many distinct dog_guids there are in the completed_tests table. */

SELECT COUNT(DISTINCT dog_guid)
FROM complete_tests;

/* Question 6: We want to extract all of the breed information of every dog a user_guid in the users table owns. If a user_guid in the
users table does not own a dog, we want that information as well. Write a query that would return this information. Include the dog_guid
from the dogs table, and user_guid from both the users and dogs tables in your output. (HINT: you should get 952557 rows in your output!) */

SELECT d.dog_guid, d.user_guid, u.user_guid, d.breed
FROM users u LEFT JOIN dogs d
ON d.user_guid=u.user_guid;

/* Question 7: Adapt the query you wrote above so that it counts the number of rows the join will output per user_id. Sort the results by 
this count in descending order. Remember that if you include dog_guid or breed fields in this query, they will be randomly populated by only
one of the values associated with a user_guid (see MySQL Exercise 6; there should be 33,193 rows in your output). */

SELECT d.dog_guid, d.user_guid, u.user_guid, d.breed, COUNT(*) AS numrows
FROM users u LEFT JOIN dogs d
ON d.user_guid=u.user_guid
GROUP BY u.user_guid
ORDER BY numrows DESC;

/* Question 8: How many rows in the users table are associated with user_guid 'ce225842-7144-11e5-ba71-058fbc01cf0b'? */

SELECT user_guid, COUNT(*) AS Countrows
FROM users
WHERE user_guid ='ce225842-7144-11e5-ba71-058fbc01cf0b';

/* Question 9: Examine all the rows in the dogs table that are associated with user_guid 'ce225842-7144-11e5-ba71-058fbc01cf0b'? */

SELECT *
FROM dogs
WHERE user_guid ='ce225842-7144-11e5-ba71-058fbc01cf0b';

/* Question 10: How would you write a query that used a left join to return the number of distinct user_guids that were in the users
table, but not the dogs table (your query should return a value of 2226)? */

SELECT COUNT(DISTINCT u.user_guid)
FROM users u LEFT JOIN dogs d
ON d.user_guid=u.user_guid
WHERE d.user_guid IS NULL;

/* Question 11: How would you write a query that used a right join to return the number of distinct user_guids that were in the users table,
but not the dogs table (your query should return a value of 2226)? */

SELECT COUNT(DISTINCT u.user_guid)
FROM dogs d RIGHT JOIN users u
ON d.user_guid=u.user_guid
WHERE d.user_guid IS NULL;

/* Question 12: Use a left join to create a list of all the unique dog_guids that are contained in the site_activities table, but not the dogs
table, and how many times each one is entered. Note that there are a lot of NULL values in the dog_guid of the site_activities table, so you 
will want to exclude them from your list. (Hint: if you exclude null values, the results you get will have two rows with words in their 
site_activities dog_guid fields instead of real guids, due to mistaken entries) */

SELECT s.dog_guid, COUNT(*) AS NumEntries
FROM site_activities s LEFT JOIN dogs d
ON d.dog_guid=s.dog_guid
WHERE s.dog_guid IS NOT NULL AND d.dog_guid IS NULL
GROUP BY s.dog_guid;