CREATE TABLE animals (
  id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
  name TEXT,
  date_of_birth date,
  escape_attempts integer,
  neutered boolean,
  weigth_kg decimal,
  PRIMARY KEY(id)
);