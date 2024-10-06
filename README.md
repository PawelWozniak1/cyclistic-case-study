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
- Checked the number of rows imported:
    ```sql
    SELECT COUNT(*) FROM rides;
    ```

### 4. Data Cleaning
- Identified and removed any records with inconsistencies, such as rides with an end time earlier than the start time:
    ```sql
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

