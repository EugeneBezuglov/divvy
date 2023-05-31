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
