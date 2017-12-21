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

insert into crew_members values (default, 'LUKE', 'SKYWALKER', '1983-05-22'), 
	                            (default, 'ANAKIN', 'SKYWALKER', '1963-07-12'),
	                            (default, 'HAN', 'SOLO', '1977-08-06'),
	                            (default, 'OBI-WAN', 'KENOBI', '1953-10-29');

insert into aircrafts values (default, 'A-wing'),
	                         (default, 'ARC-170'),
	                         (default, 'B-wing'),
	                         (default, 'E-wing'),
	                         (default, 'Hornet Interceptor'),
	                         (default, 'Naboo N-1'),
	                         (default, 'X-wing');
	                         
insert into crew_experience values (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),
	                               (3,1),(3,2),(3,3),(3,4),(3,5),(3,6),
	                               (4,1),(4,2),(4,3),(4,4),
	                               (5,1),(5,2),(5,3),(5,4),(5,5);


#query za ime najstarijeg clana posade
SELECT first_name, last_name FROM crew_members ORDER BY date_of_birth ASC LIMIT 1;

#query za nth crew_member 
SELECT first_name, last_name, date_of_birth FROM crew_members ORDER BY date_of_birth ASC LIMIT 1 OFFSET 2;

#kako je prvi najstariji na poziciji 0, da nam bude lakse mozemo zapisati OFFSET (nth-1) i na mjesto nth zapisemo 
#kojeg po redu najstarijeg clana zelimo 
SELECT first_name, last_name, date_of_birth FROM crew_members ORDER BY date_of_birth ASC LIMIT 1 OFFSET (nth-1);

#query koji nadje najiskusnijeg clana posade, tj. onaj koji poznaje najvise letjelica
SELECT crew_members.id, crew_members.first_name, crew_members.last_name, count(crew_experience.crew_member_id)
AS total_experience
FROM crew_members INNER JOIN crew_experience ON crew_experience.crew_member_id=crew_members.id
GROUP BY crew_members.id ORDER BY total_experience DESC LIMIT 1;


#query koji pronadje najmanje iskusnog clana posade, tj. onog koji poznaje najmanje letjelica
SELECT crew_members.id, crew_members.first_name, crew_members.last_name, count(crew_experience.crew_member_id)
AS total_experience
FROM crew_members INNER JOIN crew_experience on crew_experience.crew_member_id=crew_members.id
GROUP BY crew_members.id ORDER BY total_experience ASC LIMIT 1;