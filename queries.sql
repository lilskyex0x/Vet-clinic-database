/*Queries that provide answers to the questions from all projects.*/
SELECT *
FROM animals
WHERE name LIKE '%mon';
SELECT name
FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name
FROM animals
WHERE neutered = true
    AND escape_attempts < 3;
SELECT date_of_birth
FROM animals
WHERE name IN ('Agumon', 'Pikachu');
SELECT name,
    escape_attempts
FROM animals
WHERE weight_kg > 10.5;
SELECT *
FROM animals
WHERE neutered = true;
SELECT *
FROM animals
WHERE name != 'Gabumon';
SELECT *
FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;
-- Inside a transaction update the animals table by setting the species column to unspecified.
BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT *
FROM animals;
ROLLBACK;
SELECT *
FROM animals;
BEGIN;
-- Update the "species" column to 'digimon' for animals with names ending in 'mon'
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
-- Update the "species" column to 'pokemon' for animals with no species set
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
-- Verify the changes made in the transaction
SELECT *
FROM animals;
-- Commit the transaction to make the changes permanent
COMMIT;
-- Verify that changes persist after the commit
SELECT *
FROM animals;
-- Start a new transaction
BEGIN;
-- Delete all records from the "animals" table
DELETE FROM animals;
-- Verify that records have been deleted within the transaction
SELECT COUNT(*)
FROM animals;
-- Roll back the transaction to undo the deletions
ROLLBACK;
SELECT COUNT(*)
FROM animals;
-- Start a new transaction
BEGIN;
-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
-- Create a savepoint for the transaction
SAVEPOINT before_update;
-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals
SET weight_kg = - weight_kg;
SELECT *
FROM animals;
-- Rollback to the savepoint
ROLLBACK TO before_update;
-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals
SET weight_kg = - weight_kg
WHERE weight_kg < 0;
-- Commit the transaction
COMMIT;
END;
SELECT *
FROM animals;
-- total animal check
SELECT COUNT(*) AS total_animals
FROM animals;
-- animals that have never tried to escape
SELECT COUNT(*) AS non_escape_count
FROM animals
WHERE escape_attempts = 0;
-- average weight of animals
SELECT AVG(weight_kg) AS average_weight
FROM animals;
-- escapes the most, neutered or not neutered animals
SELECT neutered,
    MAX(escape_attempts) AS max_escape_attempts
FROM animals
GROUP BY neutered;
--  the minimum and maximum weight of each type of animal
SELECT species,
    MIN(weight_kg) AS min_weight,
    MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;
-- the average number of escape attempts per animal type of those born between 1990 and 2000
SELECT species,
    AVG(escape_attempts) AS avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;
SELECT a.name
FROM animals a
    JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';
SELECT a.name
FROM animals a
    JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';
SELECT o.full_name,
    COALESCE(array_agg(a.name), ARRAY []::text []) AS animals
FROM owners o
    LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name;
SELECT s.name AS species,
    COUNT(a.id) AS number_of_animals
FROM species s
    LEFT JOIN animals a ON s.id = a.species_id
GROUP BY s.name;
SELECT a.name
FROM animals a
    JOIN species s ON a.species_id = s.id
    JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Jennifer Orwell'
    AND s.name = 'Digimon';
SELECT a.name
FROM animals a
    JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester'
    AND a.escape_attempts = 0;
SELECT o.full_name,
    COUNT(a.id) AS num_of_animals
FROM owners o
    LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY num_of_animals DESC
LIMIT 1;
SELECT a.name AS last_animal_seen
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = 1
ORDER BY v.visit_date DESC
LIMIT 1;
SELECT COUNT(DISTINCT v.animal_id) AS number_of_animals_seen
FROM visits v
WHERE v.vet_id = 2;
SELECT v.name AS vet_name, s.name AS specialty
FROM vets v
LEFT JOIN specializations s ON v.id = s.vet_id;
SELECT a.name AS animal_name
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = 2
  AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';
SELECT a.name AS animal_name, COUNT(v.visit_id) AS visit_count
FROM visits v
JOIN animals a ON v.animal_id = a.id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;
SELECT a.name AS first_visit_animal
FROM visits v
JOIN animals a ON v.animal_id = a.id
WHERE v.vet_id = 4
ORDER BY v.visit_date
LIMIT 1;
SELECT a.name AS animal_name, v.name AS vet_name, vst.visit_date
FROM visits vst
JOIN animals a ON vst.animal_id = a.id
JOIN vets v ON vst.vet_id = v.id
ORDER BY vst.visit_date DESC
LIMIT 1;
SELECT COUNT(*) AS num_visits_with_non_specialized_vet
FROM visits v
LEFT JOIN specializations s ON v.vet_id = s.vet_id AND v.animal_id = s.species_id
WHERE s.vet_id IS NULL;
SELECT s.name AS suggested_specialty
FROM (
    SELECT vst.vet_id, a.species_id, COUNT(*) AS visit_count
    FROM visits vst
    JOIN animals a ON vst.animal_id = a.id
    WHERE vst.vet_id = 4 -- Assuming 4 is Maisy Smith's vet ID
    GROUP BY vst.vet_id, a.species_id
    ORDER BY visit_count DESC
    LIMIT 1
) AS most_visited_species
JOIN species s ON most_visited_species.species_id = s.id;
