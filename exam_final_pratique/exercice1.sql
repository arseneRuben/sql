use pubs;
DELIMITER //
DROP PROCEDURE IF EXISTS exercice1;
CREATE PROCEDURE exercice1()
BEGIN
        UPDATE titles SET price = price*1.003 WHERE pub_id=(
            SELECT pub_id FROM publishers WHERE pub_name = "Algodata Infosystems"
        )
        ;
    COMMIT;
END; //
DELIMITER ;

CALL exercice1;