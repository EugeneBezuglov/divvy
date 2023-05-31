SELECT
	DISTINCT rideable_type,
	COUNT(*)
FROM full_tripdata
GROUP BY rideable_type;