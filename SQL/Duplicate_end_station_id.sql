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
