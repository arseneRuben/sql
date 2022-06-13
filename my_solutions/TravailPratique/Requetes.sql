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
SELECT id AS "Identificateur", nom, prenom, description AS "Type de compte"
FROM clients INNER JOIN comptes ON clients.id = comptes.client_id 
            INNER JOIN types_comptes ON comptes.type_compte = types_comptes.code;
--3 Liste de clients ayant  un compte avec les operation qu'ils ont effectues
SELECT Nom, Prenom,  DATE_FORMAT(datOperation, "%b %d %Y %h:%i%p") AS "Date Operation" , code AS "Type de Compte" , typeOp AS "Type Operation"
FROM  clients INNER JOIN comptes ON clients.id = comptes.client_id 
              INNER JOIN operations ON comptes.id = operations.compte_id
              INNER JOIN types_comptes ON comptes.type_compte = types_comptes.code
ORDER BY YEAR(datOperation)  ASC;
--4 La liste des clients qui ont effectué au moins une opération en 1999. La liste doit comporter l'identificateur, le nom et le prénom du client.
SELECT  clients.id, nom, prenom 
FROM clients INNER JOIN comptes ON clients.id = comptes.client_id 
             INNER JOIN operations ON compte_id = comptes.id 
WHERE YEAR(operations.datoperation)=1999
GROUP BY clients.id
HAVING COUNT(operations.id)>0;

--5 Liste des clients et le nombre d'operation en fonction du type
SELECT Nom, Prenom, typeOp AS "TypeOp", COUNT(operations.id) AS "Nombres d'operations", SUM(operations.montant) AS "Montant total des operations"
FROM  clients INNER JOIN comptes ON clients.id = comptes.client_id 
              INNER JOIN operations ON comptes.id = operations.compte_id
              INNER JOIN types_comptes ON comptes.type_compte = types_comptes.code
GROUP BY    nom , typeOp 
ORDER BY    prenom DESC, typeOp ASC;
-- 6Total des operationd de debit et de credit pour les trois types de comptes
