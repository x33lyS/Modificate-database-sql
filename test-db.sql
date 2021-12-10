INSERT INTO game (name)
VALUES ('Game1'),
       ('Game2'),
       ('Game3');

INSERT INTO tournament (IdGame,date,duration,"placeName",address,city)
VALUES (1,'1 janvier',20,'Paris','1 rue de paris','PRS'),
       (2,'2 fevrier',25,'Toulouse','2 rue de toulouse','TLS'),
       (3,'3 mars',30,'Bordeaux','3 rue de Bordeaux','BRD');

INSERT INTO Staff (LastName,Firstname,Gender,Age,Wage)
VALUES ('Lejosne','Florian','M',19,1000),
       ('Haouzi','Adam','M',19,1000);

INSERT INTO player (LastName,Firstname,Gender,Age,Wage,ranking)
VALUES ('Mathis','Titouan','M',19,5000,1);

INSERT INTO coach (LastName,Firstname,Gender,Age,Wage,"licenseDate")
VALUES ('Roques','Antoine','M',29,10000,'1 decembre');