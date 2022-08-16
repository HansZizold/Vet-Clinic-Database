insert into animals (name, date_of_birth, escape_attempts, neutered, weigth_kg)
values ('Agumon', '2020-02-03', 0, true, 10.23);

insert into animals (name, date_of_birth, escape_attempts, neutered, weigth_kg)
values ('Gabumon', '2018-11-15', 2, true, 8);

insert into animals (name, date_of_birth, escape_attempts, neutered, weigth_kg)
values ('Pikachu', '2021-01-07', 1, false, 15.04);

insert into animals (name, date_of_birth, escape_attempts, neutered, weigth_kg)
values ('Devimon', '2017-05-12', 5, true, 11);

-- QUERY AND UPDATE

-- Addition of seven new registers

-- His name is Charmander. He was born on Feb 8th, 2020, and currently weighs -11kg. He is not neutered and he has never tried to escape.
insert into animals (name, date_of_birth, escape_attempts, neutered, weigth_kg)
values ('Charmander', '2020-02-08', 0, false, 11);

-- Animal: Her name is Plantmon. She was born on Nov 15th, 2021, and currently weighs -5.7kg. She is neutered and she has tried to escape 2 times.
insert into animals (name, date_of_birth, escape_attempts, neutered, weigth_kg)
values ('Plantmon', '2021-11-15', 2, true, 5.7);

-- Animal: His name is Squirtle. He was born on Apr 2nd, 1993, and currently weighs -12.13kg. He was not neutered and he has tried to escape 3 times.
insert into animals (name, date_of_birth, escape_attempts, neutered, weigth_kg)
values ('Squirtle', '1993-04-02', 3, false, 12.13);

-- Animal: His name is Angemon. He was born on Jun 12th, 2005, and currently weighs -45kg. He is neutered and he has tried to escape once.
insert into animals (name, date_of_birth, escape_attempts, neutered, weigth_kg)
values ('Angemon', '2005-06-12', 1, true, 45);

-- Animal: His name is Boarmon. He was born on Jun 7th, 2005, and currently weighs 20.4kg. He is neutered and he has tried to escape 7 times.
insert into animals (name, date_of_birth, escape_attempts, neutered, weigth_kg)
values ('Boarmon', '2005-06-07', 7, true, 20.4);

-- Animal: Her name is Blossom. She was born on Oct 13th, 1998, and currently weighs 17kg. She is neutered and she has tried to escape 3 times.
insert into animals (name, date_of_birth, escape_attempts, neutered, weigth_kg)
values ('Blossom', '1998-10-13', 3, true, 17);

-- Animal: His name is Ditto. He was born on May 14th, 2022, and currently weighs 22kg. He is neutered and he has tried to escape 4 times.
insert into animals (name, date_of_birth, escape_attempts, neutered, weigth_kg)
values ('Ditto', '2022-05-14', 4, true, 22);

-- Transaction Exercises

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
select * from animals;
commit;
