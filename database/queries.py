from database.db import get_connection
import pandas as pd

def load_weekly_progress():
    query = "SELECT * FROM weekly_progress ORDER BY week;"
    with get_connection() as conn:
        return pd.read_sql_query(query, conn)