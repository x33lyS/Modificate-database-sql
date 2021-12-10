-- Game Table
ALTER table Game
    RENAME COLUMN Name To ExName;
ALTER table Game
    ADD Name VARCHAR2(30);
UPDATE Game SET Name = ExName;
ALTER TABLE game
DROP "ExName";

--Place Table
CREATE TABLE Place
(
    idPlace integer  not null
        primary key autoincrement,
    Name         VARCHAR2(30),
    Address      VARCHAR2(30),
    City         VARCHAR2(30)
);
INSERT INTO Place (Name, Address, City)
SELECT placeName, address, City FROM tournament;

--Employee-Data
CREATE TABLE Employee_Data
( idEmployee integer  not null
      primary key autoincrement,
  Lastname VARCHAR2(30) ,
  FirstName VARCHAR2(30),
  Gender VARCHAR2(30),
  Age INTEGER,
  Wage INTEGER
);

INSERT INTO Employee_Data
(Lastname,
 Firstname,
 Gender,
 Age,
 Wage)
SELECT
    Lastname,
    Firstname,
    Gender,
    Age,
    Wage
FROM
    Staff
UNION ALL
SELECT
    Lastname,
    Firstname,
    Gender,
    Age,
    Wage
FROM
    PLayer
UNION ALL
SELECT
    Lastname,
    Firstname,
    Gender,
    Age,
    Wage
FROM
    Coach
;


--Staff Table
create table newstaff
(
    idStaff   integer  not null
        primary key autoincrement,
    lastname  text(30) not null,
    firstname text(30) not null,
    gender    text(30) not null,
    age       integer  not null,
    wage      integer  not NULL,
    idEmployee INTEGER not null
);
INSERT INTO newstaff("idEmployee",lastname,firstname,gender,age,wage)
SELECT  Employee_Data.IdEmployee, Employee_Data.Lastname , Employee_Data.FirstName , Employee_Data.Gender , Employee_Data.Age ,Employee_Data.wage
FROM Employee_Data
         INNER JOIN staff ON Employee_Data.Lastname = staff.lastname;
DROP TABLE staff;
ALTER TABLE newstaff
    RENAME TO staff;
ALTER TABLE staff
DROP lastname;
ALTER TABLE staff
DROP age;
ALTER TABLE staff
DROP wage;
ALTER TABLE staff
DROP gender;
ALTER TABLE staff
DROP firstname;

-- Player Table
create table newplayer
(
    idPlayer   integer  not null
        primary key autoincrement,
    lastname  VARCHAR2(30) not null,
    firstname VARCHAR2(30) not null,
    gender    VARCVARCHAR2(30) not null,
    age       integer  not null,
    wage      integer  not NULL,
    IdGame      integer
        constraint FK_9d24c46ddfcc57ed29c453c2b50
            references game,
    ranking   INTEGER NOT NULL,
    idEmployee INTEGER not null
);
INSERT INTO newplayer("idEmployee",lastname,firstname,gender,age,wage,ranking)
SELECT  Employee_Data.IdEmployee, Employee_Data.Lastname , Employee_Data.FirstName , Employee_Data.Gender , Employee_Data.Age ,Employee_Data.wage,player.ranking
FROM Employee_Data
         INNER JOIN player ON Employee_Data.Lastname = player.lastname;
DROP TABLE player;
ALTER TABLE newplayer
    RENAME TO player;
ALTER TABLE player
DROP lastname;
ALTER TABLE player
DROP age;
ALTER TABLE player
DROP wage;
ALTER TABLE player
DROP gender;
ALTER TABLE player
DROP firstname;

-- Coach Table
create table newcoach
(
    idCoach   integer  not null
        primary key autoincrement,
    lastname  VARCHAR2(30) not null,
    firstname VARCHAR2(30) not null,
    gender    VARCHAR2(30) not null,
    age       integer  not null,
    wage      integer  not NULL,
    IdGame      integer
        constraint FK_8ce1eeb16389d742df20c458324
            references game,
    licenseDate   VARCHAR2(30) NOT NULL,
    idEmployee INTEGER not null
);
INSERT INTO newcoach("idEmployee",lastname,firstname,gender,age,wage,licenseDate)
SELECT  Employee_Data.IdEmployee, Employee_Data.Lastname , Employee_Data.FirstName , Employee_Data.Gender , Employee_Data.Age ,Employee_Data.wage, coach.licenseDate
FROM Employee_Data
         INNER JOIN coach ON Employee_Data.Lastname = coach.lastname;
DROP TABLE coach;
ALTER TABLE newcoach
    RENAME TO coach;
ALTER TABLE coach
DROP lastname;
ALTER TABLE coach
DROP age;
ALTER TABLE coach
DROP wage;
ALTER TABLE coach
DROP gender;
ALTER TABLE coach
DROP firstname;

--Tournament Table
create table newtournament
(
    idTournament   integer  not null
        primary key autoincrement,
    IdPlace INTEGER NOT NULL,
    IdGame      integer
        constraint FK_a7cdb11d62c6d19742ad1a8657c
            references game,
    Date VARCHAR2(30) NOT NULL,
    Duration INTEGER,
    PlaceName VARCHAR2(30),
    Address VARCHAR2(30),
    City VARCHAR2(30)

);
INSERT INTO newtournament(idPlace,Date,Duration,PlaceName,Address,City)
SELECT  Place.idPlace, tournament.date, tournament.duration, tournament.placeName, tournament.address, tournament.city
FROM tournament
         INNER JOIN place ON tournament.placeName = place.name;
DROP TABLE tournament;
ALTER TABLE newtournament
    RENAME TO tournament;
ALTER TABLE tournament
DROP city;
ALTER TABLE tournament
DROP address;
ALTER TABLE tournament
DROP placeName;