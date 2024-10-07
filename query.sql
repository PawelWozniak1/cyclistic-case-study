SELECT STRFTIME('%H', started_at) AS hour_of_day, member_casual, COUNT(*) AS ride_count
FROM rides
GROUP BY hour_of_day, member_casual
ORDER BY ride_count DESC
LIMIT 15;