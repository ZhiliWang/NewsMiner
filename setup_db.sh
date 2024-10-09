#!/bin/bash

DB_NAME=${DB_NAME}
DB_USER=${DB_USER}
DB_PASSWORD=${DB_PASSWORD}
DB_HOST=${DB_HOST}
DB_PORT=${DB_PORT}

export PGPASSWORD=$DB_PASSWORD

echo "Creating database if it doesn't already exist."
psql -h $DB_HOST -U $DB_USER -p $DB_PORT -d postgres -tc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'" | grep -q 1 || \
psql -h $DB_HOST -U $DB_USER -p $DB_PORT -d postgres -c "CREATE DATABASE $DB_NAME"

echo "Creating table if it doesn't already exist."
psql -h $DB_HOST -U $DB_USER -p $DB_PORT -d $DB_NAME <<EOF
CREATE TABLE IF NOT EXISTS articles (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    content TEXT,
    published_at TIMESTAMP,
    source VARCHAR(100),
    url VARCHAR(255)
);
EOF

echo "Database and table created."
