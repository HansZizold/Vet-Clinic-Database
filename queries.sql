-- Find all animals whose name ends in "mon".
select * from animals where name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
select name from animals where date_of_birth between '2016-12-31' and '2019-01-01';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
select name from animals where neutered = 'true' and escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
select name, date_of_birth from animals where name = 'Agumon' or name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
select name, escape_attempts from animals where weigth_kg > 10.5;

-- Find all animals that are neutered.
select * from animals where neutered = 'true';

-- Find all animals not named Gabumon.
select * from animals where name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
select * from animals where weigth_kg between 10.3 and 17.4;


-- TRANSACTION EXERCISES

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
begin;
update animals
set species = 'unspecified';
select * from animals;
rollback;
select * from animals;

-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Commit the transaction.
-- Verify that change was made and persists after commit.
begin;
update animals
set species = 'digimon'
where name LIKE '%mon';
update animals
set species = 'pokemon'
where species is null;
commit;
select * from animals;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
-- After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual ;)
begin;
delete from animals;
select * from animals;
rollback;
select * from animals;

-- Inside a transaction: delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction
begin;
delete from animals where date_of_birth > '2022-01-01';
SAVEPOINT birth;
update animals
set weigth_kg = weigth_kg*(-1);
rollback to birth;
update animals 
set weigth_kg = weigth_kg*(-1) 
where weigth_kg < 0; 
select * from animals;
commit;


-- QUERY EXERCISES

-- How many animals are there?
select count(*) from animals; 

-- How many animals have never tried to escape?
select count(*) from animals where escape_attempts = 0; 

-- What is the average weight of animals?
select avg(weigth_kg) from animals;

-- Who escapes the most, neutered or not neutered animals?
select name, escape_attempts from animals 
group by name, escape_attempts 
order by escape_attempts DESC
limit 1;

-- What is the minimum and maximum weight of each type of animal?
select species, max(weigth_kg), min(weigth_kg) from animals group by species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
select species, avg(escape_attempts) from animals 
where date_of_birth between '1990-01-01' and '2000-12-31'
group by species;

-- DAY 3
-- QUERY MULTIPLE TABLES

-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
select name as animal, full_name as Owner from animals
inner join owners on owner_id = owners.id
where full_name = 'Melody Pond'; 
-- List of all animals that are pokemon (their type is Pokemon).
select animals.name as animal, species.name as type from animals
inner join species on species_id = species.id
where species.name = 'Pokemon'; 
-- List all owners and their animals, remember to include those that don't own any animal.
select full_name as owner, animals.name as animal from owners
left join animals on owners.id = animals.owner_id;
-- How many animals are there per species?
select species.name, count(animals.species_id) from species
inner join animals on species.id = animals.species_id
group by species.name;
-- List all Digimon owned by Jennifer Orwell.
select animals.name as animal, full_name as Owner, species.name as type from animals
inner join owners on owner_id = owners.id
inner join species on species_id = species.id
where full_name = 'Jennifer Orwell' and species.name = 'Digimon'; 
-- List all animals owned by Dean Winchester that haven't tried to escape.
select animals.name as animal, escape_attempts as "escape attempts" from animals
inner join owners on owner_id = owners.id
where escape_attempts = 0 and full_name = 'Dean Winchester';
-- Who owns the most animals?
select full_name, count(animals.name) as quantity from owners
inner join animals on owners.id = owner_id
group by full_name
order by quantity desc
limit 1;

-- DAY 4
-- ADD JOIN TABLE FOR VISITS

-- Who was the last animal seen by William Tatcher?
select animals.name as animal, max(visits.visit_date) as "last visit date", vets.name as vet from animals
inner join visits on animals.id = visits.animals_id
inner join vets on visits.vets_id = vets.id
group by vet, animal
having vets.name = 'William Tatcher'
order by "last visit date" desc
limit 1;

-- How many different animals did Stephanie Mendez see?
select vets.name as vet, count(visits.animals_id) as "#animal attended" from visits
inner join animals on animals.id = visits.animals_id
inner join vets on vets.id = visits.vets_id
group by vet
having vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
select vets.name as vet, species.name as "specialized in" from vets
left join specializations on specializations.vets_id = vets.id
left join species on species.id = specializations.species_id
group by vets.name, species.name; 

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
select vets.name as vet, animals.name as animal, visits.visit_date as "visit date" from animals
inner join visits on visits.animals_id = animals.id
inner join vets on vets.id = visits.vets_id
group by animals.name, vets.name, visits.visit_date
having vets.name = 'Stephanie Mendez' and visits.visit_date between '2020-04-01' and '2020-08-30';

-- What animal has the most visits to vets?
select animals.name as animal, count(visits.animals_id) as "# vet visits" from animals
inner join visits on visits.animals_id = animals.id
group by animals.name
order by "# vet visits" desc 
limit 1;

-- Who was Maisy Smith's first visit?
select vets.name as vet, animals.name as animal, visits.visit_date as "first visit date" from animals
inner join visits on visits.animals_id = animals.id
inner join vets on vets.id = visits.vets_id
group by vets.name, animals.name, visits.visit_date
having vets.name = 'Maisy Smith'
order by "first visit date" asc
limit 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
select animals.name as animal, animals.date_of_birth as "date of birth", animals.weigth_kg as "animal weigth kg", vets.name as vet, vets.age as "vet age", visit_date as "most recent visit" from visits
inner join animals on animals.id = visits.animals_id
inner join vets on vets.id = visits.vets_id
group by animals.name, animals.date_of_birth, animals.weigth_kg, vets.name, vets.age, visit_date
order by "most recent visit" desc
limit 1;

-- How many visits were with a vet that did not specialize in that animal's species?
select count(*) as "visits to not specialists" from visits
left join animals on visits.animals_id = animals.id
left join vets on visits.vets_id = vets.id
where animals.species_id not in (
  select species_id from specializations
  where vets_id = vets.id
);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
select vets.name, species.name, count(visits.animals_id) from visits
inner join animals on animals.id = visits.animals_id
inner join species on species.id = animals.species_id
inner join vets on vets.id = visits.vets_id
where vets.name = 'Maisy Smith'
group by vets.name, species.name;
-- Based on the result, I'd recommend Maisy to specialize in Digimon
