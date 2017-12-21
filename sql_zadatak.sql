create database air_company;

create table crew_members (
    id SERIAL UNIQUE PRIMARY KEY NOT NULL,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    date_of_birth date NOT NULL
);

create table aircrafts (
    id SERIAL UNIQUE PRIMARY KEY NOT NULL,
    name varchar(255) NOT NULL
);

create table crew_experience (
    crew_member_id SERIAL NOT NULL REFERENCES crew_members(id),
    aircraft_id SERIAL NOT NULL REFERENCES aircrafts(id),
    PRIMARY KEY(crew_member_id, aircraft_id)
);