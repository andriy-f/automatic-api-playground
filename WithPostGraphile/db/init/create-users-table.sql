CREATE TABLE users (
    id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    email VARCHAR(255) NOT NULL UNIQUE
);

-- Generate user data
INSERT INTO users (email) VALUES
    ('alice@example.com'),
    ('bob@example.com'),
    ('charlie@example.com');