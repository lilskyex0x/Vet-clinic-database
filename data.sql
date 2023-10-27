/* Populate database with sample data. */
INSERT INTO animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES ('Agumon', '2020-02-03', 0, true, 10.23),
    ('Gabumon', '2018-11-15', 2, true, 8),
    ('Pikachu', '2021-01-07', 1, false, 15.04),
    ('Devimon', '2017-05-12', 5, true, 11);
INSERT INTO animals (
        name,
        date_of_birth,
        weight_kg,
        neutered,
        escape_attempts
    )
VALUES ('Charmander', '2020-02-08', -11, false, 0),
    ('Plantmon', '2021-11-15', -5.7, true, 2),
    ('Squirtle', '1993-04-02', -12.13, false, 3),
    ('Angemon', '2005-06-12', -45, true, 1),
    ('Boarmon', '2005-06-07', 20.4, true, 7),
    ('Blossom', '1998-10-13', 17, true, 3),
    ('Ditto', '2022-05-14', 22, true, 4);
INSERT INTO owners (full_name, age)
VALUES ('San Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);
INSERT INTO species (name)
VALUES ('Pokemon'),
    ('Digimon') -- Update the species_id based on the name of the animal
    BEGIN;
UPDATE animals
SET species_id = CASE
        WHEN name ILIKE '%mon' THEN (
            SELECT id
            FROM species
            WHERE name = 'Digimon'
        )
        ELSE (
            SELECT id
            FROM species
            WHERE name = 'Pokemon'
        )
    END;
-- Commit the transaction
COMMIT;
SELECT *
FROM animals;
-- Update the owner_id based on the owner's name and the animal's name
UPDATE animals
SET owner_id = (
        SELECT id
        FROM owners
        WHERE full_name = 'Sam Smith'
    )
WHERE name = 'Agumon';
UPDATE animals
SET owner_id = (
        SELECT id
        FROM owners
        WHERE full_name = 'Jennifer Orwell'
    )
WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals
SET owner_id = (
        SELECT id
        FROM owners
        WHERE full_name = 'Bob'
    )
WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals
SET owner_id = (
        SELECT id
        FROM owners
        WHERE full_name = 'Melody Pond'
    )
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals
SET owner_id = (
        SELECT id
        FROM owners
        WHERE full_name = 'Dean Winchester'
    )
WHERE name IN ('Angemon', 'Boarmon');
-- Vet William Tatcher is specialized in Pokemon (Species ID: 1)
INSERT INTO specializations (vet_id, species_id)
VALUES (1, 1);
-- Vet Stephanie Mendez is specialized in Digimon (Species ID: 2) and Pokemon (Species ID: 1)
INSERT INTO specializations (vet_id, species_id)
VALUES (2, 2),
    (2, 1);
-- Vet Jack Harkness is specialized in Digimon (Species ID: 2)
INSERT INTO specializations (vet_id, species_id)
VALUES (3, 2);
-- Agumon visited William Tatcher on May 24th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (1, 1, '2020-05-24');
-- Agumon visited Stephanie Mendez on Jul 22nd, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (1, 2, '2020-07-22');
-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (2, 3, '2021-02-02');
-- Pikachu visited Maisy Smith on Jan 5th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (3, 4, '2020-01-05');
-- Pikachu visited Maisy Smith on Mar 8th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (3, 4, '2020-03-08');
-- Pikachu visited Maisy Smith on May 14th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (3, 4, '2020-05-14');
-- Devimon visited Stephanie Mendez on May 4th, 2021.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (4, 2, '2021-05-04');
-- Charmander visited Jack Harkness on Feb 24th, 2021.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (5, 3, '2021-02-24');
-- Plantmon visited Maisy Smith on Dec 21st, 2019.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (6, 4, '2019-12-21');
-- Plantmon visited William Tatcher on Aug 10th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (6, 1, '2020-08-10');
-- Plantmon visited Maisy Smith on Apr 7th, 2021.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (6, 4, '2021-04-07');
-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (7, 2, '2019-09-29');
-- Angemon visited Jack Harkness on Oct 3rd, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (8, 3, '2020-10-03');
-- Angemon visited Jack Harkness on Nov 4th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (8, 3, '2020-11-04');
-- Boarmon visited Maisy Smith on Jan 24th, 2019.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (9, 4, '2019-01-24');
-- Boarmon visited Maisy Smith on May 15th, 2019.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (9, 4, '2019-05-15');
-- Boarmon visited Maisy Smith on Feb 27th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (9, 4, '2020-02-27');
-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (9, 4, '2020-08-03');
-- Blossom visited Stephanie Mendez on May 24th, 2020.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (10, 2, '2020-05-24');
-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES (10, 1, '2021-01-11');