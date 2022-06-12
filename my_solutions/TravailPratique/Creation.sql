/**********************************************/
/****************    CREATION DB  *************/
/**********************************************/  
DROP DATABASE IF EXISTS dbBanque;
CREATE DATABASE dbBanque;
USE dbBanque;

/**********************************************/
/**********       TABLE CREATION       ********/
/**********************************************/

CREATE TABLE succursales(
    code CHAR(5) PRIMARY KEY,
    nom VARCHAR(25) NOT NULL,
    adresse VARCHAR(30) NOT NULL,
    tel1 VARCHAR(13)  NULL,
    tel2 VARCHAR(13)  NULL,
    CONSTRAINT CHK_code CHECK(code RLIKE '[A][0-9]{4}'),
    CONSTRAINT CHK_tel1  CHECK(tel1 RLIKE '(...)...[-]....'),
    CONSTRAINT CHK_tel2  CHECK(tel2 RLIKE '(...)...[-]....')
);

CREATE TABLE clients(
    id CHAR(10) PRIMARY KEY,
    code_succursale CHAR(5) NOT NULL REFERENCES succursales(code),
    nom VARCHAR(25) NOT NULL,
    prenom VARCHAR(30) NOT NULL,
    adresse VARCHAR(30) NOT NULL,
    tel VARCHAR(14)  NULL,
    CONSTRAINT CHK_client_id CHECK(id RLIKE '[C][0-9]{9}'),
    CONSTRAINT CHK_tel  CHECK(tel RLIKE '(...)...[-]....')
);
CREATE TABLE types_comptes(
    code char(1)   PRIMARY KEY ,
    description char(50) NOT NULL,
    CONSTRAINT CHK_type_operation  CHECK(code RLIKE '[CEV]')   
);
CREATE TABLE comptes(
    id int AUTO_INCREMENT PRIMARY KEY,
    client_id CHAR(10) NOT NULL REFERENCES clients(id),
    type_compte char(1) NOT NULL REFERENCES types_comptes(code),
    date_ouverture VARCHAR(10)  NOT NULL,
    solde DECIMAL(10,2) NOT NULL,
    CONSTRAINT CHK_date CHECK(date_ouverture RLIKE '([0-9]{2})/[0-9]{2}/[0-9]{2}')
);



CREATE TABLE Operations(
    id int   PRIMARY KEY ,
    compte_id int  NULL REFERENCES comptes(id),
    DatOperation  VARCHAR(10) NOT NULL,
    typeOp char(1) NOT NULL,
    montant DECIMAL(10,2) NOT NULL,
    CONSTRAINT CHK_type_operation  CHECK(typeOp RLIKE '[DR]'),
    CONSTRAINT CHK_dateOperation CHECK(datOperation RLIKE '([0-9]{2})/[0-9]{2}/[0-9]{2}')
);

/**********************************************/
/**********       DATA INSERTION       ********/
/**********************************************/

-- In table Succursales

INSERT Succursales (Code, Nom, Adresse, Tel1, Tel2) VALUES ('A0001', 'Succursale Centre-Ville', '1 Place Ville-Marie', '(514)999-9999', '(514)999-9998');
INSERT Succursales (Code, Nom, Adresse, Tel1, Tel2) VALUES ('A0002', 'Succursale Rive-Sud', '25 Bd Tachereau', '(450)444-4443', '(450)434-4444');
INSERT Succursales (Code, Nom, Adresse, Tel1, Tel2) VALUES ('A0003', 'Succursale Laval', '3000 Rue Saguenay', '(450)333-3333', '(450)333-3331');
INSERT Succursales (Code, Nom, Adresse, Tel1, Tel2) VALUES ('A0004', 'Succursale NDG', '145 Rue Pivot', '(514)744-6767', '(222)222-2222');

