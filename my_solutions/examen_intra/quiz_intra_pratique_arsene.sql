use pubs;
--1 La liste de tous les livres
SELECT title AS Titre , type, advance 
FROM titles 
ORDER BY title;
--2 Le nombre de livre contenus dans la bd
SELECT COUNT(*) AS "Nombre de livres" 
FROM titles;
--3 Le nombre d'editeur pour chaque pays
SELECT country as "Pays", COUNT(pub_id) AS "Nombre d'editeur" 
FROM publishers 
GROUP BY (country);
--4 livres dont le titre est en forme de question
SELECT title_id as Identifiant , title as Titre
FROM titles 
WHERE title LIKE "%?";
--5 Prenom et nom des auteurs , et leur adresse , pour leur auteurs de l'etait de la CA seulement
SELECT au_fname, au_lname , address 
FROM authors 
WHERE state="CA"
ORDER BY au_lname;
--6 Nombre d'employes travaillant pour chaque editeur
SELECT pub_name AS "Editeur", COUNT(emp_id) AS "Nombre d'employes"
FROM employee INNER JOIN publishers ON employee.pub_id = publishers.pub_id
GROUP BY pub_name
ORDER BY COUNT(emp_id) DESC ,pub_name DESC;
--7 Liste des employes dont le niveau de poste est compris entre 100 et 150
SELECT CONCAT(lname, " ", LEFT(fname,1), ".") as Employe  , job_lvl AS "Niveau", YEAR(hire_date) AS "date d'embauche"
FROM employee 
WHERE job_lvl BETWEEN 100 AND 150
ORDER BY job_lvl DESC, Employe  ASC;
--8 Nombre d'employes par niveau de poste  pour  les niveaux de poste  compris entre 100 et 150
SELECT job_lvl AS "Niveau" , COUNT(emp_id) AS "Nombre d'employes" 
FROM employee
WHERE job_lvl BETWEEN 100 AND 150
GROUP BY job_lvl
ORDER BY job_lvl DESC;
--9 lISTE DES EDITEURS COMTANT  plus de 5 employes
SELECT pub_name AS "Editeur", COUNT(emp_id) AS "Nombre d'employes"
FROM employee INNER JOIN publishers ON employee.pub_id = publishers.pub_id
GROUP BY pub_name
HAVING  COUNT(emp_id)>5
ORDER BY COUNT(emp_id) DESC ,pub_name DESC;
--10 lISTE DES EDITEURS COMTANT  plus de 5 employes
SELECT pub_name AS "Editeur", COUNT(emp_id) AS "Nombre d'employes"
FROM employee INNER JOIN publishers ON employee.pub_id = publishers.pub_id
GROUP BY pub_name
HAVING  COUNT(emp_id) >= ALL (SELECT  COUNT(emp_id) FROM employee INNER JOIN publishers ON employee.pub_id = publishers.pub_id GROUP BY pub_name)
ORDER BY pub_name DESC;

--11 Les magasins pour lesquel il existe au moins un editeur dans le meme etat
SELECT st.stor_name AS "Magasins" , st.state AS "Etat" 
FROM stores st 
WHERE EXISTS (
    SELECT * FROM publishers pub
    WHERE pub.state = st.state
);

--12 Les magasins pour lesquel il existe au moins un editeur dans le meme etat avec le nombre d'editeurs dans le meme etat que le magasin
SELECT stores.stor_name AS "Magasins" , stores.state AS "Etat" , COUNT(pub_id)
FROM stores  INNER JOIN publishers ON publishers.state = stores.state 
WHERE EXISTS (
    SELECT * FROM publishers pub
    WHERE pub.state = stores.state
)
GROUP BY stores.state,  stores.stor_name;
--13 Le titre des livres qui se sont vendus a 25 exemplaires et plus
SELECT title as "Titre", SUM(qty) as "Qtes vendus"
FROM sales  
INNER JOIN titles ON sales.title_id = titles.title_id
GROUP BY title
HAVING SUM(qty)>=25
ORDER BY SUM(qty) DESC;
-- 14 Les livres qui ont un prix moyen superieur ou egal au prix moyen de tous les livres
SELECT type as "Type" ,AVG(price) AS "Moyenne des prix"
FROM titles 
GROUP BY type
HAVING AVG(price) > (SELECT AVG(price) FROM titles);
-- 15 Nombre de livres qui n'ont jamais ete vendus
SELECT COUNT(tt.title_id) AS " Livres non vendus"
FROM titles tt LEFT JOIN sales sal  ON tt.title_id = sal.title_id
WHERE ord_date IS NULL;

--16 Les employes embauches en 1991 par AlgoData
SELECT  CONCAT(fname, " ", lname, ", le ", DAY(hire_date), "/", MONTH(hire_date)) as "Employes embauches en 1991"
FROM employee INNER JOIN publishers ON employee.pub_id = publishers.pub_id
WHERE YEAR(hire_date)=1991 AND publishers.pub_name="Algodata Infosystems"
ORDER BY MONTH(hire_date);