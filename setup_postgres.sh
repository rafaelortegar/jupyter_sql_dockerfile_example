#!/bin/bash

set -e  # Exit on any error

echo "----------------------------------------"
echo "🚀 Starting PostgreSQL Setup"
echo "----------------------------------------"

# Check the status of PostgreSQL service
echo "1. Checking PostgreSQL service status..."
service postgresql status || echo "PostgreSQL is not running."

# Start PostgreSQL service
echo "2. Starting PostgreSQL service..."
service postgresql start

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to initialize..."
sleep 10

# Ensure the practice_db database exists
echo "3. Checking if database 'practice_db' exists..."
DB_EXISTS=$(PGPASSWORD=postgres_pwd psql -U postgres -tAc "SELECT 1 FROM pg_database WHERE datname='practice_db'")
if [ "$DB_EXISTS" != "1" ]; then
    echo "Creating database 'practice_db'..."
    PGPASSWORD=postgres_pwd psql -U postgres -c "CREATE DATABASE practice_db;"
    echo "Database 'practice_db' created successfully."
else
    echo "Database 'practice_db' already exists."
fi

# Run the SQL initialization script
echo "4. Running SQL initialization script..."
PGPASSWORD=postgres_pwd psql -U postgres -d practice_db -f /docker-entrypoint-initdb.d/init.sql
if [ $? -ne 0 ]; then
    echo "Error: Failed to run the SQL init script."
    exit 1
fi

# Run the Python script to create tables and import data
echo "5. Running Python script to create tables and import data..."
python /workspace/import_csv.py
if [ $? -ne 0 ]; then
    echo "Error: Failed to run the Python script."
    exit 1
fi

echo "----------------------------------------"
echo "✅ PostgreSQL Setup Completed Successfully!"
echo "----------------------------------------"
echo "This are the available tables on your practice_db environment"

PGPASSWORD=postgres_pwd psql -U postgres -d practice_db -c "\dt"