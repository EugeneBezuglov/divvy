WITH multiple_names AS (
	SELECT
		start_station_id,
		COUNT(DISTINCT start_station_name) as n_names
	FROM rides
	GROUP BY
		start_station_id
	ORDER BY
		n_names DESC
), table_2 AS (

	SELECT
		start_station_id,
		start_station_name
	FROM
		rides
	WHERE
		start_station_id IN (SELECT start_station_id FROM multiple_names WHERE n_names > 1)

)

SELECT
	DISTINCT start_station_name,
	start_station_id
FROM table_2
ORDER BY start_station_id
