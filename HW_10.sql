
CREATE DATABASE hw_10
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;


drop table if exists Adress cascade;
drop table if exists Location cascade;
drop table if exists Usser cascade;
drop table if exists Usser cascade;
drop table if exists Adress_User_Relation cascade;

CREATE TABLE if not exists Adress(
                                     id serial NOT NULL,
                                     Street varchar(255),
    Country varchar(255),
    City varchar(255),
    zip_code int,
    PRIMARY KEY(id)
    );

CREATE TABLE IF NOT EXISTS Location(
                                       id serial NOT NULL,
                                       Name varchar(255),
    Score int,
    adress_id int references Adress(id) ON DELETE CASCADE,
    CONSTRAINT adrs_id UNIQUE (adress_id),
    PRIMARY KEY(id)
    );

CREATE TABLE if not exists Usser (
                                     id serial  PRIMARY KEY NOT NULL,
                                     First_Name varchar(255) NOT NULL,
    Last_Name varchar(255) NOT NULL,
    Age int
    );

Create table if not exists Adress_User_Relation(
                                                   adress_id int not null,
                                                   user_id int not null,
                                                   foreign key (adress_id) references Adress(id),
    foreign key (user_id) references Usser(id),
    UNIQUE (adress_id, user_id )
    );

delete  from Adress;
delete  from Location;
delete  from Usser;
delete  from Adress_User_Relation;

INSERT INTO Adress(Street, Country, City, zip_code) values('Zernova', 'Ukraine', 'Zaporozhzhye', 69121),
                                                          ('Voronina', 'Ukraine', 'Zaporozhzhye',483484),
                                                          ('Lermontova', 'Ukraine', 'Zaporozhzhye',49494),
                                                          ('Zhukova', 'Ukraine', 'Zaporozhzhye',4949433);

INSERT INTO Location(Name, Score, adress_id) values('East Europe', 229, 1),
                                                   ('West Europe', 46969, 4),
                                                   ('South Europe', 35696, 3),
                                                   ('North Europe', 259, 2);

INSERT INTO Usser(First_Name, Last_Name, Age) values('Vlad', 'Googlya', 19),
                                                    ('John', 'Smith', 45),
                                                    ('Henry', 'Cavill', 36),
                                                    ('Zack', 'Snyder', 49),
                                                    ('Jensen', 'Eckles', 40),
                                                    ('John', 'Cena', 55);

INSERT INTO Adress_User_Relation values(1,1),(1,2),(1,3),(1,4),(3,3),(4,2),(4,6);



select Usser.First_Name, Usser.Last_Name,Usser.Age, Adress.Street, Adress.Country, Adress.City, Adress.zip_code
from  Usser join Adress_User_Relation on Usser.id = Adress_User_Relation.user_id
            join  Adress  on Adress_User_Relation.adress_id = Adress.id;