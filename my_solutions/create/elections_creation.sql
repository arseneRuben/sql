/**********************************************/
/****************    CREATION DB  *************/
/**********************************************/  
DROP DATABASE IF EXISTS Elections;
CREATE DATABASE Elections;
 USE Elections;
/**********************************************/
/************    CREATION TABLE  **************/
/**********************************************/  
  CREATE TABLE partis(
     no_parti smallint NOT NULL  PRIMARY KEY ,
     nom_parti char(15)  NOT NULL,
     nb_adherents smallint NOT NULL
 );

   CREATE TABLE candidats(
     no_candidat smallint NOT NULL  PRIMARY KEY ,
     no_parti smallint  NOT NULL REFERENCES partis(no_parti),
     tour tinyint NOT NULL
 );

  CREATE TABLE electeurs(
     no_electeur smallint NOT NULL  PRIMARY KEY ,
     nom_electeurs varchar(20)  NOT NULL,
     adresse_electeurs varchar(25)  NOT NULL,
     nb_circonscription smallint NOT NULL
 );

   CREATE TABLE resultats(
     no_candidat smallint NOT NULL REFERENCES candidats(no_candidat),
     tour tinyint NOT NULL,
     nb_voix float NOT NULL,
     CONSTRAINT PK_RESULTATS PRIMARY KEY(no_candidat, tour)
 );

