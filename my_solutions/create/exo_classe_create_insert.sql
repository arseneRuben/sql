DROP DATABASE IF EXISTS exo_classe_create_db;
CREATE DATABASE exo_classe_create_db;
 USE exo_classe_create_db;

/**********************************************/
/****************    CREATION  ****************/
/**********************************************/   
  CREATE TABLE role(
     id int NOT NULL AUTO_INCREMENT PRIMARY KEY ,
     nom VARCHAR(10)
 );

  CREATE TABLE user(
     id int NOT NULL PRIMARY KEY,
     nom VARCHAR(30),
     prenom VARCHAR(30),
     email VARCHAR(30) NOT NUll UNIQUE CHECK (email RLIKE "@"),
     id_role int NOT NULL  ,
     CONSTRAINT FK_role FOREIGN KEY(id_role) REFERENCES role (id)
 );

  CREATE TABLE adresse(
     id_user int NOT NULL  ,
     valeur TEXT,
    CONSTRAINT FK_user FOREIGN KEY(id_user) REFERENCES user (id)
   
 );
/**********************************************/
/****************    INSERTION  ****************/
/**********************************************/  
 INSERT INTO role
  VALUES(1,"admin"),(2,"client"),(3,"secretaire");

INSERT INTO user 
VALUES(1, "Einstein", "Albert", "albertdeush@gmail.com", 1),
(2, "Rocks", "Pascal", "pascalrocke@gmail.com", 2),
(3, "Herzt", "Alain", "alainherzt@polymtl.ca", 3);

INSERT INTO adresse
VALUES(1, "3454 Van Horne"),
(2, "2354 Avenue du Parc"),
(3, "5456 Rue d'Oslo");

SHOW TABLES;

SELECT * FROM USER;