SELECT DISTINCT end_station_name
FROM full_tripdata
WHERE end_station_name ~* '[*]|^Pub|^City|amp;|\S(May)| - Charging|Velasquez Institute Vaccination Site|Kennedy-King Vaccination Site|Truman College Vaccination Site'