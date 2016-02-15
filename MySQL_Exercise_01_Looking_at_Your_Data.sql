/* Question 1: How many columns does the "dogs" table have? Enter the appropriate query below to find out: */

SHOW columns FROM dogs;

/* Question 2: Try using the DESCRIBE function to learn how many columns are in the "reviews" table: */

DESCRIBE reviews;

/* Questions 3-6: In the cells below, examine the fields in the other 4 tables of the Dognition database: */

DESCRIBE complete_tests;

DESCRIBE exam_answers;

DESCRIBE site_activities;

DESCRIBE users;

/* Question 7: In the next cell, try entering a query that will let you see the first 10 rows of the breed column in the dogs table. */

SELECT breed
FROM dogs LIMIT 10;

/* Question 8: Try using the wild card to query the reviews table: */

SELECT *
FROM dogs LIMIT 5, 10;

/* Question 9: Go ahead and try it, adding in a column to your output that shows you the original median_iti in minutes. */

SELECT median_iti_minutes, median_iti_minutes / 60
FROM dogs LIMIT 5, 10;

/* Question 10: How would you retrieve the first 15 rows of data from the dog_guid, subcategory_name, and test_name fields of the Reviews table, in that order? */

SELECT dog_guid, subcategory_name, test_name
FROM reviews LIMIT 15;

/* Question 11: How would you retrieve 10 rows of data from the activity_type, created_at, and updated_at fields of the site_activities table, starting at row 50?
What do you notice about the created_at and updated_at fields? */

SELECT activity_type, created_at, updated_at fields
FROM site_activities LIMIT 49, 10;

/* Question 12: How would you retrieve 20 rows of data from all the columns in the users table, starting from row 2000? What do you notice about the free_start_user field? */

SELECT *
FROM users LIMIT 1999, 20;


