-- 4.1
/**********************************************/
/****************    CREATION DB  *************/
/**********************************************/  
DROP DATABASE IF EXISTS Ecole;
CREATE DATABASE Ecole;
USE Ecole;
/**********************************************/
/**********       TABLE CREATION       ********/
/**********************************************/
CREATE TABLE eleves (
  id_eleve int  PRIMARY KEY  AUTO_INCREMENT ,
  nom varchar(30)  NOT NULL,
  prenom varchar(30) NOT NULL,
  age INT ,
  tel CHAR(13) ,
  CONSTRAINT CHK_age  CHECK(age > 18),  
  CONSTRAINT CHK_tel  CHECK(tel RLIKE '\\([0-9]{3}\\)[0-9]{3}-[0-9]{4}')
);

CREATE TABLE cours (
    id_cours int  PRIMARY KEY AUTO_INCREMENT,
    intitule  varchar(50) ,
    nb_heures int 
);

CREATE TABLE notes (
    id_cours int  ,
    id_eleve int  ,
    note float ,
    CONSTRAINT PK_notes PRIMARY KEY(id_cours, id_eleve),
    CONSTRAINT CHK_note  CHECK(note >=0  AND note <=100)
);

--4.2
/**********************************************/
/**********      INSERTION DES DONNEES ********/
/**********************************************/
INSERT INTO eleves(nom, prenom, age) VALUES ('Salard', 'Jean', 24);
INSERT INTO eleves(nom, prenom, age) VALUES ('Le Bert', 'Antoine', 24);
INSERT INTO eleves(nom, prenom, age) VALUES ('Legendre', 'Pierre', 24);
INSERT INTO eleves(nom, prenom, age) VALUES ('Turcotte', 'Cedric', 24);
INSERT INTO eleves(nom, prenom, age) VALUES ('Tremblay', 'Alfredo', 24);
INSERT INTO eleves(nom, prenom, age) VALUES ('Dominguez', 'Silvia', 24);
INSERT INTO eleves(nom, prenom, age) VALUES ('Wright', 'Michelle', 24);
INSERT INTO eleves(nom, prenom, age) VALUES ('Sullivan', 'Anne', 24);
INSERT INTO eleves(nom, prenom, age) VALUES ('Petit-Clair', 'Cyril', 24);
INSERT INTO eleves(nom, prenom, age) VALUES ('Herbert', 'Jean-Marc', 24);

INSERT INTO cours(intitule, nb_heures) VALUES ('P41', 45);
INSERT INTO cours(intitule, nb_heures) VALUES ('P42', 60);
INSERT INTO cours(intitule, nb_heures) VALUES ('P60', 60);
INSERT INTO cours(intitule, nb_heures) VALUES ('P61', 60);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (1, 1, 78);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (4, 1, 85);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (4, 2, 80);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (1, 2, 90);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (3, 1, 84);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (2, 10, 96);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (3, 2, 61);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (4, 9, 89);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (4, 10, 73);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (1, 3, 45);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (4, 5, 80);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (4, 6, 33);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (1, 4, 67);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (2, 3, 84);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (1, 5, 35);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (2, 5, 85);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (2, 7, 80);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (3, 3, 67);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (3, 6, 77);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (3, 7, 80);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (3, 4, 33);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (1, 6, 56);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (1, 7, 87);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (3, 9, 89);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (3, 10, 73);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (2, 1, 89);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (2, 9, 18);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (2, 2, 50);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (3, 5, 79);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (3, 8, 37);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (4, 3, 67);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (4, 4, 77);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (2, 8, 75);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (4, 7, 56);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (4, 8, 87);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (1, 8, 38);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (2, 6, 92);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (1, 9, 79);
INSERT INTO notes(id_cours, id_eleve, note) VALUES (1, 10, 97);



--4.3 LISTE DES ELEVES AUXQUELLES IL MANQUE DES NOTES
SELECT * 
FROM eleves 
WHERE id_eleve IN(
SELECT id_eleve FROM notes
group by id_eleve
HAVING  count(id_cours) <4
)
;
--4.4 
SELECT * 
FROM cours 
WHERE id_cours NOT IN(
    SELECT id_cours FROM notes
    WHERE id_eleve = 4
);

--4.5
INSERT INTO notes(id_cours, id_eleve, note) VALUES (2, 4, 82);

--4.6 Moyenne generale de chaque eleve pour tous les cours

SELECT CONCAT(nom, " ", prenom) AS Eleve, AVG(note) AS Moyenne
FROM eleves INNER JOIN notes ON eleves.id_eleve = notes.id_eleve
GROUP BY(CONCAT(nom, " ", prenom));

--4.7 Eleve ayant une nte au dessus de la moyenne en P42.
SELECT CONCAT(nom, " ", prenom) AS Eleve , note 
FROM eleves INNER JOIN notes ON eleves.id_eleve = notes.id_eleve
            INNER JOIN cours ON cours.id_cours = notes.id_cours
WHERE intitule="P42"
GROUP BY(CONCAT(nom, " ", prenom))
HAVING note >= (SELECT AVG(note) FROM notes INNER JOIN cours ON cours.id_cours = notes.id_cours WHERE intitule="P42");

--4.8 Notes de chaque eleve a chacun des 4 cours et leur moyenne
SELECT CONCAT(nom, " ", prenom) AS Eleve, 
(SELECT note FROM notes INNER JOIN cours ON cours.id_cours = notes.id_cours WHERE notes.id_eleve = e.id_eleve AND intitule="P41" )  AS P41,
(SELECT note FROM notes INNER JOIN cours ON cours.id_cours = notes.id_cours WHERE notes.id_eleve = e.id_eleve AND intitule="P42" )  AS P42,
(SELECT note FROM notes INNER JOIN cours ON cours.id_cours = notes.id_cours WHERE notes.id_eleve = e.id_eleve AND intitule="P60" )  AS P60,
(SELECT note FROM notes INNER JOIN cours ON cours.id_cours = notes.id_cours WHERE notes.id_eleve = e.id_eleve AND intitule="P61" )  AS P61,
(SELECT AVG(note) FROM notes WHERE notes.id_eleve = e.id_eleve) AS Moyenne

FROM eleves e
ORDER BY nom,prenom;