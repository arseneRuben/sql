--1 Afficher les noms d'éditeurs qui publient des livres dans les catégories "business" ou "psychology".
SELECT DISTINCT pub_name AS "editeur ", type
 FROM publishers 
 INNER JOIN titles ON publishers.pub_id = titles.pub_id
 WHERE type ="psychology"
 
UNION
SELECT DISTINCT pub_name AS "editeur ", type
 FROM publishers 
 INNER JOIN titles ON publishers.pub_id = titles.pub_id
 WHERE type ="business";

 --2 Afficher les noms d'éditeurs qui publient des livres dans les catégories "business" et "psychology".
SELECT DISTINCT pub_name AS "editeur "
 FROM publishers 
 INNER JOIN titles ON publishers.pub_id = titles.pub_id
 WHERE type ="psychology"
INTERSECT
SELECT DISTINCT pub_name AS "editeur "
 FROM publishers 
 INNER JOIN titles ON publishers.pub_id = titles.pub_id
 WHERE type ="business";

  --2 Afficher les noms d'éditeurs qui publient des livres dans les catégories "business" et "psychology".
SELECT DISTINCT pub_name AS "editeur "
 FROM publishers 
 INNER JOIN titles ON publishers.pub_id = titles.pub_id
 WHERE type ="psychology"
EXCEPT
SELECT DISTINCT pub_name AS "editeur "
 FROM publishers 
 INNER JOIN titles ON publishers.pub_id = titles.pub_id
 WHERE type ="business";


 