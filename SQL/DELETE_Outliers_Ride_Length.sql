DELETE
FROM full_tripdata
WHERE
	ended_at - started_at < INTERVAL '65 SECONDS'
	OR ended_at - started_at > INTERVAL '3386 SECONDS';