-- In table clients
INSERT Clients (Id, Code_Succursale, Nom, Prenom, Adresse, Tel) VALUES ('C100111001', 'A0001', 'Tremblay', 'Sophie', '12 Rue St-Denis #7', '(514)765-9899');
INSERT Clients (Id, Code_Succursale, Nom, Prenom, Adresse, Tel) VALUES ('C100111002', 'A0001', 'Choquette', 'Alain', '145 Av Papineau #15', '(514)235-1314');
INSERT Clients (Id, Code_Succursale, Nom, Prenom, Adresse, Tel) VALUES ('C100112001', 'A0002', 'Maggs', 'Steve', '101 Rue Marlo #12', '(450)345-6767');
INSERT Clients (Id, Code_Succursale, Nom, Prenom, Adresse, Tel) VALUES ('C100113002', 'A0003', 'Bonvi', 'Betty', '10 Rue Bolero', '(450)332-2222');
INSERT Clients (Id, Code_Succursale, Nom, Prenom, Adresse, Tel) VALUES ('C100111003', 'A0001', 'Nassim', 'Ali', '2345 place Ardenne #4', '(450)445-5676');
INSERT Clients (Id, Code_Succursale, Nom, Prenom, Adresse, Tel) VALUES ('C100113003', 'A0003', 'Thran Ti', 'Quan', '104 Rue Saguenay', '(450)340-8907');
-- In table Types comptes
INSERT Types_Comptes VALUES ('C','Compte cheque');
INSERT Types_Comptes VALUES ('E','Compte epargne');
INSERT Types_Comptes VALUES ('V','Compte Visa');
-- In table Comptes
INSERT Comptes (Client_Id, Type_Compte,Date_Ouverture, Solde) VALUES ('C100111001', 'C', '10/10/96', 5000);
INSERT Comptes (Client_Id, Type_Compte, Date_Ouverture, Solde) VALUES ('C100111001', 'E', '11/20/96', 3000);
INSERT Comptes (Client_Id, Type_Compte, Date_Ouverture, Solde) VALUES ('C100111002', 'C', '03/13/97',12300);
INSERT Comptes (Client_Id, Type_Compte, Date_Ouverture, Solde) VALUES ('C100111003', 'C', '12/23/98', 1200);
INSERT Comptes (Client_Id, Type_Compte, Date_Ouverture, Solde) VALUES ('C100111003', 'V', '10/09/98', 5000);
INSERT Comptes (Client_Id, Type_Compte, Date_Ouverture, Solde) VALUES ('C100112001', 'C', '09/15/98', 7600);
INSERT Comptes (Client_Id, Type_Compte, Date_Ouverture, Solde) VALUES ('C100113002', 'C', '03/24/98', 1300);
INSERT Comptes (Client_Id, Type_Compte, Date_Ouverture, Solde) VALUES ('C100113003', 'C', '12/04/95', 4500);
-- In table Operations


/**
INSERT Operations (Compte_Id, DatOperation, TypeOp, Montant) VALUES (1, '12/13/97','R', 60);
INSERT Operations (Compte_Id, DatOperation, TypeOp, Montant) VALUES (2, '12/15/97','D', 300);
INSERT Operations (Compte_Id, DatOperation, TypeOp, Montant) VALUES (1, '12/20/97','D', 800);
INSERT Operations (Compte_Id, DatOperation, TypeOp, Montant) VALUES (2, '12/23/97','R', 100);
INSERT Operations (Compte_Id, DatOperation, TypeOp, Montant) VALUES (3, '03/20/97','D', 1000);
INSERT Operations (Compte_Id, DatOperation, TypeOp, Montant) VALUES (3, '03/25/97','R', 40);
INSERT Operations (Compte_Id, DatOperation, TypeOp, Montant) VALUES (3, '05/20/97','D', 500);
INSERT Operations (Compte_Id, DatOperation, TypeOp, Montant) VALUES (3, '08/20/97','R', 80);
INSERT Operations (Compte_Id, DatOperation, TypeOp, Montant) VALUES (4, '12/25/98','D', 1000);
INSERT Operations (Compte_Id, DatOperation, TypeOp, Montant) VALUES (4, '12/01/99','D', 100);
INSERT Operations (Compte_Id, DatOperation, TypeOp, Montant) VALUES (5, '09/11/98','R', 100);
INSERT Operations (Compte_Id, DatOperation, TypeOp, Montant) VALUES (5, '11/13/98','D', 30);
INSERT Operations (Compte_Id, DatOperation, TypeOp, Montant) VALUES (5, '10/12/98','D', 70);
INSERT Operations (Compte_Id, DatOperation, TypeOp, Montant) VALUES (4, '10/01/99','R', 100);
INSERT Operations (Compte_Id, DatOperation, TypeOp, Montant) VALUES (7, '02/04/99','D', 1000);
**/