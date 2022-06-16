use pubs;
-- 1 Afficher la liste des livres dont le prix est supérieur à la moyenne des prix. 
SELECT title, price
FROM titles
WHERE price > ( SELECT AVG(price) FROM titles)
Order by price;
-- 2 Afficher la moyenne des prix des livres dont le prix est supérieur à la moyenne des prix de tous les livres.
SELECT AVG(price) AS 'Prix moyen'
FROM titles
WHERE (price) > ( SELECT AVG(price) FROM titles );
--  3 Afficher la liste des types dont au moins un prix des livres qui les composent est supérieur à la moyenne des prix de tous les titres.
SELECT DISTINCT type  AS "Types"
FROM titles
WHERE (price) > ( SELECT AVG(price) FROM titles );

--  4 Afficher la liste des types dont au moins un prix des livres qui les composent est supérieur à la moyenne des prix des livres dont le titre commence par la lettre "o"
SELECT DISTINCT type AS "Types"
FROM titles
WHERE (price) > ( SELECT AVG(price) FROM titles WHERE title like 'o%' );

--  5 Les titres qui n'ont jamais été vendus? (utilisez exists)
SELECT title AS "Titres"
FROM titles titres
WHERE NOT EXISTS (
SELECT title
FROM sales AS s
WHERE s.title_id = titres.title_id)
ORDER BY title ASC;

-- 6 Editeurs dont au moins un livre publié a reçu une avance supérieure à 10000$ 
SELECT pub_name
FROM publishers
WHERE pub_id IN
(
SELECT pub_id
FROM titles
WHERE advance >10000);

--7 Liste des livres vendus et leur quantité pour chaque ville de l'état de Californie et de Washington.
SELECT titles.title_id, title as "Titres", city AS "Villes", state AS "Etats", qty AS "Quantites"
From sales
INNER JOIN titles ON sales.title_id=titles.title_id
INNER JOIN stores ON stores.stor_id=sales.stor_id
WHERE state IN('CA','WA');




-- 9 Liste des éditeurs et leurs employés dont job_lvl est > 200
Select publishers.pub_name as "Editeur", CONCAT(fname , ' ' , lname) AS "Employee Name", job_lvl
FROM Employee
INNER JOIN publishers on employee.pub_id = publishers.pub_id
INNER JOIN jobs on employee.job_id = jobs.job_id
WHERE job_lvl >200
ORDER by pub_name desc, CONCAT(fname , ' ' , lname) ASC, job_lvl;


-- 10 Les livres les plus chers. 
SELECT title AS 'Titre', price
FROM titles
WHERE price=( SELECT MAX(price) FROM titles);

-- 11
SELECT title AS 'Titre', advance
FROM titles
WHERE advance =( SELECT Max(advance) FROM titles);

-- 12 Catégorie d’employés qui a le plus grand nombre d’employés ? Afficher cette catégorie et le nombre d'employés.

SELECT jobs.job_id , count(emp_id) AS "Nombre d'employes"
FROM Employee
INNER JOIN jobs on employee.job_id = jobs.job_id
GROUP BY jobs.job_id;

-- 13 Nombre d'employés embauchés chaque année
SELECT YEAR(hire_date) as "Annee", COUNT(emp_id) AS "Nombre d'employes"
FROM Employee WHERE COUNT(emp_id) =  (SELECT  COUNT(emp_id) FROM Employee
GROUP BY YEAR(hire_date))
GROUP BY YEAR(hire_date);


--14 Plus grand nombre d’employés qui ont été embauchés dans la même année?
SELECT YEAR(hire_date) as "Annee", COUNT(emp_id) AS  employes
FROM Employee
GROUP BY YEAR(hire_date)
HAVING employes >= ALL (SELECT COUNT(emp_id) AS  employes
FROM Employee
GROUP BY YEAR(hire_date));


--  Nombre de livres non vendus
SELECT DISTINCT COUNT(titles.title_id) AS "nombre de Livres non vendus" from titles
LEFT JOIN sales on titles.title_id = sales.title_id
WHERE sales.stor_id IS NULL;






-- Dernier employé recruté
SELECT fname as "Prenom" , lname as "NOM", hire_date as " Date d'embauche"
from employee
Where hire_date = (SELECT max(hire_date) from employee);




