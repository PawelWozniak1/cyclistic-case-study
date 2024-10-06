SELECT * FROM rides LIMIT 10;
SELECT COUNT(*) FROM rides;

SELECT COUNT(*) FROM rides WHERE ride_id IS NULL OR start_station_name IS NULL;

SELECT member_casual, COUNT(*) FROM rides GROUP BY member_casual;
SELECT avg(ride_duration) from (
    SELECT ride_id, 
        (julianday(ended_at) - julianday(started_at)) * 24 * 60 AS ride_duration
    FROM rides);
