-- 1.	How many rows are in the data_analyst_jobs table?
SELECT COUNT(*)
FROM data_analyst_jobs;

--Answer: 1793

-- 2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
FROM data_analyst_jobs
LIMIT 10;

-- Answer: ExxonMobil

-- 3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky? use location for the column?

a. SELECT COUNT(location)
FROM data_analyst_jobs
WHERE location='TN'
GROUP BY location;

-- Answer: 21

b. SELECT location, COUNT(location)
FROM data_analyst_jobs
WHERE location='TN' OR location='KY'
GROUP BY location; 

-- Answer: TN: 21, KY:6 Could have used the IN clause (for example; WHERE IN)

-- 4. How many postings in Tennessee have a star rating above 4?

SELECT COUNT(star_rating)
FROM data_analyst_jobs
WHERE star_rating > 4
	AND location = 'TN';

-- Answer: 3

-- 5. How many postings in the dataset have a review count between 500 and 1000?

SELECT review_count
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

-- Answer: 151

-- 6. Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?

SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY state;

-- Answer: 46

-- 7. Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT DISTINCT(title)
FROM data_analyst_jobs;

-- Answer: 881

-- 8. How many unique job titles are there for California companies?

SELECT DISTINCT(title), location
FROM data_analyst_jobs
WHERE location = 'CA';

-- Answer: 230

-- 9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT
    company,
    AVG(star_rating) AS average_star_rating,
    MAX(review_count) AS total_review_count 
FROM
    data_analyst_jobs
WHERE
    review_count > 5000 AND company IS NOT NULL
GROUP BY
    company
ORDER BY
    total_review_count DESC;

-- Answer: 40


-- 10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT
    company,
    AVG(star_rating) AS average_star_rating,
    MAX(review_count) AS total_review_count 
FROM
    data_analyst_jobs
WHERE
    review_count > 5000 
GROUP BY
    company
ORDER BY
    average_star_rating DESC;

-- Answer: General Motors, Unilever, Microsoft, Nike, American Express, and Kaiser Permanente highest average star_rating of 4.1999998090000000

-- 11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 

SELECT DISTINCT(title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

-- Answer: 774

-- Using Postgres ILIKE (case-insensitive)

SELECT DISTINCT(title)
FROM data_analyst_jobs
WHERE title ILIKE '%Analyst%';

-- Answer: 774


SELECT COUNT DISTINCT (title)
FROM  data_analyst_jobs
WHERE title LIKE 'Analyst%';

-- 12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

SELECT DISTINCT (title)
FROM data_analyst_jobs
WHERE LOWER(title) NOT LIKE '%analyst%'
  AND LOWER(title) NOT LIKE '%analytics%';

-- Answer: a. There are (4) job titles that do not contain ‘Analyst’ or the word ‘Analytics’. b. I see out of the (4) job titles that Data Visualization Specialist - Consultant appears twice.


-- Bonus: 
-- You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
-- Disregard any postings where the domain is NULL. 
-- Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
-- Which three industries are in the top 3 on this list? How many jobs have been listed for more than 3 weeks for each of the top 3? 

-- Initial formula, however, does not provide the 'title' for each job -- 
SELECT
    domain,
	COUNT(title) AS number_of_hard_to_fill_sql_jobs
FROM
    data_analyst_jobs
WHERE
    days_since_posting > 15 -- Number of days is based on business days
    AND domain IS NOT NULL
    AND skill LIKE '%SQL%'                             
GROUP BY
    domain
ORDER BY
    number_of_hard_to_fill_sql_jobs DESC;


-- The formula below appears to answer the bonus question -- 

SELECT
    domain,
    title,
    skill,
    days_since_posting
FROM
    data_analyst_jobs
WHERE
    days_since_posting > 15  -- Number of days is based on business days
    AND skill ILIKE '%SQL%'
	AND domain IS NOT NULL
	ORDER BY
    domain DESC, 
    days_since_posting DESC;

-- Answer: a. Transport and Freight, Telecommunications, and Retail (3) Sr. Data Analyst, SENIOR ANALYST, MARKETING ANALYTICS, and Data Analyst.

