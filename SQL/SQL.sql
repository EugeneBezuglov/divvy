-- Here is all the SQL code for this project in the right order

-- Create 12 tables, one for each month of data.
-- Alternatively, I could create just one table and import CSVs into it step by step

CREATE TABLE IF NOT EXISTS public.feb2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT feb2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.mar2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT mar2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.apr2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT apr2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.may2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT may2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.jun2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT jun2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.jul2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT jul2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.aug2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT aug2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.sep2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT sep2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.oct2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT oct2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.nov2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT nov2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.dec2022
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT dec2022_pkey PRIMARY KEY (ride_id)
);

CREATE TABLE IF NOT EXISTS public.jan2023
(
    ride_id character varying COLLATE pg_catalog."default" NOT NULL,
    rideable_type character varying COLLATE pg_catalog."default",
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    start_station_name character varying COLLATE pg_catalog."default",
    start_station_id character varying COLLATE pg_catalog."default",
    end_station_name character varying COLLATE pg_catalog."default",
    end_station_id character varying COLLATE pg_catalog."default",
    start_lat numeric,
    start_lng numeric,
    end_lat numeric,
    end_lng numeric,
    member_casual character varying COLLATE pg_catalog."default",
    CONSTRAINT jan2023_pkey PRIMARY KEY (ride_id)
);

-- Import data to the tables

COPY feb2022
FROM 'D:\R\R Projects\DivvyBikes_v2\data\202202-divvy-tripdata.csv' 
DELIMITER ',' 
CSV HEADER;

COPY mar2022
FROM 'D:\R\R Projects\DivvyBikes_v2\data\202203-divvy-tripdata.csv' 
DELIMITER ',' 
CSV HEADER;

COPY apr2022
FROM 'D:\R\R Projects\DivvyBikes_v2\data\202204-divvy-tripdata.csv' 
DELIMITER ',' 
CSV HEADER;

COPY may2022
FROM 'D:\R\R Projects\DivvyBikes_v2\data\202205-divvy-tripdata.csv' 
DELIMITER ',' 
CSV HEADER;

COPY jun2022
FROM 'D:\R\R Projects\DivvyBikes_v2\data\202206-divvy-tripdata.csv' 
DELIMITER ',' 
CSV HEADER;

COPY jul2022
FROM 'D:\R\R Projects\DivvyBikes_v2\data\202207-divvy-tripdata.csv' 
DELIMITER ',' 
CSV HEADER;

COPY aug2022
FROM 'D:\R\R Projects\DivvyBikes_v2\data\202208-divvy-tripdata.csv' 
DELIMITER ',' 
CSV HEADER;

COPY sep2022
FROM 'D:\R\R Projects\DivvyBikes_v2\data\202209-divvy-publictripdata.csv' 
DELIMITER ',' 
CSV HEADER;

COPY oct2022
FROM 'D:\R\R Projects\DivvyBikes_v2\data\202210-divvy-tripdata.csv' 
DELIMITER ',' 
CSV HEADER;

COPY nov2022
FROM 'D:\R\R Projects\DivvyBikes_v2\data\202211-divvy-tripdata.csv' 
DELIMITER ',' 
CSV HEADER;

COPY dec2022
FROM 'D:\R\R Projects\DivvyBikes_v2\data\202212-divvy-tripdata.csv' 
DELIMITER ',' 
CSV HEADER;

COPY jan2023
FROM 'D:\R\R Projects\DivvyBikes_v2\data\202301-divvy-tripdata.csv' 
DELIMITER ',' 
CSV HEADER;

-- Unite the tables into one table, full_tripdata

CREATE TABLE full_tripdata AS
SELECT *
FROM feb2022
UNION ALL
SELECT *
FROM mar2022
UNION ALL
SELECT *
FROM apr2022
UNION ALL
SELECT *
FROM may2022
UNION ALL
SELECT *
FROM jun2022
UNION ALL
SELECT *
FROM jul2022
UNION ALL
SELECT *
FROM aug2022
UNION ALL
SELECT *
FROM sep2022
UNION ALL
SELECT *
FROM oct2022
UNION ALL
SELECT *
FROM nov2022
UNION ALL
SELECT *
FROM dec2022
UNION ALL
SELECT *
FROM jan2023;

