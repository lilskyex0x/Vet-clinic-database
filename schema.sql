CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN,
    weight_kg DECIMAL(5, 2) NOT NULL,
    species text,
);
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR,
    age INTEGER
);
CREATE TABLE species (id SERIAL PRIMARY KEY, name VARCHAR);
-- Remove the "species" column
ALTER TABLE animals DROP COLUMN species;
-- Add the "species_id" column as a foreign key referencing the "species" table
ALTER TABLE animals
ADD COLUMN species_id INTEGER REFERENCES species (id);
-- Add the "owner_id" column as a foreign key referencing the "owners" table
ALTER TABLE animals
ADD COLUMN owner_id INTEGER REFERENCES owners (id);
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    date_of_graduation DATE
);
CREATE TABLE specializations (
    vet_id INTEGER,
    species_id INTEGER,
    PRIMARY KEY (vet_id, species_id),
    FOREIGN KEY (vet_id) REFERENCES vets (id),
    FOREIGN KEY (species_id) REFERENCES species (id)
);
CREATE TABLE visits (
    visit_id SERIAL PRIMARY KEY,
    animal_id INTEGER,
    vet_id INTEGER,
    visit_date DATE,
    FOREIGN KEY (animal_id) REFERENCES animals (id),
    FOREIGN KEY (vet_id) REFERENCES vets (id)
);
