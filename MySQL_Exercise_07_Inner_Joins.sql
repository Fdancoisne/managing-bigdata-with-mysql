/* Questions 1-4: How many unique dog_guids and user_guids are there in the reviews and dogs table independently? */
SELECT COUNT(DISTINCT dog_guid)
FROM reviews;

SELECT COUNT(DISTINCT dog_guid)
FROM dogs;

SELECT COUNT(DISTINCT user_guid)
FROM reviews;

SELECT COUNT(DISTINCT user_guid)
FROM dogs;

/* Question 5: How would you extract the user_guid, dog_guid, breed, breed_type, and breed_group for all animals who 
completed the "Yawn Warm-up" game (you should get 20,845 rows if you join on dog_guid only)? */

SELECT d.dog_guid AS DogID, d.user_guid AS UserID, d.breed, d.breed_group, d.breed_type
FROM dogs d, complete_tests t
WHERE d.dog_guid=t.dog_guid AND test_name="Yawn Warm-up";

/* Question 6: How would you extract the user_guid, membership_type, and dog_guid of all the golden retrievers who
completed at least 1 Dognition test (you should get 711 rows)? */

SELECT DISTINCT d.user_guid AS UserID, d.dog_guid AS DogID, u.membership_type, d.breed
FROM dogs d, complete_tests c, users u
WHERE d.dog_guid=c.dog_guid 
   AND d.user_guid=u.user_guid
   AND d.breed="golden retriever";

/* Question 7: How many unique Golden Retrievers who live in North Carolina are there in the Dognition database (you should get 30)? */

SELECT DISTINCT d.user_guid AS UserID, d.dog_guid AS DogID, d.breed, u.state
FROM dogs d, users u
WHERE d.user_guid=u.user_guid
   AND d.breed="golden retriever"
   AND u.state="NC";

/* Question 8: How many unique customers within each membership type provided reviews (there should be 3208 in the membership type with
the greatest number of customers, and 18 in the membership type with the fewest number of customers)? */

SELECT COUNT(DISTINCT u.user_guid) AS Customer, u.membership_type
FROM users u, reviews r
WHERE u.user_guid=r.user_guid
GROUP BY u.membership_type;

/* Question 9: For which 3 dog breeds do we have the greatest amount of site_activity data, (as defined by non-NULL values in script_detail_id)
(your answers should be "Mixed", "Labrador Retriever", and "Labrador Retriever-Golden Retriever Mix"? */

SELECT d.breed, d.user_guid AS UserID, d.dog_guid AS DogID, COUNT(u.script_detail_id) AS activity
FROM dogs d, site_activities u
WHERE 
u.dog_guid=d.dog_guid
AND u.script_detail_id IS NOT NULL
GROUP BY d.breed
ORDER BY activity DESC
LIMIT 3;

