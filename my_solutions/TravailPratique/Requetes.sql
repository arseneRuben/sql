USE dbBanque;
/*1 Écrire les requêtes pour afficher le contenu de chacune des tables avec des entêtes significatives pour chaque colonne*/  
--1-A Liste complete des client
SELECT * FROM clients;
--1-B Liste complete des comptes
SELECT * FROM comptes;
--1-C Liste complete des operations
SELECT * FROM operations;
--1-D Liste complete des succursales
SELECT * FROM succursales;
--1-E Liste complete des types de comptes
SELECT * FROM types_comptes;

--2 Écrire la requête qui permet d'afficher la liste des comptes clients:
SELECT nom, prenom, CONCAT(code, ": ", description) AS "Type de compte"
FROM clients INNER JOIN comptes ON clients.id = comptes.client_id 
            INNER JOIN types_comptes ON comptes.type_compte = types_comptes.code;
--3 La liste des clients qui ont effectué au moins une opération en 1999. La liste doit comporter l'identificateur, le nom et le prénom du client.
SELECT  clients.id, nom, prenom 
FROM clients INNER JOIN comptes ON clients.id = comptes.client_id 
             INNER JOIN operations ON compte_id = comptes.id 
WHERE YEAR(operations.datoperation)=1999
GROUP BY clients.id
HAVING COUNT(operations.id)>0;
