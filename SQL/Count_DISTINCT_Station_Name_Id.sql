SELECT
	COUNT(DISTINCT start_station_id) AS start_station_id,
	COUNT(DISTINCT end_station_id) AS end_station_id,
	COUNT(DISTINCT start_station_name) AS start_station_name,
	COUNT(DISTINCT end_station_name) AS end_station_name
FROM full_tripdata;