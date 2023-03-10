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
SELECT clients.id AS "Identificateur", nom, prenom, description AS "Type de compte"
FROM clients INNER JOIN comptes ON clients.id = comptes.client_id 
            INNER JOIN types_comptes ON comptes.type_compte = types_comptes.code;
--3 Liste de clients ayant  un compte avec les operation qu'ils ont effectues
SELECT nom, prenom,  DATE_FORMAT(datOperation, "%b %d %Y %h:%i%p") AS "Date Operation" , code AS "Type de Compte" , typeOp AS "Type Operation"
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
SELECT nom, prenom, typeOp AS "TypeOp", COUNT(operations.id) AS "Nombres d'operations", SUM(operations.montant) AS "Montant total des operations"
FROM  clients INNER JOIN comptes ON clients.id = comptes.client_id 
              INNER JOIN operations ON comptes.id = operations.compte_id       
GROUP BY    nom , typeOp 
ORDER BY    prenom DESC, typeOp ASC;
-- 6 Total des operations de debit et de credit pour les trois types de comptes

 SELECT DISTINCT code as "Type de compte",
         (SELECT IFNULL( SUM(montant),0)  FROM operations INNER JOIN comptes ON comptes.id = operations.compte_id   WHERE typeOp = 'D' AND YEAR(datOperation)=1997   AND comptes.type_compte = code) AS " 1997 credit" , 
         (SELECT IFNULL( SUM(montant),0)  FROM operations INNER JOIN comptes ON comptes.id = operations.compte_id   WHERE typeOp = 'R'  AND YEAR(datOperation)=1997  AND comptes.type_compte = code) AS "  1997 debit",
         (SELECT IFNULL( SUM(montant),0)  FROM operations INNER JOIN comptes ON comptes.id = operations.compte_id   WHERE typeOp = 'D' AND YEAR(datOperation)=1998   AND comptes.type_compte = code) AS " 1998 credit " , 
         (SELECT IFNULL( SUM(montant),0)  FROM operations INNER JOIN comptes ON comptes.id = operations.compte_id   WHERE typeOp = 'R'  AND YEAR(datOperation)=1998  AND comptes.type_compte = code) AS " 1998 debit",
         (SELECT IFNULL( SUM(montant),0)  FROM operations INNER JOIN comptes ON comptes.id = operations.compte_id   WHERE typeOp = 'D' AND YEAR(datOperation)=1999  AND comptes.type_compte = code) AS " 1999 credit", 
         (SELECT IFNULL( SUM(montant),0)  FROM operations INNER JOIN comptes ON comptes.id = operations.compte_id   WHERE typeOp = 'R'  AND YEAR(datOperation)=1999  AND comptes.type_compte = code) AS " 1999 debit "
 FROM types_comptes  ;

 --7 Liste des clients dont le solde du compte cheque depasse la moyenne des soldes de tous les comptes cheque.
SELECT nom, prenom , solde 
FROM clients INNER JOIN comptes ON clients.id = comptes.client_id 
WHERE solde > (SELECT AVG(solde) FROM comptes WHERE type_compte = 'C' );

--8  
SELECT comptes.id AS "Id Compte", clients.id AS "Id Client",   type_compte AS "TypeCompte",  solde AS "Solde Depart", 
(Select SUM(montant) FROM operations  INNER JOIN comptes ON comptes.id = operations.compte_id  WHERE  operations.typeOp='D'  AND comptes.client_id = clients.id ) AS Debits,
 (Select SUM(montant) FROM operations  INNER JOIN comptes ON comptes.id = operations.compte_id  WHERE  operations.typeOp='R' AND comptes.client_id = clients.id ) AS Credits,
 solde - (Select SUM(montant) FROM operations  INNER JOIN comptes ON comptes.id = operations.compte_id  WHERE  operations.typeOp='D'  AND comptes.client_id = clients.id ) 
        +  (Select SUM(montant) FROM operations  INNER JOIN comptes ON comptes.id = operations.compte_id  WHERE  operations.typeOp='R' AND comptes.client_id = clients.id )
  As "Solde final"
FROM  clients INNER JOIN comptes ON clients.id = comptes.client_id 
GROUP BY  clients.id, type_compte
HAVING NOT(debits IS NULL);


--9  LEs 4 vues
CREATE  OR REPLACE VIEW AgenceCentre 
AS
SELECT clients.nom as Nom, Prenom, type_compte AS Compte, Solde
FROM clients INNER JOIN comptes ON clients.id = comptes.client_id 
             INNER JOIN succursales ON clients.code_succursale = succursales.code 
WHERE succursales.nom = "Succursale Centre-Ville";

CREATE  OR REPLACE VIEW AgenceRivesud 
AS
SELECT clients.nom as Nom, Prenom, type_compte AS Compte, Solde
FROM clients INNER JOIN comptes ON clients.id = comptes.client_id 
             INNER JOIN succursales ON clients.code_succursale = succursales.code 
WHERE succursales.nom = "Succursale Rive-Sud"; -- Respecte le nom des villes

CREATE   OR REPLACE VIEW AgenceLaval 
AS
SELECT clients.nom as Nom, Prenom, type_compte AS Compte, Solde
FROM clients INNER JOIN comptes ON clients.id = comptes.client_id 
             INNER JOIN succursales ON clients.code_succursale = succursales.code 
WHERE succursales.nom = "Succursale Laval";

CREATE  OR REPLACE VIEW SuccurcaseRiveNDG 
AS
SELECT clients.nom as Nom, Prenom, type_compte AS Compte, Solde
FROM clients INNER JOIN comptes ON clients.id = comptes.client_id 
             INNER JOIN succursales ON clients.code_succursale = succursales.code 
WHERE succursales.nom = "Succursale NDG";

--10 Liste des clients qui n'ont jamais effectué d'opérations
SELECT nom, prenom 
FROM clients 
WHERE id IN(  -- Ici je prend la liste des clients ayant un comptes
SELECT  clients.id
FROM clients RIGHT JOIN comptes ON clients.id = comptes.client_id
              EXCEPT  -- Ici je fais la difference ensembliste qui permettra de retrouver les client qui n'ont pas fait d'operations
SELECT clients.id  -- Ici je prend la liste des clients ayant un compte avec operation
FROM clients RIGHT JOIN comptes ON clients.id = comptes.client_id
               RIGHT JOIN operations ON comptes.id = operations.compte_id
               
);

--11 
DELIMITER //
DROP PROCEDURE IF EXISTS mouvement100;
CREATE PROCEDURE mouvement100()
BEGIN
    
        INSERT INTO operations(Compte_Id, DatOperation, TypeOp, Montant) VALUES (2,NOW(), 'R', 100),(5,NOW(), 'D', 100);
        UPDATE comptes SET solde = solde-100 WHERE id=2;
        UPDATE comptes SET solde = solde+100 WHERE id=5;
    
    COMMIT;
END; //
DELIMITER ;

CALL mouvement100;