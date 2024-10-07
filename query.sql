-- Extract the day of the week and count rides by user type
SELECT CASE STRFTIME('%w', started_at)
         WHEN '0' THEN 'Sunday'
         WHEN '1' THEN 'Monday'
         WHEN '2' THEN 'Tuesday'
         WHEN '3' THEN 'Wednesday'
         WHEN '4' THEN 'Thursday'
         WHEN '5' THEN 'Friday'
         WHEN '6' THEN 'Saturday'
       END AS day_of_week, member_casual, COUNT(*) AS ride_count
FROM rides
GROUP BY day_of_week, member_casual
ORDER BY day_of_week, ride_count desc;