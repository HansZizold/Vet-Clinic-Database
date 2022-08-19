insert into animals (id, name, date_of_birth, escape_attempts, neutered, weigth_kg)
OVERRIDING SYSTEM VALUE
values (1, 'Agumon', '2020-02-03', 0, true, 10.23);
insert into animals (id, name, date_of_birth, escape_attempts, neutered, weigth_kg)
OVERRIDING SYSTEM VALUE
values (2, 'Gabumon', '2018-11-15', 2, true, 8);
insert into animals (id, name, date_of_birth, escape_attempts, neutered, weigth_kg)
OVERRIDING SYSTEM VALUE
values (3, 'Pikachu', '2021-01-07', 1, false, 15.04);
insert into animals (id, name, date_of_birth, escape_attempts, neutered, weigth_kg)
OVERRIDING SYSTEM VALUE
values (4, 'Devimon', '2017-05-12', 5, true, 11);

-- QUERY AND UPDATE

-- Addition of seven new registers

-- His name is Charmander. He was born on Feb 8th, 2020, and currently weighs -11kg. He is not neutered and he has never tried to escape.
insert into animals (id, name, date_of_birth, escape_attempts, neutered, weigth_kg)
OVERRIDING SYSTEM VALUE
values (5, 'Charmander', '2020-02-08', 0, false, -11);
-- Animal: Her name is Plantmon. She was born on Nov 15th, 2021, and currently weighs -5.7kg. She is neutered and she has tried to escape 2 times.
insert into animals (id, name, date_of_birth, escape_attempts, neutered, weigth_kg)
OVERRIDING SYSTEM VALUE
values (6, 'Plantmon', '2021-11-15', 2, true, -5.7);
-- Animal: His name is Squirtle. He was born on Apr 2nd, 1993, and currently weighs -12.13kg. He was not neutered and he has tried to escape 3 times.
insert into animals (id, name, date_of_birth, escape_attempts, neutered, weigth_kg)
OVERRIDING SYSTEM VALUE
values (7, 'Squirtle', '1993-04-02', 3, false, -12.13);
-- Animal: His name is Angemon. He was born on Jun 12th, 2005, and currently weighs -45kg. He is neutered and he has tried to escape once.
insert into animals (id, name, date_of_birth, escape_attempts, neutered, weigth_kg)
OVERRIDING SYSTEM VALUE
values (8, 'Angemon', '2005-06-12', 1, true, -45);
-- Animal: His name is Boarmon. He was born on Jun 7th, 2005, and currently weighs 20.4kg. He is neutered and he has tried to escape 7 times.
insert into animals (id, name, date_of_birth, escape_attempts, neutered, weigth_kg)
OVERRIDING SYSTEM VALUE
values (9, 'Boarmon', '2005-06-07', 7, true, 20.4);
-- Animal: Her name is Blossom. She was born on Oct 13th, 1998, and currently weighs 17kg. She is neutered and she has tried to escape 3 times.
insert into animals (id, name, date_of_birth, escape_attempts, neutered, weigth_kg)
OVERRIDING SYSTEM VALUE
values (10, 'Blossom', '1998-10-13', 3, true, 17);
-- Animal: His name is Ditto. He was born on May 14th, 2022, and currently weighs 22kg. He is neutered and he has tried to escape 4 times.
insert into animals (id, name, date_of_birth, escape_attempts, neutered, weigth_kg)
OVERRIDING SYSTEM VALUE
values (11, 'Ditto', '2022-05-14', 4, true, 22);

-- DAY 3

-- QUERY MULTIPLE TABLES

-- Insert the following data into the owners table:
-- Sam Smith 34 years old.
-- Jennifer Orwell 19 years old.
-- Bob 45 years old.
-- Melody Pond 77 years old.
-- Dean Winchester 14 years old.
-- Jodie Whittaker 38 years old.
insert into owners (full_name, age)
values 
  ('Sam Smith', 34), 
  ('Jennifer Orwell', 19), 
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

