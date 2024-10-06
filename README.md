# Cyclistic Bike-Share Analysis
#### Description: The Cyclistic Bike-Share Analysis project aims to explore and analyze bike-sharing data to understand user behavior and improve the service. This project uses SQLite for data management and R for data analysis.

## Project Overview
The Cyclistic Bike-Share Analysis project focuses on evaluating bike usage patterns to inform marketing strategies and service improvements. The data consists of rides taken from a bike-sharing service and includes attributes such as ride duration, start and end stations, and user types.

## Steps of the Analysis

### 1. Setting Up the Environment
- Created a database file `cyclistic_data.db` to store imported data.

### 2. Importing Data
- Used the following command to import the data from CSV files into the SQLite database:
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

### 3. Verifying Data Import
- Overview of the data
    ```sql
    SELECT * FROM rides LIMIT 10;
    ```

    Outpt:
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

### 4. Data Cleaning
- Identified and removed any records with inconsistencies, such as odd bike type, member type or rides with an end time earlier than the start time:
    ```sql
    SELECT member_casual, COUNT(*) FROM rides GROUP BY member_casual;
    SELECT COUNT(*) FROM rides WHERE ended_at < started_at;
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

