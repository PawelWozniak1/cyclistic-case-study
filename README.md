# Cyclistic Bike-Share Analysis
#### Description: The Cyclistic Bike-Share Analysis project aims to explore and analyze bike-sharing data to understand user behavior and improve the service. This project uses SQLite for data management and R for data analysis.

## Project Overview
The Cyclistic Bike-Share Analysis project focuses on evaluating bike usage patterns to inform marketing strategies and service improvements. The data consists of rides taken from a bike-sharing service and includes attributes such as ride duration, start and end stations, and user types.

## Steps of the Analysis

## Ask

In this phase, the goal is to understand the business problem and how data analysis can provide actionable insights.

### Business Task
Cyclistic, a fictional bike-share company, is interested in maximizing the number of annual memberships. Their historical data shows that casual riders (those who pay for a single ride or day pass) might be a potential target for converting into annual members. The company wants to know how casual riders and annual members use Cyclistic bikes differently to inform a marketing strategy aimed at converting casual riders into paying members.

### Key Stakeholders
- **Cyclistic Executives**: Focus on how the insights from data analysis can help improve membership numbers.
- **Marketing Team**: Will use the analysis to develop targeted campaigns aimed at casual riders.
- **Data Analytics Team**: Responsible for providing the insights through analysis of the historical trip data.

### Key Questions
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

By answering these questions, the analysis will help guide Cyclistic in improving their marketing strategy to boost membership.

## Prepare

The **Prepare** phase involves gathering the relevant data, ensuring its reliability, and understanding any potential limitations.

### Data Source

The data used for this analysis comes from Cyclistic's historical bike-share data. The dataset includes details such as:
- Ride duration
- Start and end stations
- Type of bike used (classic, docked, or electric)
- User type (casual or annual member)

The data is stored in CSV files and was imported into an SQLite database for analysis.

### Data Integrity

Before analysis, it was essential to evaluate the integrity of the data:
- **Consistency**: Checked if the data was consistent, especially in terms of time formats, bike types, and user categories.
- **Completeness**: Verified that there were no missing or null values in critical columns, such as `ride_id`, `started_at`, `ended_at`, `start_station_name`, and `end_station_name`.
- **Accuracy**: Removed records with inconsistencies, such as rides that had an end time earlier than the start time.

### Data Preparation

1. **Database Creation**:
   A new SQLite database (`cyclistic_data.db`) was created to store the imported data for analysis. 

