SELECT * FROM rides LIMIT 10;
SELECT member_casual, COUNT(*) FROM rides GROUP BY member_casual;
SELECT avg(ride_duration) from (
    SELECT ride_id, 
        (julianday(ended_at) - julianday(started_at)) * 24 * 60 AS ride_duration
    FROM rides);