-- Compare the number of rows in monthly tables with the united table to verify the data has been united successfully.

WITH table_count(count) AS (
    VALUES
        ((SELECT COUNT(*) FROM feb2022)),
        ((SELECT COUNT(*) FROM mar2022)),
        ((SELECT COUNT(*) FROM apr2022)),
        ((SELECT COUNT(*) FROM may2022)),
        ((SELECT COUNT(*) FROM jun2022)),
        ((SELECT COUNT(*) FROM jul2022)),
        ((SELECT COUNT(*) FROM aug2022)),
        ((SELECT COUNT(*) FROM sep2022)),
        ((SELECT COUNT(*) FROM oct2022)),
        ((SELECT COUNT(*) FROM nov2022)),
        ((SELECT COUNT(*) FROM dec2022)),
        ((SELECT COUNT(*) FROM jan2023))
)
SELECT SUM(count) FROM table_count
UNION ALL
SELECT COUNT(*) FROM full_tripdata;

-- Look for outdated values in rideable_type. (Divvy replaced docked_bike with classic_bike)

SELECT
	DISTINCT rideable_type,
	COUNT(*)
FROM full_tripdata
GROUP BY rideable_type;


-- Replace outdated values

UPDATE full_tripdata
SET rideable_type = CASE
    WHEN rideable_type = 'docked_bike' THEN 'classic_bike'
    ELSE rideable_type
    END;

-- Count NULLs across all columns

SELECT column_name, COUNT(*) AS null_count
FROM (
  SELECT 'ride_id' AS column_name, ride_id::text AS value FROM full_tripdata
  UNION ALL
  SELECT 'rideable_type' AS column_name, rideable_type FROM full_tripdata
  UNION ALL
  SELECT 'started_at' AS column_name, started_at::text AS value FROM full_tripdata
  UNION ALL
  SELECT 'ended_at' AS column_name, ended_at::text AS value FROM full_tripdata
  UNION ALL
  SELECT 'start_station_name' AS column_name, start_station_name FROM full_tripdata
  UNION ALL
  SELECT 'start_station_id' AS column_name, start_station_id FROM full_tripdata
  UNION ALL
  SELECT 'end_station_name' AS column_name, end_station_name FROM full_tripdata
  UNION ALL
  SELECT 'end_station_id' AS column_name, end_station_id FROM full_tripdata
  UNION ALL
  SELECT 'start_lat' AS column_name, start_lat::text AS value FROM full_tripdata
  UNION ALL
  SELECT 'start_lng' AS column_name, start_lng::text AS value FROM full_tripdata
  UNION ALL
  SELECT 'end_lat' AS column_name, end_lat::text AS value FROM full_tripdata
  UNION ALL
  SELECT 'end_lng' AS column_name, end_lng::text AS value FROM full_tripdata
  UNION ALL
  SELECT 'member_casual' AS column_name, member_casual FROM full_tripdata
) AS subquery
WHERE value IS NULL
GROUP BY column_name;

-- Compare the numbers of station IDs and names

SELECT
	COUNT(DISTINCT start_station_id) AS start_station_id,
	COUNT(DISTINCT end_station_id) AS end_station_id,
	COUNT(DISTINCT start_station_name) AS start_station_name,
	COUNT(DISTINCT end_station_name) AS end_station_name
FROM full_tripdata;

-- Look for duplicate start_station_id (more than 1 station name for 1 ID)

SELECT start_station_id, start_station_name
FROM full_tripdata
WHERE start_station_id IN
(
	SELECT
		start_station_id
	FROM full_tripdata
	GROUP BY start_station_id
	HAVING COUNT(DISTINCT start_station_name) > 1
	ORDER BY COUNT(DISTINCT start_station_name) DESC
)
GROUP BY start_station_id, start_station_name
ORDER BY start_station_id DESC, start_station_name;

