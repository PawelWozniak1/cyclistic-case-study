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

-- Check the total number of records imported
SELECT COUNT(*) FROM rides;

-- Check for any missing values in critical columns
SELECT COUNT(*) FROM rides WHERE ride_id IS NULL OR start_station_name IS NULL;

-- Check the distribution of bike types and user types
SELECT rideable_type, COUNT(*) FROM rides GROUP BY rideable_type;
SELECT member_casual, COUNT(*) FROM rides GROUP BY member_casual;

### 3. Verifying Data Import------------
- Overview of the data
    ```sql
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

- Checked the number of rows imported:
    ```sql
    SELECT COUNT(*) FROM rides;
    ```

- Check for any null or missing values in key columns:
    ```sql
    SELECT COUNT(*) FROM rides WHERE ride_id IS NULL OR start_station_name IS NULL;
    ```

- Check the distribution of rideable and members types:
    ```sql
    SELECT rideable_type, COUNT(*) FROM rides GROUP BY rideable_type;
    SELECT member_casual, COUNT(*) FROM rides GROUP BY member_casual;
    ```

### 4. Data Cleaning
- Identified and removed any records with inconsistencies, such as odd bike type, member type or rides with an end time earlier than the start time:
    ```sql
    DELETE FROM rides WHERE rowid NOT IN (SELECT MIN(rowid) FROM rides GROUP BY ride_id);
    DELETE FROM rides WHERE start_station_name IS NULL OR end_station_name IS NULL;
    DELETE FROM rides WHERE ended_at < started_at;
    ```
    
### 5. Data Analysis
- Conducted various analyses, such as:
    - User type distribution:
      ```sql
      SELECT member_casual, COUNT(*) FROM rides GROUP BY member_casual;
      ```
    - Average ride duration by user type:
      ```sql
      SELECT member_casual, AVG(strftime('%s', ended_at) - strftime('%s', started_at)) AS avg_duration FROM rides GROUP BY member_casual;
      ```

### 6. Documentation
- Recorded all steps and queries in the README for future reference and reproducibility.

