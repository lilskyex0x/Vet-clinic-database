/* Populate database with sample data. */
INSERT INTO
    animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES
    ('Agumon', '2020-02-03', 0, true, 10.23),
    ('Gabumon', '2018-11-15', 2, true, 8),
    ('Pikachu', '2021-01-07', 1, false, 15.04),
    ('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO
    animals (
        name,
        date_of_birth,
        weight_kg,
        neutered,
        escape_attempts
    )
VALUES
    ('Charmander', '2020-02-08', -11, false, 0),
    ('Plantmon', '2021-11-15', -5.7, true, 2),
    ('Squirtle', '1993-04-02', -12.13, false, 3),
    ('Angemon', '2005-06-12', -45, true, 1),
    ('Boarmon', '2005-06-07', 20.4, true, 7),
    ('Blossom', '1998-10-13', 17, true, 3),
    ('Ditto', '2022-05-14', 22, true, 4);

INSERT INTO
    owners (full_name, age)
VALUES
    ('San Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

INSERT INTO
    species (name)
VALUES
    ('Pokemon'),
    ('Digimon')

-- Update the species_id based on the name of the animal
BEGIN;

UPDATE animals
SET species_id = CASE
    WHEN name ILIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
    ELSE (SELECT id FROM species WHERE name = 'Pokemon')
END;

-- Commit the transaction
COMMIT;

SELECT * FROM animals;

-- Update the owner_id based on the owner's name and the animal's name
UPDATE animals
SET owner_id = (
    SELECT id FROM owners WHERE full_name = 'Sam Smith'
) WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (
    SELECT id FROM owners WHERE full_name = 'Jennifer Orwell'
) WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (
    SELECT id FROM owners WHERE full_name = 'Bob'
) WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (
    SELECT id FROM owners WHERE full_name = 'Melody Pond'
) WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (
    SELECT id FROM owners WHERE full_name = 'Dean Winchester'
) WHERE name IN ('Angemon', 'Boarmon');