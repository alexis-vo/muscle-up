#!/bin/bash

DB_NAME="muscu"

# Vérifie si la base existe déjà
if psql -lqt | cut -d \| -f 1 | grep -qw "$DB_NAME"; then
  echo "⚠️  Database '$DB_NAME' already exists. Skipping creation."
else
  echo "🛠 Creating database: $DB_NAME"
  createdb $DB_NAME
fi

# Exécute le script d'initialisation
echo "📥 Initializing schema and data from init_all.sql..."
psql -d $DB_NAME -f init_all.sql

echo "✅ Done! The database '$DB_NAME' is now ready."
