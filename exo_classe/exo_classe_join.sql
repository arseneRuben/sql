use pubs;
-- Liste des paires(auteur, editeur) demeurant dans la meme ville
SELECT  CONCAT(authors.au_lname," ", authors.au_fname) as Auteur, pub_name as Editeur, authors.state as "Ville"
FROM publishers INNER JOIN authors ON publishers.state = authors.state;
-- Liste des paires(auteur, editeur) demeurant dans la meme ville incluant la liste des auteurs ne repondant pas a ce critere
SELECT  CONCAT(authors.au_lname," ", authors.au_fname) as Auteur, pub_name as Editeur, authors.state as "Ville"
FROM publishers RIGHT JOIN authors ON publishers.state = authors.state;
-- Liste des paires(auteur, editeur) demeurant dans la meme ville incluant la liste des editeurs ne repondant pas a ce critere
SELECT  CONCAT(authors.au_lname," ", authors.au_fname) as Auteur, pub_name as Editeur, publishers.state as "Ville"
FROM publishers LEFT JOIN authors ON publishers.state = authors.state;