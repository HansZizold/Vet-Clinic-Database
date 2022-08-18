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
