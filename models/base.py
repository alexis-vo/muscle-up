from datetime import datetime
from typing import List

class Athlete:
    def __init__(self, id: int, surname: str, first_name: str, last_name: str, birth_date: str, city: str):
        self.id = id
        self.surname = surname
        self.first_name = first_name
        self.last_name = last_name
        self.birth_date = birth_date
        self.city = city

    def full_name(self):
        return f"{self.first_name} {self.last_name}"

class Exercise:
    def __init__(self, id: int, name: str, muscle_group: str):
        self.id = id
        self.name = name
        self.muscle_group = muscle_group

class WorkoutExercise:
    def __init__(self, exercise: Exercise, sets: int, reps: int, weight: float):
        self.exercise = exercise
        self.sets = sets
        self.reps = reps
        self.weight = weight

    def total_reps(self):
        return self.sets * self.reps

    def total_volume(self):
        return self.sets * self.reps * self.weight

class Workout:
    def __init__(self, id: int, athlete: Athlete, start_time: datetime, end_time: datetime, notes: str = ""):
        self.id = id
        self.athlete = athlete
        self.start_time = start_time
        self.end_time = end_time
        self.notes = notes
        self.exercises: List[WorkoutExercise] = []

    def add_exercise(self, workout_exercise: WorkoutExercise):
        self.exercises.append(workout_exercise)

    def total_reps(self):
        return sum(w.total_reps() for w in self.exercises)

    def total_volume(self):
        return sum(w.total_volume() for w in self.exercises)

    def duration_minutes(self):
        return (self.end_time - self.start_time).total_seconds() / 60