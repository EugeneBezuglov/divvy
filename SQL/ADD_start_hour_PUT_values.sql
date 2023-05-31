ALTER TABLE full_tripdata
ADD start_hour VARCHAR;

UPDATE full_tripdata
SET start_hour = TO_CHAR(started_at, 'HH24');