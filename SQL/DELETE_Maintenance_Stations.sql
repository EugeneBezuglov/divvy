-- before deleting I checked how many rows are affected.

/*

SELECT
FROM FULL_TRIPDATA
WHERE START_STATION_ID = 'DIVVY 001 - Warehouse test station'
	OR START_STATION_ID = 'Hubbard Bike-checking (LBS-WH-TEST)'
	OR START_STATION_ID = 'DIVVY CASSETTE REPAIR MOBILE STATION'
	OR END_STATION_ID = 'DIVVY 001 - Warehouse test station'
	OR END_STATION_ID = 'Hubbard Bike-checking (LBS-WH-TEST)'
	OR END_STATION_ID = 'DIVVY CASSETTE REPAIR MOBILE STATION';

*/


DELETE
FROM FULL_TRIPDATA
WHERE START_STATION_ID = 'DIVVY 001 - Warehouse test station'
	OR START_STATION_ID = 'Hubbard Bike-checking (LBS-WH-TEST)'
	OR START_STATION_ID = 'DIVVY CASSETTE REPAIR MOBILE STATION'
	OR END_STATION_ID = 'DIVVY 001 - Warehouse test station'
	OR END_STATION_ID = 'Hubbard Bike-checking (LBS-WH-TEST)'
	OR END_STATION_ID = 'DIVVY CASSETTE REPAIR MOBILE STATION';