-- Insert the following data into the species table:
-- Pokemon
-- Digimon
insert into species (name)
values 
  ('Pokemon'), 
  ('Digimon');

-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon
update animals
set species_id = 2
where name LIKE '%mon';
update animals
set species_id = 1
where species_id is null;
select * from animals;

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
-- Jennifer Orwell owns Gabumon and Pikachu.
-- Bob owns Devimon and Plantmon.
-- Melody Pond owns Charmander, Squirtle, and Blossom.
-- Dean Winchester owns Angemon and Boarmon.
update animals
set owner_id = 1
where name = 'Agumon';

update animals
set owner_id = 2
where name = 'Gabumon' or name = 'Pikachu';

update animals
set owner_id = 3
where name = 'Devimon' or name = 'Plantmon';

update animals
set owner_id = 4
where name = 'Charmander' or name = 'Squirtle' or name = 'Blossom';

update animals
set owner_id = 5
where name = 'Angemon' or name = 'Boarmon';

-- DAY 4
-- ADD JOIN TABLE FOR VISITS

-- Insert the following data for vets:
-- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
-- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
-- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
-- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
insert into vets (name, age, date_of_graduation)
values 
  ('William Tatcher', 45, '2000-04-23'), 
  ('Maisy Smith', 26, '2019-01-17'), 
  ('Stephanie Mendez', 64, '1981-05-04'), 
  ('Jack Harness', 38, '2008-06-08'); 

-- Insert the following data for specialties:
-- Vet William Tatcher is specialized in Pokemon.
-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
-- Vet Jack Harkness is specialized in Digimon.
insert into specializations (species_id, vets_id)
values 
  (1, 1), 
  (1, 3), 
  (2, 3), 
  (2, 4); 

-- Insert the following data for visits:
-- Agumon visited William Tatcher on May 24th, 2020.
-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
-- Pikachu visited Maisy Smith on Jan 5th, 2020.
-- Pikachu visited Maisy Smith on Mar 8th, 2020.
-- Pikachu visited Maisy Smith on May 14th, 2020.
-- Devimon visited Stephanie Mendez on May 4th, 2021.
-- Charmander visited Jack Harkness on Feb 24th, 2021.
-- Plantmon visited Maisy Smith on Dec 21st, 2019.
-- Plantmon visited William Tatcher on Aug 10th, 2020.
-- Plantmon visited Maisy Smith on Apr 7th, 2021.
-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
-- Angemon visited Jack Harkness on Oct 3rd, 2020.
-- Angemon visited Jack Harkness on Nov 4th, 2020.
-- Boarmon visited Maisy Smith on Jan 24th, 2019.
-- Boarmon visited Maisy Smith on May 15th, 2019.
-- Boarmon visited Maisy Smith on Feb 27th, 2020.
-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
-- Blossom visited Stephanie Mendez on May 24th, 2020.
-- Blossom visited William Tatcher on Jan 11th, 2021.
insert into visits (animals_id, vets_id, visit_date)
values 
  (1, 1, '2020-05-24'),
  (1, 3, '2020-07-22'),
  (2, 4, '2021-02-02'),
  (3, 2, '2020-01-05'),
  (3, 2, '2020-03-08'),
  (3, 2, '2020-05-14'),
  (4, 3, '2021-05-04'),
  (5, 4, '2021-02-24'),
  (6, 2, '2019-12-21'),
  (6, 1, '2020-08-10'),
  (6, 2, '2021-04-07'),
  (7, 3, '2019-09-29'),
  (8, 4, '2020-10-03'),
  (8, 4, '2020-11-04'),
  (9, 2, '2019-01-24'),
  (9, 2, '2019-05-15'),
  (9, 2, '2020-02-27'),
  (9, 2, '2020-08-03'),
  (10, 3, '2020-05-24'),
  (10, 1, '2021-06-11');
