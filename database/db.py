import psycopg2
from psycopg2.extras import RealDictCursor
from config import DB_CONFIG

def get_connection():
    return psycopg2.connect(
        host=DB_CONFIG['host'],
        dbname=DB_CONFIG['dbname'],
        user=DB_CONFIG['user'],
        password=DB_CONFIG['password'],
        cursor_factory=RealDictCursor
    )