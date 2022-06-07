CREATE table "swiggy_data"
( shop_name varchar (255),
 cuisine varchar (255),
 location varchar(255),
 rating varchar (10),
 cost_for_two varchar(10)) ;
 
COPY swiggy_data
FROM 'D:\LEARN-DATA\Projects\Analyzing Swiggy\CSV\Swiggy Bangalore Outlet Details.csv'
DELIMITER ','
CSV HEADER; 

/* Let's have a look at the data. This query will retrieve all the data from the table. */
SELECT *
FROM swiggy_data;

/* So the below query gives us the number of rows in the dataset. */
SELECT 
    COUNT(*) AS NumberOfRows
FROM
    swiggy_data;

/* selecting distinct location */
SELECT DISTINCT
    location AS Uniquelocation 
FROM
    swiggy_data;
	
/* checking missing values */
SELECT *
FROM swiggy_data
WHERE
rating IS NULL or rating = '--';

/* Remove the outlier/anomalies */
DELETE FROM swiggy_data 
WHERE rating = '--';

/* Change rating to number */
ALTER TABLE swiggy_data
ALTER COLUMN rating TYPE numeric
USING rating::numeric;

-- clean table for the data analysis and visualisation 

DROP TABLE IF EXISTS clean_swiggydata;
CREATE TABLE "clean_swiggydata"
( Shop_name varchar(255),
 Cuisine varchar(255),
 Location varchar(255),
 Rating numeric,
 Cost_for_two int); 
 
INSERT INTO clean_swiggydata 
SELECT Shop_name,  
	SPLIT_PART(cuisine,',',1)AS Cuisine,
	TRIM(SPLIT_PART(location,',',-1))AS location,
    rating,
	CAST(RIGHT(cost_for_two, 3) AS int)
FROM swiggy_data;

SELECT * 
FROM clean_swiggydata;


/* Check the rating's range */
SELECT MIN(rating) AS Min_rating, 
MAX(rating) AS Max_rating
FROM clean_swiggydata; 
-- 3.6 to 4.8

/* Top 10 Cheapest and High Rated outlets */
SELECT *  
FROM clean_swiggydata
WHERE cost_for_two <= 600 
ORDER BY rating DESC, cost_for_two ASC LIMIT 10; 
--Saved the results for report

/* Top 10 Costliest and High Rated outlets */
SELECT *
FROM clean_swiggydata
WHERE cost_for_two >= 600 
ORDER BY rating DESC, cost_for_two DESC LIMIT 10; 
--Saved the results for report

/* Cheapest 10 restaurant of Bangalore in Swiggy */
SELECT * 
FROM clean_swiggydata
ORDER BY cost_for_two ASC LIMIT 10;
--Saved the results for report 

/* Costliest 10 restaurant of Bangalore in Swiggy */
SELECT *
FROM clean_swiggydata
ORDER BY cost_for_two desc LIMIT 10;
--Saved the results for report

/* Cheapest andd high Rated outlets in each location */
SELECT *
FROM clean_swiggydata
WHERE cost_for_two <= 600 AND location = 'Koramangala'
ORDER BY rating DESC, cost_for_two DESC LIMIT 10; 

 




















