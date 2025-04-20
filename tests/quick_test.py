from datetime import datetime
from models.base import Athlete, Exercise, Workout, WorkoutExercise

# Création d'un athlète
alex = Athlete(1, "alexfit", "Alexis", "VO", "2000-10-12", "Paris")

# Exercices
dc = Exercise(1, "Développé couché", "Poitrine")
squat = Exercise(2, "Squat", "Jambes")

# Séance + exercices
workout = Workout(1, alex, datetime(2025, 4, 22, 18), datetime(2025, 4, 22, 19), "Bonne séance")
workout.add_exercise(WorkoutExercise(dc, sets=4, reps=10, weight=60))
workout.add_exercise(WorkoutExercise(squat, sets=3, reps=8, weight=80))

# Affichage
print(f"🏋️‍♂️ {alex.full_name()} did a workout on {workout.start_time.date()}")
print(f"→ Duration: {workout.duration_minutes()} minutes")
print(f"→ Total reps: {workout.total_reps()}")
print(f"→ Total volume: {workout.total_volume()} kg lifted")