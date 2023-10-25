CREATE TABLE
    animals (
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        date_of_birth DATE NOT NULL,
        escape_attempts INT NOT NULL,
        neutered BOOLEAN,
        weight_kg DECIMAL(5, 2) NOT NULL
    );