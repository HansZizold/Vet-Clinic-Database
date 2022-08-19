-- DAY 1
CREATE TABLE animals (
  id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
  name TEXT,
  date_of_birth date,
  escape_attempts integer,
  neutered boolean,
  weigth_kg decimal,
  PRIMARY KEY(id)
);

ALTER TABLE animals
ALTER COLUMN name TYPE varchar;

-- DAY 2
ALTER TABLE animals
ADD COLUMN species VARCHAR;

-- DAY 3
-- QUERY MULTIPLE TABLES

-- Create a table named owners with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- full_name: string
-- age: integer
CREATE TABLE owners (
  id integer GENERATED ALWAYS AS IDENTITY,
  full_name varchar,
  age integer,
  PRIMARY KEY(id)
);

-- Create a table named species with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
CREATE TABLE species (
  id integer GENERATED ALWAYS AS IDENTITY,
  name varchar,
  PRIMARY KEY(id)
);

-- Modify animals table:
-- Make sure that id is set as autoincremented PRIMARY KEY
-- Remove column species
ALTER TABLE animals
DROP COLUMN species;
-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD COLUMN species_id int;
ALTER TABLE animals
ADD CONSTRAINT FK_species
FOREIGN KEY (species_id) 
REFERENCES species(id);
-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
ADD COLUMN owner_id int;
ALTER TABLE animals
ADD CONSTRAINT FK_owner
FOREIGN KEY (owner_id)
REFERENCES owners(id);

-- DAY 4
-- ADD JOIN TABLE FOR VISITS

-- Create a table named vets with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
-- age: integer
-- date_of_graduation: date
CREATE TABLE vets (
  id integer GENERATED ALWAYS AS IDENTITY,
  name varchar,
  age integer,
  date_of_graduation date,
  PRIMARY KEY(id)
);

-- There is a many-to-many relationship between the tables species and vets: a vet can specialize in multiple species, and a species can have multiple vets specialized in it. Create a "join table" called specializations to handle this relationship.
CREATE TABLE specializations (
  species_id integer,
  vets_id integer,
  PRIMARY KEY(species_id, vets_id)
);
ALTER TABLE specializations
ADD CONSTRAINT FK_species
FOREIGN KEY (species_id)
REFERENCES species(id);
ALTER TABLE specializations
ADD CONSTRAINT FK_vets
FOREIGN KEY (vets_id)
REFERENCES vets(id);

-- There is a many-to-many relationship between the tables animals and vets: an animal can visit multiple vets and one vet can be visited by multiple animals. Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit.
CREATE TABLE visits (
  animals_id integer,
  vets_id integer,
  visit_date date,
  PRIMARY KEY(animals_id, vets_id, visit_date)
);
ALTER TABLE visits
ADD CONSTRAINT FK_animals
FOREIGN KEY (animals_id)
REFERENCES animals(id);
ALTER TABLE visits
ADD CONSTRAINT FK_vets
FOREIGN KEY (vets_id)
REFERENCES vets(id);
