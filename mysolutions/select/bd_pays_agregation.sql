use bdPays;
--1 Quelle est la population mondiale, c.à.d. la somme de la population de tous les pays ? Donner un titre à la colonne.
SELECT SUM(population) AS "population du monde" from pays;
--2 Quelle est la population du pays le plus peuplé, et son pourcentage par rapport à la population mondiale total. N'indiquer pas le pays.
SELECT MAX(population) AS "Plus grande population", CONCAT(FORMAT( 100*MAX(population)/SUM(population),2), " %") as "Pourcentage" FROM pays ;
--3 Quelle est la plus petite population, pour les pays ayant une population supérieure à 50. Afficher aussi son pourcentage par rapport à la population totale du monde. N'indiquer pas le pays
SELECT MIN(population) AS "Plus petite population", CONCAT(FORMAT( 100*MIN(population)/SUM(population),2), " %") as "Pourcentage" 
 FROM pays
 WHERE population >50 ;
--4 Afficher toutes les régions du monde, chaque région une seule fois
SELECT DISTINCT region FROM pays ;
--5 Combien de régions dans le monde y a-t-il? Donner un nom à la colonne.
SELECT  COUNT(DISTINCT region) AS "nombre de regions " FROM pays ;
--6 Quelle est la moyenne de la population des pays d'Europe?
SELECT CONCAT(AVG(population)/1000000, " Millions") AS "moyenne de la population" FROM pays WHERE region = "Europe";
--7 Indiquer le nombre de pays dans chacune des régions.
