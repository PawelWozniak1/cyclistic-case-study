SELECT hour_of_day,
       MAX(CASE WHEN member_casual = 'member' THEN ride_count ELSE 0 END) AS member_rides,
       MAX(CASE WHEN member_casual = 'casual' THEN ride_count ELSE 0 END) AS casual_rides
FROM (
    SELECT STRFTIME('%H', started_at) AS hour_of_day, member_casual, COUNT(*) AS ride_count
    FROM rides
    GROUP BY hour_of_day, member_casual
) AS hourly_rides
GROUP BY hour_of_day
ORDER BY hour_of_day;