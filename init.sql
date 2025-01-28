CREATE DATABASE practice_db;

\c practice_db;

CREATE TABLE IF NOT EXISTS users_test (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100) UNIQUE
);

INSERT INTO users_test (name, email) VALUES ('Alice', 'alice@example.com') ON CONFLICT DO NOTHING;
INSERT INTO users_test (name, email) VALUES ('Bob', 'bob@example.com') ON CONFLICT DO NOTHING;
