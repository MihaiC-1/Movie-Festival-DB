create database Festival_Filme;

use Festival_Filme;

-- drop database Festival_Filme;

create table Sponsori
(
    cod_sponsor int primary key IDENTITY,
    nume varchar(50),
    suma_investita FLOAT
)

-- 1 to many

create table Ecrane
(
    cod_ecran int PRIMARY KEY IDENTITY,
    nume_ecran VARCHAR(30),
    cod_sponsor int UNIQUE FOREIGN KEY REFERENCES Sponsori(cod_sponsor)
)

-- many to many

create table Filme 
(
    cod_film int PRIMARY KEY IDENTITY,
    nume VARCHAR(40),
    durata FLOAT,
    categorie VARCHAR(30)
)

create table EcranFilm
(
    cod_ecran int FOREIGN KEY REFERENCES Ecrane(cod_ecran), 
    cod_film int FOREIGN KEY REFERENCES Filme(cod_film),
    ora_incepere TIME,
    restrictii_varsta int,
    CONSTRAINT pk_filmecran PRIMARY KEY (cod_ecran, cod_film)
)

create table Corturi
(
    cod_cort int PRIMARY KEY IDENTITY,
    nume VARCHAR(30),
    ora_deschidere TIME,
    ora_inchidere TIME
)

-- many to many

create table Produse
(
    cod_produs int PRIMARY KEY IDENTITY,
    nume VARCHAR(30),
    pret float,
    alcool varchar(10),
    calorii FLOAT
)

create table DistribuiriProduse
(
    cod_produs int FOREIGN KEY REFERENCES Produse(cod_produs), 
    cod_cort int FOREIGN KEY REFERENCES Corturi(cod_cort),
    cantitate int,
    tip_cantitate varchar(20),
    CONSTRAINT pk_distribuire PRIMARY KEY (cod_produs, cod_cort)
)

-- Inserare valori Sponsori

insert into Sponsori(nume, suma_investita)
values ('Vodafone', 1575.5), ('Google', 4000.75), ('Ursus', 3700.0);

insert into Sponsori(nume, suma_investita)
values ('Kaufland', 3000), ('Lidl', 5800), ('Orange', NULL);

insert into Sponsori(nume, suma_investita)
values ('Dedeman', 1200), ('Ursa Alin SRL', 500), ('Albalact', 1350)

-- Inserare valori Ecrane

insert into Ecrane(nume_ecran, cod_sponsor)
values ('Ecran 1 by Ursus', 3), ('Ecran 2 by Vodafone', 1), ('Ecran principal by Google', 2);

insert into Ecrane(nume_ecran, cod_sponsor)
values ('Ecran 3 by Lidl', 5), ('Ecran 2 by Kaufland', 4);

-- Inserare valori Filme

insert into Filme(nume, durata, categorie)
values ('Love & Monsters', 2.09, 'Actiune, SF, Comedie'), ('Plam Springs', 1.50, 'SF, Comedie, Drama'), ('BloodShot', 2.05, 'SF,Actiune'),
('Alone(Pandemic)', 1.47, 'Groaza, Thriller'), ('The Maze Runner', 1.53, 'Actiune, Mister, SF');

-- Inserare valori EcranFilme

insert into EcranFilm(cod_ecran, cod_film, ora_incepere, restrictii_varsta)
values (1, 2, '19:00:00', 16), (3, 3, '18:00:00', 16), (3, 4, '20:30:00', 18), (2, 5, '19:30:00', 18), (3, 1, '22:30:15', 18);

-- Inserare valori Corturi

insert into Corturi(nume, ora_deschidere, ora_inchidere)
values ('Day Dream', '14:00:00', '00:00:00'), ('Shots by Tatratea', '12:00:00', '22:00:00'), ('Bar & Grill', '13:00:00', '21:00:00'),
('Mexican Go', '16:00:00', '1:30:00');

insert into Corturi(nume, ora_deschidere, ora_inchidere)
values ('Drink Time', '12:00:00', '00:00:00');

-- Inserare valori Produse

insert into Produse (nume, pret, alcool, calorii)
values ('CocaCola', 7.5, '0%', 364), ('CocaCola Lime', 7.5, '0%', 365), ('Dorna apa plata', 5.0, '0%', NULL), 
('Dorna apa minerala', 5.0, '0%', NULL), ('Ursus Premium', 9.0, '4.5%', 264), ('Ursus Panda', 9.0, '4.5%', 264), 
('Ursus Grizlly', 9.0, '5.0%', 264), ('Tatratea black', 13.0, '62%', 25.5), ('Tatratea white', 10.0, '22%', 25.5),
('Popcorn caramel', 5.0, '0%', 100), ('Nachos 2 sosuri', 13.5, '0%', 254), ('Burger pulled pork', 23.0, '0%', 346);

-- Inserare valori DistribuiriProduse

insert into DistribuiriProduse(cod_produs, cod_cort, cantitate, tip_cantitate)
values (1, 1, 70, 'bucati'), (1, 3, 60, 'bucati'), (1, 4, 60, 'bucati'), (1, 5, 40, 'bucati'), (2, 1, 50, 'bucati'), (2, 3, 50, 'bucati'),
(3, 1, 100, 'bucati'), (3, 3, 90, 'bucati'), (3, 4, 70, 'bucati'), (3, 5, 70, 'bucati'), (8, 2, 40, 'bucati'), (9, 2, 60, 'bucati'),
(11, 4, 100, 'portii'), (10, 4, 160, 'portii'), (5, 3, 67, 'bucati'), (6, 3, 70, 'bucati'), (7, 3, 40, 'bucati'), (12, 3, 100, 'portii'),
(5, 5, 240, 'bucati'), (6, 5, 125, 'bucati'), (7, 5, 100, 'bucati');

-- Modificare pret CocaCola la 6 lei

select nume, pret
from Produse
where nume like 'Coca%';

update Produse
set pret = 6.0
where nume like 'CocaCola%';

-- Modifica cantitatea unui produs cu +5 la corturile ce au deschis intre 12:00 si 14:00

select D.cod_cort, D.cantitate from DistribuiriProduse as D inner join Corturi as C 
on D.cod_cort = C.cod_cort where C.ora_deschidere between '12:00:00' and '13:59:59';

update DistribuiriProduse
set cantitate = cantitate + 5 
from DistribuiriProduse as D inner join Corturi as C on D.cod_cort = C.cod_cort
where C.ora_deschidere Between '12:00:00' and '13:59:59';

-- Modifficarea alcoolemiei produselor, ce au sub 100 calorii si pretul mai mic de 10 lei, din '0%' in NULL

select nume, pret, alcool, calorii from Produse;

update Produse
set alcool = NULL 
where calorii <= 100 and pret < 10;

-- Stergerea sponsorilor unde suma investita este NULL

select * from Sponsori;

delete from Sponsori
where suma_investita is NULL;

-- Stergerea filmelor ce au restrictia de varsta sub 18

select F.nume, E.restrictii_varsta from Filme as F 
inner join EcranFilm as E on F.cod_film = E.cod_film;

update Filme
set durata = NULL from Filme as F inner join EcranFilm as E on F.cod_film = E.cod_film
where E.restrictii_varsta < 18;

delete from EcranFilm
where restrictii_varsta < 18;

delete from Filme 
where durata is NULL;

-- Afisarea tuturor tabelelor cu toate datele existente

select * from Sponsori;
select * from Ecrane;
select * from Filme;
select * from EcranFilm;
select * from Corturi;
select * from Produse;
select * from DistribuiriProduse;