-- Look for duplicate end_station_id (more than 1 station name for 1 ID)

SELECT end_station_id, end_station_name
FROM full_tripdata
WHERE end_station_id IN
(
	SELECT
		end_station_id
	FROM full_tripdata
	GROUP BY end_station_id
	HAVING COUNT(DISTINCT end_station_name) > 1
	ORDER BY COUNT(DISTINCT end_station_name) DESC
)
GROUP BY end_station_id, end_station_name
ORDER BY end_station_id DESC, end_station_name;

-- Before I make adjustments to the table, I create a backup copy

CREATE TABLE full_tripdata_backup AS
SELECT *
FROM full_tripdata

-- Replace string pieces (that are responsible for some duplicate naming)
-- start stations

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, 'Public Rack - ', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, 'Pubic Rack - ', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, 'Public  Rack - ', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, 'City Rack - ', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, 'amp;', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, ' (Temp)', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, '*', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, ' - Charging', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, ' (May)', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, 'Western & 28th - Velasquez Institute Vaccination Site', 'Western Ave & 28th St');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, 'Halsted & 63rd - Kennedy-King Vaccination Site', 'Halsted St & 63rd St');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, 'Broadway & Wilson - Truman College Vaccination Site', 'Broadway & Wilson Ave');

-- Replace string pieces (that are responsible for some duplicate naming)
--end stations

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, 'Public Rack - ', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, 'Pubic Rack - ', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, 'Public  Rack - ', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, 'City Rack - ', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, 'amp;', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, ' (Temp)', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, '*', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, ' - Charging', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, ' (May)', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, 'Western & 28th - Velasquez Institute Vaccination Site', 'Western Ave & 28th St');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, 'Halsted & 63rd - Kennedy-King Vaccination Site', 'Halsted St & 63rd St');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, 'Broadway & Wilson - Truman College Vaccination Site', 'Broadway & Wilson Ave');

-- Delete maintenance stations
-- before deleting I check how many rows are affected.

SELECT
FROM FULL_TRIPDATA
WHERE START_STATION_ID = 'DIVVY 001 - Warehouse test station'
	OR START_STATION_ID = 'Hubbard Bike-checking (LBS-WH-TEST)'
	OR START_STATION_ID = 'DIVVY CASSETTE REPAIR MOBILE STATION'
	OR END_STATION_ID = 'DIVVY 001 - Warehouse test station'
	OR END_STATION_ID = 'Hubbard Bike-checking (LBS-WH-TEST)'
	OR END_STATION_ID = 'DIVVY CASSETTE REPAIR MOBILE STATION';

-- Delete

DELETE
FROM FULL_TRIPDATA
WHERE START_STATION_ID = 'DIVVY 001 - Warehouse test station'
	OR START_STATION_ID = 'Hubbard Bike-checking (LBS-WH-TEST)'
	OR START_STATION_ID = 'DIVVY CASSETTE REPAIR MOBILE STATION'
	OR END_STATION_ID = 'DIVVY 001 - Warehouse test station'
	OR END_STATION_ID = 'Hubbard Bike-checking (LBS-WH-TEST)'
	OR END_STATION_ID = 'DIVVY CASSETTE REPAIR MOBILE STATION';

-- Delete outliers. (Rides with duration > 3386 seconds and < 65 seconds)

DELETE
FROM full_tripdata
WHERE
	ended_at - started_at < INTERVAL '65 SECONDS'
	OR ended_at - started_at > INTERVAL '3386 SECONDS';

-- Add round_trip variable to account for round trips.
-- Actually, this is abundant in SQL, I did it just to practice creating new columns.

ALTER TABLE full_tripdata
ADD round_trip INTEGER;

UPDATE full_tripdata
SET round_trip =
	CASE
		WHEN start_station_id = end_station_id THEN 1
		ELSE 0
	END;

-- A good idea would be to create a new table, stations, which would hold station id, name, and coordinates.
-- I could obtain station coordinates by calculating median latitute and longitude of all the station rides.
-- I've already done this in R, maybe I'll do it in SQL, maybe not. 
