#!/bin/bash

DB_NAME="muscu"

echo "🧨 Dropping database '$DB_NAME' if it exists..."
dropdb --if-exists $DB_NAME

echo "🛠 Creating database: $DB_NAME"
createdb $DB_NAME

echo "📥 Re-initializing schema and data from init_all.sql..."
psql -d $DB_NAME -f init_all.sql

echo "✅ Done! The database '$DB_NAME' has been reset and initialized."
