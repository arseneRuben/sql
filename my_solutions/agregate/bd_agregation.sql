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
SELECT region ,  FORMAT(SUM(population),2)   AS "Population" , FORMAT(SUM(superficie),2)  AS "Superficie" ,  SUM(pib) AS "PIB"
 FROM pays 
 GROUP BY region  
 ORDER BY SUM(population) DESC;
--13 Liste des régions avec une population totale  supérieure à 400000000.Afficher le nom des régions et leur population respective en millions. Triée en ordre décroissant de population.
SELECT region ,  CONCAT( FORMAT(SUM(population)/1000000,2) , " M")   AS "Population" 
 FROM pays 
 GROUP BY region  
 HAVING  SUM(population)>400000000
 ORDER BY SUM(population) DESC;
 --14 Liste des régions dont la moyenne des populations des pays qui composent chacune d'elle est supérieure à 80000000. Exclure la population de la chine de la moyenne. Trier par population.
 SELECT region ,  CONCAT( FORMAT(AVG(population)/1000000,2) , " M")   AS "Population moyenne" 
 FROM pays 
 WHERE nom!="china"
 GROUP BY region  
 HAVING  AVG(population)>80000000
 ORDER BY AVG(population) DESC;
 --15 Afficher les régions, la moyenne des populations des pays qui composent chacune d'elle en millions. Trier par population en ordre décroissant.
  SELECT region ,  CONCAT( FORMAT(AVG(population)/1000000,2) , " M")   AS "Population moyenne" 
 FROM pays 
 GROUP BY region  
 ORDER BY AVG(population) DESC;
 use pubs;
 --16 A partir de la table titles, afficher le prix moyen par type de livre. 
SELECT type, AVG(price) 'prix moyen' 
FROM titles
GROUP BY type;
--17   En utilisant la table sales, lister chaque titre vendu avec le total d'unités vendues. Appeler la colonne totale "Livres vendus"
SELECT title_id , SUM(qty) AS "Livres vendus"
FROM sales
GROUP BY title_id
HAVING  SUM(qty)>30
 ORDER BY  SUM(qty) DESC;
--18 Dans la table titles, faire un regroupement de façon à afficher seulement les éditeurs dont le numéro d'identification est supérieur à 0800 qui ont verse plus de $15,000 d'avance au total et dont le prix moyen des livres vendus est inférieur à $20.
SELECT pub_id ,SUM(advance) AS "Total des avances", AVG(price) AS "Prix moyen"
FROM titles
WHERE pub_id > "0800"  
GROUP BY pub_id
HAVING  SUM(advance)>15000 AND  AVG(price) < 20
 ORDER BY  SUM(advance) ASC;
