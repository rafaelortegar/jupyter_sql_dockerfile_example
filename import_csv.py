import os
import pandas as pd
from sqlalchemy import create_engine

# PostgreSQL connection details
DB_USER = os.getenv('POSTGRES_USER', 'postgres')
DB_PASSWORD = os.getenv('PGPASSWORD', 'postgres_pwd')
DB_HOST = 'localhost'
DB_PORT = '5432'
DB_NAME = os.getenv('POSTGRES_DB', 'practice_db')

# Create the database connection
engine = create_engine(f'postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}')

# Directory where CSV files are stored
data_folder = '/workspace/data/'

# Process each CSV file in the data folder
for filename in os.listdir(data_folder):
    if filename.endswith('.csv'):
        file_path = os.path.join(data_folder, filename)
        table_name = os.path.splitext(filename)[0]  # Use filename (without extension) as table name

        print(f"Processing {filename} into table {table_name}...")

        # Load the CSV into a Pandas DataFrame
        df = pd.read_csv(file_path)

        # Write DataFrame to PostgreSQL
        df.to_sql(table_name, engine, if_exists='replace', index=False)

print("All CSV files have been imported successfully.")
