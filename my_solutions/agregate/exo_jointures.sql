 USE pubs;
 --1 Afficher chaque nom d'éditeur avec tous ses employés (nom, prénom et la description de la job)
 SELECT pub_name AS "editeur ", lname AS "nom", fname AS "prenom", job_desc AS "titre"
 FROM employee 
 INNER JOIN publishers ON employee.pub_id = publishers.pub_id
 INNER JOIN jobs ON  employee.job_id = jobs.job_id
 ORDER BY pub_name, lname;
--2  Afficher chaque titre de livre avec le(les) noms du magasin ou il a été vendu, la ville et l'état.
SELECT title AS "titre", stor_name AS "magasin", city AS "ville", state AS "etat" 
FROM sales 
INNER JOIN titles ON sales.title_id = titles.title_id
INNER JOIN stores ON sales.stor_id = stores.stor_id
ORDER BY title;
--3 Afficher la liste des auteurs (prénom et nom concaténés) avec la liste de leurs titres, triée d’après le nom et le prénom.
SELECT CONCAT(au_fname, " ", au_lname) as Auteur , title as Titre 
FROM titleauthor 
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN authors ON titleauthor.au_id = authors.au_id
ORDER BY Auteur;
--4 Afficher le nom et le prénom des auteurs ayant écrit au moins un livre avec le nombre de livres qu’il a écrit.
SELECT au_fname, au_lname  , COUNT(title_id) AS nombre
FROM titleauthor 
INNER JOIN authors ON titleauthor.au_id = authors.au_id
GROUP BY au_fname, au_lname 
HAVING COUNT(title_id)>=1
ORDER BY au_lname;
--5 Afficher chaque titre de livre(TITRE) avec  son nom d'éditeur (EDITEUR) et son nom d'auteur concaténé avec l'initiale de son prénom ordonnés d'après le titre (astuce utilisez la fonction LEFT())
SELECT title as titre,pub_name as "editeur" ,CONCAT(au_fname, " ", LEFT(au_lname,1), ".") as Auteur 
FROM titleauthor 
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN authors ON titleauthor.au_id = authors.au_id
INNER JOIN publishers ON publishers.pub_id = titles.pub_id
ORDER BY titre;

--6 Afficher chaque magasin de l'état de Washington (nom du magasin, ville état), avec les titres de livres vendus dans ce magasin et les quantités vendues. Trier les résultats par livres vendus puis par titre.
SELECT stor_name AS "Nom du magasin ", city AS "Ville", state , title AS titre, qty as " Livres vendus"
FROM sales 
INNER JOIN titles ON sales.title_id = titles.title_id 
INNER JOIN stores ON sales.stor_id = stores.stor_id
WHERE state="WA"
ORDER BY qty, titre;
--7 Afficher les noms d'éditeurs et les numéros des livres dont l’avance versée a été supérieure à 1000$.
 SELECT pub_name AS "editeur ", title_id
 FROM publishers 
 INNER JOIN titles ON publishers.pub_id = titles.pub_id
 WHERE advance>1000
 ORDER BY pub_name;

--8 Afficher les noms d'éditeurs qui publient des livres dans les catégories "business" ou "psychology".
SELECT DISTINCT pub_name AS "editeur ", type
 FROM publishers 
 INNER JOIN titles ON publishers.pub_id = titles.pub_id
 WHERE type IN ("psychology", "business")
 ORDER BY pub_name, type;
 --9 Afficher les titres des livres qui ont été écrits  par l'auteur Albert Ringer.
SELECT  title as titre, au_fname, au_lname  
FROM titleauthor 
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN authors ON titleauthor.au_id = authors.au_id
WHERE au_fname="Albert" AND au_lname="Ringer" 
ORDER BY titre;
--10 Afficher le nom de chaque éditeur avec le nombre de ses employés.
 SELECT pub_name , COUNT(emp_id)
 FROM employee 
 INNER JOIN publishers ON employee.pub_id = publishers.pub_id
GROUP BY( pub_name)
 ORDER BY pub_name;
 --11 Afficher le nom de chaque éditeur avec le nombre de livres qu'il a publié, son prix minimum, son prix maximum, la somme et la moyenne de ses prix.
SELECT pub_name AS "Nom de l'editeur", count(title_id) as "livres P.", MIN(price) AS "Prix minimum" , MAX(price) AS "Prix maximum", SUM(price) AS somme, AVG(price) AS moyenne
FROM publishers 
INNER JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY( pub_name)
ORDER BY pub_name;
--12 Afficher le nom de chaque magasin avec le nombre de titres vendus dans ce magasin.
SELECT stor_name , COUNT(title_id) as "Nombre de titres vendus"
FROM sales  
INNER JOIN stores ON sales.stor_id = stores.stor_id
GROUP BY stor_name
ORDER BY stor_name;
--13 Donnez la liste des livres dont on a vendu moins de 25 exemplaires.
SELECT title , SUM(qty) as "quantite"
FROM sales  
INNER JOIN titles ON sales.title_id = titles.title_id
GROUP BY title
HAVING SUM(qty)<25
ORDER BY title;
--14 La plus grande avance accordée pour chaque éditeur.
SELECT pub_name AS "editeur",  MAX(advance) AS "Plus grande avance"
FROM publishers 
INNER JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY( pub_name)
ORDER BY pub_name;
--15 Auteurs qui n'ont pas écrit de livre
SELECT DISTINCT CONCAT(au_lname, " ", au_fname) as Auteur
FROM titleauthor 
RIGHT JOIN authors ON titleauthor.au_id = authors.au_id
WHERE  ISNULL(title_id);

--16 Le nombre de livres vendus pour chaque titre.
SELECT title as Titre, SUM(qty) as "Nombre de livres vendus"
FROM sales  
RIGHT JOIN titles ON sales.title_id = titles.title_id
GROUP BY title
ORDER BY title;

--17 Le nombre de livres vendus pour chaque magasin.
SELECT stor_name AS "Magasin ",   SUM(qty) as " Nombre de livres vendus"
FROM sales 
INNER JOIN titles ON sales.title_id = titles.title_id 
INNER JOIN stores ON sales.stor_id = stores.stor_id
GROUP BY stor_name;