DROP TABLE IF EXISTS athletes;
DROP TABLE IF EXISTS activities;
DROP TABLE IF EXISTS workouts;
DROP TABLE IF EXISTS exercices;
DROP TABLE IF EXISTS workout_exercises;

CREATE TABLE athletes (
  id SERIAL PRIMARY KEY,
  surname VARCHAR(50) UNIQUE,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  city VARCHAR(50),
  birth_year DATE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE activities (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) UNIQUE,
  description TEXT
);

CREATE TABLE workouts (
  id SERIAL PRIMARY KEY,
  athlete_id INT REFERENCES athletes(id) ON DELETE CASCADE,
  activity_id INT REFERENCES activities(id),
  start_time TIMESTAMP,
  end_time TIMESTAMP,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE exercises (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE,
  muscle_group VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE workout_exercises (
  id SERIAL PRIMARY KEY,
  workout_id INT REFERENCES workouts(id) ON DELETE CASCADE,
  exercise_id INT REFERENCES exercises(id) ON DELETE CASCADE,
  sets INT CHECK (sets > 0),
  reps INT CHECK (reps > 0),
  weight NUMERIC(5,2)  -- accuracy
);
