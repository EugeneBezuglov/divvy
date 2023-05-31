-- start stations

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, 'Public Rack - ', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, 'Pubic Rack - ', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, 'Public  Rack - ', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, 'City Rack - ', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, 'amp;', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, ' (Temp)', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, '*', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, ' - Charging', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, ' (May)', '');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, 'Western & 28th - Velasquez Institute Vaccination Site', 'Western Ave & 28th St');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, 'Halsted & 63rd - Kennedy-King Vaccination Site', 'Halsted St & 63rd St');

UPDATE full_tripdata
SET start_station_name = REPLACE(start_station_name, 'Broadway & Wilson - Truman College Vaccination Site', 'Broadway & Wilson Ave');

--end stations

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, 'Public Rack - ', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, 'Pubic Rack - ', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, 'Public  Rack - ', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, 'City Rack - ', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, 'amp;', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, ' (Temp)', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, '*', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, ' - Charging', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, ' (May)', '');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, 'Western & 28th - Velasquez Institute Vaccination Site', 'Western Ave & 28th St');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, 'Halsted & 63rd - Kennedy-King Vaccination Site', 'Halsted St & 63rd St');

UPDATE full_tripdata
SET end_station_name = REPLACE(end_station_name, 'Broadway & Wilson - Truman College Vaccination Site', 'Broadway & Wilson Ave');

