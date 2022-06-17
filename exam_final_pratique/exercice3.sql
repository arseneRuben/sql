use pubs;
DELIMITER //
DROP PROCEDURE IF EXISTS exercice3;
CREATE PROCEDURE exercice3()
BEGIN
        INSERT INTO publishers (pub_id, pub_name)values('9910','Associated Editions');
        UPDATE titles SET pub_id = '9910' WHERE pub_id IN ('0736', '0877');
        UPDATE employee SET pub_id = '9910' WHERE pub_id IN ('0736', '0877');
        DELETE FROM publishers WHERE pub_id IN ('0736', '0877');

    COMMIT;
END; //
DELIMITER ;

CALL exercice3;