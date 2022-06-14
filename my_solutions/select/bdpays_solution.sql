use bdpays;
-- 1-Quelle est la population du Canada ?
SELECT nom AS "Nom", population FROM pays WHERE nom="Canada";
-- 2 Nom, population, superficie et densité de la population des plus grands pays du monde (dont la superficie dépasse 2000000 km2) la colonne densité aura comme titre ‘Densité de la population’. Afficher la densité sans chiffre après la virgule.
SELECT  nom AS "Nom", population, superficie , FORMAT(population/superficie, 0) AS "Densité de la population" FROM pays WHERE superficie > 2000000;
-- 3
SELECT CONCAT(nom , ' is in ', region) AS "Pays/region" FROM pays   WHERE superficie<2000 AND pib>5000000000;
-- 4 
SELECT nom  AS "Nom" FROM pays WHERE nom in ('Sri Lanka', 'Ceylon', 'Persia', 'Iran');
-- 5 Quels sont les pays dont le nom commence par D?
SELECT nom  AS "Nom" FROM pays WHERE nom RLIKE "^D";
-- 6 Quels sont les pays qui ont une superficie entre 207600 et 244820 km2 inclusivement ?
SELECT nom  AS "Nom", superficie FROM pays WHERE superficie BETWEEN 207600 AND 244820;
-- 7 Les pays qui ont une population d’au moins 200000000 habitants
SELECT nom  AS "Nom" , population FROM pays WHERE population >= 200000000 ;
-- 8 Les pays qui ont une superficie d’au moins 2300000km2. Afficher le résultat en ordre décroissant de superficie
SELECT nom  AS "Nom", superficie AS "Superficie en km2" FROM pays WHERE superficie >= 2300000 ORDER BY superficie DESC ;
-- 9 Le nom et le PIB par habitants des pays dont la population est égale ou supérieure à 200000000. En ordre décroissant de PIB par habitant
SELECT nom  AS "Nom", FORMAT(pib/population,2) AS "Pib/hab en US$" FROM pays WHERE population >= 200000000 ORDER BY pib/population DESC ;
-- 10 Le nom et la population en millions des pays d'Amérique du sud (South America). En ordre décroissant de population.
SELECT nom  AS "Nom" , CONCAT(FORMAT(population/1000000,2)    ,  " M") AS "population en millions" FROM pays WHERE region = "South America" ORDER BY population DESC;
--11 Les populations du Japon, de la Chine, de l'Irak et de l'Iran.
SELECT  nom  AS "Nom", population  AS "Polulation" FROM pays WHERE nom in ('Japan','China', 'Iraq', 'Iran') ORDER BY nom;
--12 Les pays dont le nom contient le mot "united"
SELECT nom  AS "Nom" FROM pays WHERE nom LIKE "%united%" ORDER BY region; 
--13 La population de la France et de l'Allemagne
SELECT nom  AS "Nom", population FROM pays WHERE nom="France" OR nom="Germany";
--14 Tous les pays dont le nom commence par S et se trouvant en Europe.
SELECT nom  AS "Nom" FROM pays WHERE  nom RLIKE "^S" AND  region="Europe";
use pubs;
--15 Donner le nom (au_lname) et le prénom (au_fname) des auteurs (authors) dont le nom est  ‘Smith',  triés en ordre croissant de prénom. L’entête des deux colonnes affichées doivent être Nom et Prénom.
SELECT au_lname AS "Nom", au_fname AS "Prenom" FROM authors WHERE au_lname = "Smith" ORDER BY au_fname;
--16 Lister les états (state) des auteurs. On veut chaque état une seule fois dans la liste
SELECT DISTINCT state FROM authors ORDER BY state;
--17 Donner les noms et prénoms des auteurs ainsi que la ville (city) et l’état (state) des auteurs dont l’état est ‘CA’ et la ville n’est pas 'Oakland' ainsi que tous ceux dont la ville est 'Salt Lake City'
SELECT au_lname , au_fname , city , state  FROM authors WHERE ((state="CA" AND city!= "Oakland") OR  city="Salt Lake City");
--18 Donner le titre (title) des livres (table titles) dont le prix (price) est entre $5.00 et $20.00 inclusivement (en utilisant BETWEEN ou l’opérateur logique AND)
SELECT title, price FROM titles    WHERE price BETWEEN 5.00 AND 20.00 ;
--19 Donner le titre et le prix des livres dont le prix est inconnu
SELECT title, price FROM titles    WHERE price IS NULL ;
--20 Donner le noms et le prénom des auteurs dont le nom se termine par ‘ger’.
SELECT au_lname , au_fname FROM authors    WHERE au_lname RLIKE "ger$" ;
--21 Donner le nom et le prénom des auteurs dont le nom  commence par D ou d.
SELECT au_lname , au_fname FROM authors  WHERE au_lname RLIKE "^D"  OR au_lname RLIKE "^d";
--22 Donner le nom et le prénom des auteurs dont le nom contient une chaîne de cinq caractères qui se termine par ‘mith’. 
SELECT au_lname , au_fname FROM authors    WHERE  au_lname RLIKE "....." AND au_lname RLIKE "mith$" ;
--23 Donner le nom et le prénom des auteurs en une seule colonne qui sera nommée "Nom et prénom d'auteur" ainsi que les états, par ordre croissant des états. 
SELECT au_lname , au_fname AS "Nom et prenom d'auteur", state FROM authors ORDER BY state ASC;

--Creer une vue affichant les magasins ayant vendu plus de 80 livres
CREATE VIEW best_sales AS SELECT  stor_name as magasin, title as titre
FROM stores INNER JOIN sales ON sales.stor_id = stores.stor_id
			 INNER JOIN titles ON sales.title_id = titles.title_id
GROUP BY sales.stor_id
HAVING COUNT(sales.title_id)>80;