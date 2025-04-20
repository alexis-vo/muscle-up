from datetime import datetime
from models.base import Athlete, Exercise, Workout, WorkoutExercise

from database.queries import load_weekly_progress
from visualizations.weekly_progress import WeeklyProgressPlot

def main():
    print("📊 Loading weekly progress data...")
    df = load_weekly_progress()
    if df.empty:
        print("ℹ️ No data found in the database.")
        return

    plot = WeeklyProgressPlot(df)
    plot.show()

if __name__ == "__main__":
    main()
    