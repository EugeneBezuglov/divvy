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