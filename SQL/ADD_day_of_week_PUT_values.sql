-- add new column
ALTER TABLE full_tripdata
ADD day_of_week VARCHAR;

-- put values into the column
UPDATE full_tripdata
SET day_of_week = TO_CHAR(started_at, 'Day');
