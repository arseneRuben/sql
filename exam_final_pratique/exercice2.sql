use pubs;
DELIMITER //
DROP PROCEDURE IF EXISTS exercice2;
CREATE PROCEDURE exercice2()
BEGIN
        INSERT INTO publishers (pub_id, pub_name)values('9900','Les editions du Caribou');
        INSERT INTO titles (title_id, title, type, pub_id,advance, royalty, pubdate)
        values('XX0000','Alice au pays des merveilles', 'adventure','9900', 6500, 1170, NOW());
        INSERT INTO authors (au_id, au_lname, au_fname, phone, contract)
        VALUES('900-00-0000','Doucy', 'Marc', '450-777-1234',0),
        ('900-00-0001','Pierre', 'Guillou', '514-909-6733',0);
         INSERT INTO titleauthor (au_id, title_id,  royaltyper)
         VALUES('900-00-0000','XX0000',45 ),
                ('900-00-0001','XX0000',55 )
        ;

    COMMIT;
END; //
DELIMITER ;

CALL exercice2;