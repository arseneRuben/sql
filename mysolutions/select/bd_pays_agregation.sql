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
SELECT region, COUNT(id) FROM pays GROUP BY region;
--8 Indiquer le nombre de pays dont la population dépasse 50000000 dans chacune des régions
SELECT region, COUNT(id) as "Nombre de pays" FROM pays  WHERE population>50000000 GROUP BY region ORDER BY  COUNT(id) DESC ;
--9 Afficher les populations de chacune des régions en millions avec deux chiffres après la virgule.
SELECT region, FORMAT(SUM(population)/1000000,2) AS "Population"  FROM pays GROUP BY region ORDER BY SUM(population) DESC ;
--10 Afficher en millions la population totale et le PIB total de l'Europe.
SELECT CONCAT( FORMAT(SUM(population)/1000000,2) , " M") AS "Population Totale" ,  FORMAT(CONCAT(SUM(pib)/1000000,0), " M") AS "PIB total " FROM pays WHERE region="Europe";
--11 Afficher en millions la population totale, le PIB total par région et le nom de la région
SELECT region, CONCAT( FORMAT(SUM(population)/1000000,2) , " M") AS "Population Totale" ,  FORMAT(SUM(pib)/1000000,2) AS "PIB total " FROM pays GROUP BY region ORDER BY SUM(pib) DESC;
--12 Afficher les régions avec leur population totale, leur superficie et leur produit intérieur brut.
SELECT region ,  FORMAT(SUM(population),2)   AS "Population" , FORMAT(SUM(superficie),2)  AS "Superficie" ,  SUM(pib) AS "PIB" FROM pays GROUP BY region  ORDER BY SUM(population) DESC;