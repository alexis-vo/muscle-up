-- SCHEMA

DROP TABLE IF EXISTS workout_exercises;
DROP TABLE IF EXISTS workouts;
DROP TABLE IF EXISTS exercises;
DROP TABLE IF EXISTS activities;
DROP TABLE IF EXISTS athletes;

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

CREATE TABLE exercises (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) UNIQUE,
  muscle_group VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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

CREATE TABLE workout_exercises (
  id SERIAL PRIMARY KEY,
  workout_id INT REFERENCES workouts(id) ON DELETE CASCADE,
  exercise_id INT REFERENCES exercises(id) ON DELETE CASCADE,
  sets INT CHECK (sets > 0),
  reps INT CHECK (reps > 0),
  weight NUMERIC(5,2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- INSERT EXAMPLES

INSERT INTO athletes (surname, first_name, last_name, city, birth_year)
VALUES 
  ('maxpower', 'Maxime', 'Durand', 'Paris', '1998-05-14'),
  ('lilith', 'Lila', 'Thompson', 'Lyon', '2001-09-27');

INSERT INTO activities (name, description)
VALUES 
  ('Musculation', 'Entraînement de force avec poids'),
  ('Cardio', 'Activités d’endurance : course, vélo, rameur');

INSERT INTO exercises (name, muscle_group)
VALUES 
  ('Développé couché', 'Poitrine'),
  ('Squat', 'Jambes'),
  ('Tractions', 'Dos'),
  ('Pompes', 'Poitrine'),
  ('Burpees', 'Full body');

INSERT INTO workouts (athlete_id, activity_id, start_time, end_time, notes)
VALUES
  (1, 1, '2025-04-19 18:00', '2025-04-19 19:00', 'Séance très intense'),
  (2, 2, '2025-04-18 10:00', '2025-04-18 10:45', 'Cardio doux post-blessure');

INSERT INTO workout_exercises (workout_id, exercise_id, sets, reps, weight)
VALUES
  (1, 1, 4, 10, 60.0),
  (1, 2, 3, 8, 80.0),
  (2, 5, 5, 12, 0);


-- VIEWS

CREATE OR REPLACE VIEW workout_summary AS
SELECT
  w.id AS workout_id,
  a.surname,
  w.start_time,
  w.end_time,
  ex.name AS exercise,
  we.sets,
  we.reps,
  we.weight
FROM workouts w
JOIN athletes a ON a.id = w.athlete_id
JOIN workout_exercises we ON we.workout_id = w.id
JOIN exercises ex ON ex.id = we.exercise_id
ORDER BY w.start_time;

CREATE OR REPLACE VIEW weekly_progress AS
SELECT
  a.surname,
  date_trunc('week', w.start_time) AS week,
  SUM(we.sets * we.reps) AS total_reps
FROM workout_exercises we
JOIN workouts w ON we.workout_id = w.id
JOIN athletes a ON w.athlete_id = a.id
GROUP BY a.surname, week
ORDER BY week;

CREATE OR REPLACE VIEW average_weight_by_exercise AS
SELECT
  ex.name AS exercise,
  ROUND(AVG(we.weight), 2) AS avg_weight,
  COUNT(*) AS total_sessions
FROM workout_exercises we
JOIN exercises ex ON we.exercise_id = ex.id
GROUP BY ex.name
ORDER BY avg_weight DESC;