2. **Data Import**:
   The data from CSV files was imported into the SQLite database using the following Python code:
   ```python
   import sqlite3
   import pandas as pd
   import csv
   import os

   # Path to the directory containing CSV files
   csv_dir = 'R:/cyclistic-case-study/'

   # Create a new SQLite database
   conn = sqlite3.connect('R:/cyclistic-case-study/cyclistic_data.db')

   # Function to import a CSV file
   def import_csv(file_path):
       with open(file_path, 'r') as f:
           reader = csv.reader(f)
           next(reader)  # Skip the header row
           for row in reader:
               cur.execute('''
                   INSERT INTO rides (
                       ride_id, rideable_type, started_at, ended_at,
                       start_station_name, start_station_id, end_station_name,
                       end_station_id, start_lat, start_lng, end_lat, end_lng,
                       member_casual
                   ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
               ''', row)

   # Loop through each CSV file in the directory
   for file in os.listdir(csv_dir):
       if file.endswith('.csv'):
           df = pd.read_csv(os.path.join(csv_dir, file))
           df.to_sql(name='rides', con=conn, if_exists='append', index=False)

   conn.close()

3. **Data Verification**:
   After importing the data, it was essential to verify its accuracy by running the following SQL queries:
   ```sql
   -- View sample data
   SELECT * FROM rides LIMIT 10;
   ```

   Output:

| ride_id          | rideable_type | started_at       | ended_at         | start_station_name            | start_station_id | end_station_name               | end_station_id | start_lat    | start_lng          | end_lat   | end_lng     | member_casual |
| ---------------- | ------------- | ---------------- | ---------------- | ----------------------------- | ---------------- | ------------------------------ | -------------- | ------------ | ------------------ | --------- | ----------- | ------------- |
| F96D5A74A3E41399 | electric_bike | 21.01.2023 20:05 | 21.01.2023 20:16 | Lincoln Ave & Fullerton Ave   | TA1309000058     | Hampden Ct & Diversey Ave      | 202480.0       | 41.924073935 | \-87.646278381     | 41.93     | \-87.64     | member        |
| 13CB7EB698CEDB88 | classic_bike  | 10.01.2023 15:37 | 10.01.2023 15:46 | Kimbark Ave & 53rd St         | TA1309000037     | Greenwood Ave & 47th St        | TA1308000002   | 41.799568    | \-87.594747        | 41.809835 | \-87.599383 | member        |
| BD88A2E670661CE5 | electric_bike | 02.01.2023 07:51 | 02.01.2023 08:05 | Western Ave & Lunt Ave        | RP-005           | Valli Produce - Evanston Plaza | 599            | 42.008571    | \-87.6904828333333 | 42.039742 | \-87.699413 | casual        |
| C90792D034FED968 | classic_bike  | 22.01.2023 10:52 | 22.01.2023 11:01 | Kimbark Ave & 53rd St         | TA1309000037     | Greenwood Ave & 47th St        | TA1308000002   | 41.799568    | \-87.594747        | 41.809835 | \-87.599383 | member        |
| 3397017529188E8A | classic_bike  | 12.01.2023 13:58 | 12.01.2023 14:13 | Kimbark Ave & 53rd St         | TA1309000037     | Greenwood Ave & 47th St        | TA1308000002   | 41.799568    | \-87.594747        | 41.809835 | \-87.599383 | member        |
| 58E68156DAE3E311 | electric_bike | 31.01.2023 07:18 | 31.01.2023 07:21 | Lakeview Ave & Fullerton Pkwy | TA1309000019     | Hampden Ct & Diversey Ave      | 202480.0       | 41.926068902 | \-87.638858199     | 41.93     | \-87.64     | member        |
| 2F7194B6012A98D4 | electric_bike | 15.01.2023 21:18 | 15.01.2023 21:32 | Kimbark Ave & 53rd St         | TA1309000037     | Greenwood Ave & 47th St        | TA1308000002   | 41.799553633 | \-87.594616652     | 41.809835 | \-87.599383 | member        |
| DB1CF84154D6A049 | classic_bike  | 25.01.2023 10:49 | 25.01.2023 10:58 | Kimbark Ave & 53rd St         | TA1309000037     | Greenwood Ave & 47th St        | TA1308000002   | 41.799568    | \-87.594747        | 41.809835 | \-87.599383 | member        |
| 34EAB943F88C4C5D | electric_bike | 25.01.2023 20:49 | 25.01.2023 21:02 | Kimbark Ave & 53rd St         | TA1309000037     | Greenwood Ave & 47th St        | TA1308000002   | 41.799587488 | \-87.594670296     | 41.809835 | \-87.599383 | member        |
| BC8AB1AA51DA9115 | classic_bike  | 06.01.2023 16:37 | 06.01.2023 16:49 | Kimbark Ave & 53rd St         | TA1309000037     | Greenwood Ave & 47th St        | TA1308000002   | 41.799568    | \-87.594747        | 41.809835 | \-87.599383 | member        |

   ```sql
   -- Check the total number of records imported
   SELECT COUNT(*) FROM rides;

   -- Check for any missing values in critical columns
   SELECT COUNT(*) FROM rides WHERE ride_id IS NULL OR start_station_name IS NULL;

   -- Check the distribution of bike types and user types
   SELECT rideable_type, COUNT(*) FROM rides GROUP BY rideable_type;
   SELECT member_casual, COUNT(*) FROM rides GROUP BY member_casual;
   ```

### 4. Data Cleaning

The data cleaning process was critical to ensure accurate and reliable analysis. The following steps were taken:

1. **Duplicate Records**: 
   Removed any duplicate records based on the `ride_id` to ensure each ride was unique.
   ```sql
   DELETE FROM rides WHERE rowid NOT IN (SELECT MIN(rowid) FROM rides GROUP BY ride_id);
   ```
2. **Missing Data**:
   Removed rows where important fields like start_station_name or end_station_name were missing, as these records wouldn't contribute to meaningful insights.
   ```sql
   DELETE FROM rides WHERE start_station_name IS NULL OR end_station_name IS NULL;
   ```
3. **Invalid Time Entries**:
   Identified and removed any rides where the ended_at timestamp was earlier than the started_at, as these entries were logically impossible.
   ```sql
   DELETE FROM rides WHERE ended_at < started_at;
   ```
4. **Sanity Checks**:
   - Verified that all important columns (such as ride_id, start_station_name, and member_casual) were properly populated.
   - Checked for the correct distribution of bike types and user types to ensure data consistency.
   ```sql
   SELECT rideable_type, COUNT(*) FROM rides GROUP BY rideable_type;
   SELECT member_casual, COUNT(*) FROM rides GROUP BY member_casual;
   ```
By implementing these cleaning steps, the dataset was refined to be consistent, accurate, and ready for deeper analysis.

## Analyze

The **Analyze** phase involves exploring the cleaned data to derive insights and answer the key business questions. The focus is on identifying patterns in how casual riders and annual members use Cyclistic bikes differently.

### 1. Descriptive Statistics

To begin the analysis, descriptive statistics were calculated to summarize the key features of the data, such as ride duration, number of rides, and distribution of user types.

```sql
-- Calculate total number of rides by user type
SELECT member_casual, COUNT(*) AS ride_count 
FROM rides 
GROUP BY member_casual;

