import sqlite3
import csv
import os

# Path to your CSV files folder
csv_folder_path = r'C:\Users\pawek\OneDrive\Pulpit\2 rok 2 semestr\7. Data Analysis with R Programming\analiza\work'

# Connect to SQLite database (will create the database if it doesn't exist)
conn = sqlite3.connect('cyclistic_data.db')
cur = conn.cursor()

# Create the table if it doesn't exist
cur.execute('''
    CREATE TABLE IF NOT EXISTS rides (
        ride_id TEXT,
        rideable_type TEXT,
        started_at TEXT,
        ended_at TEXT,
        start_station_name TEXT,
        start_station_id TEXT,
        end_station_name TEXT,
        end_station_id TEXT,
        start_lat REAL,
        start_lng REAL,
        end_lat REAL,
        end_lng REAL,
        member_casual TEXT
    );
''')

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

# Loop through all CSV files in the directory and import each one
for file_name in os.listdir(csv_folder_path):
    if file_name.endswith('.csv'):  # Only process CSV files
        file_path = os.path.join(csv_folder_path, file_name)
        print(f'Importing {file_path}...')
        import_csv(file_path)

# Commit the transaction and close the connection
conn.commit()
conn.close()

print("All files imported successfully!")
