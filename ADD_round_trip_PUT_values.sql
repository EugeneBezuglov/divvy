ALTER TABLE full_tripdata
ADD round_trip INTEGER;

UPDATE full_tripdata
SET round_trip =
	CASE
		WHEN start_station_id = end_station_id THEN 1
		ELSE 0
	END;