Output:
| member_casual | ride_count |
| ------------- | ---------- |
| casual        | 2059037    |
| member        | 3660568    |

-- Calculate average ride duration (in minutes) by user type
SELECT member_casual, AVG((JULIANDAY(ended_at) - JULIANDAY(started_at)) * 24 * 60) AS avg_ride_duration 
FROM rides 
GROUP BY member_casual;

Output:
| member_casual | avg_ride_duration |
| ------------- | ----------------- |
| casual        | 28.24825055744    |
| member        | 12.5258002356036  |

-- Count the number of rides by rideable type and user type
SELECT member_casual, rideable_type, COUNT(*) AS ride_count 
FROM rides 
GROUP BY member_casual, rideable_type;

Output:
| member_casual | rideable_type | ride_count |
| ------------- | ------------- | ---------- |
| casual        | classic_bike  | 876858     |
| casual        | docked_bike   | 78287      |
| casual        | electric_bike | 1103892    |
| member        | classic_bike  | 1819110    |
| member        | electric_bike | 1841458    |
```

Key observations:

- Casual riders generally take longer rides than annual members.
- Annual members tend to use Cyclistic bikes more frequently than casual riders.
- Electric bikes are popular among both casual riders and members, but the exact distribution differs by user type.

### 2. Ride Patterns by Day of the Week

Analyzing how ride usage varies by day of the week helps in understanding when users are most active. This can provide insights into user behavior, particularly for targeting marketing campaigns.

```sql
-- Extract the day of the week and count rides by user type
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

Ride Counts by Day of the Week:
| day_of_week | member_casual | ride_count |
| ----------- | ------------- | ---------- |
| Friday      | member        | 531582     |
| Friday      | casual        | 311907     |
| Monday      | member        | 494558     |
| Monday      | casual        | 234818     |
| Saturday    | member        | 472846     |
| Saturday    | casual        | 410684     |
| Sunday      | member        | 408829     |
| Sunday      | casual        | 335668     |
| Thursday    | member        | 589572     |
| Thursday    | casual        | 270596     |
| Tuesday     | member        | 576743     |
| Tuesday     | casual        | 246211     |
| Wednesday   | member        | 586438     |
| Wednesday   | casual        | 249153     |
```

Key Insights:
- Casual riders are most active on weekends, particularly on Saturday and    Sunday, with a significant dip during the weekdays.
- Annual members maintain a steady usage throughout the week, with peaks on Wednesday and Thursday, indicating frequent use during weekdays, likely for commuting.
- Marketing campaigns can be tailored to weekends for casual riders and weekdays for members, focusing on converting casual riders during their peak usage times.