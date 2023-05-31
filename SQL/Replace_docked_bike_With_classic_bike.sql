UPDATE full_tripdata
SET rideable_type = CASE
    WHEN rideable_type = 'docked_bike' THEN 'classic_bike'
    ELSE rideable_type
    END;