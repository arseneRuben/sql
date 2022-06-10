use pubs;
SHOW tables;
SELECT pub_id, pub_name FROM publishers 
WHERE pub_id IN ( SELECT pub_id FROM titles WHERE advance>10000);

SELECT pub_name FROM publishers WHERE pub_id IN (
SELECT DISTINCT pub_id FROM titles WHERE type IN ("business", "psychology"));

SELECT DISTINCT advance , count(title_id) AS "nbre livres" FROM titles WHERE pub_id = (
    SELECT  pub_id FROM publishers WHERE pub_name = "Binnet & Hardley")
    GROUP BY advance;

SELECT title_id, title FROM titles WHERE pub_id IN (SELECT pub_id FROM publishers 
    WHERE pub_name = "AlgoData infosystems");



-- Liste des livres pas vendus en 1993
SELECT title as "Titre des livre non vendus en 1993" FROM titles as t WHERE NOT EXISTS (
    SELECT * FROM sales AS s WHERE YEAR(s.ord_date)!= 1993 AND t.title_id = s.title_id
);

SELECT type, AVG(price) AS  moyenne , ABS(AVG(price)-(SELECT AVG(price) FROM titles)) AS "Ecarts"
 FROM titles 
 GROUP BY type;

 SELECT  t.pub_id , AVG(t.advance) AS "Moyenne par editeur" , (SELECT type,   AVG(advance) AS "Moyenne par type" FROM titles WHERE t.pub_id=pub_id GROUP BY type )
 FROM titles t
 GROUP BY t.pub_id;
 
SELECT type , pub_id , COUNT(*) AS NOMBRE_LIVRE_TYPE,
(SELECT COUNT(*) FROM titles t2 WHERE t2.pub_id = t1.pub_id) AS NOMBRE_LIVRE_EDITEUR
FROM titles t1
WHERE pub_id IS NOT NULL
GROUP BY pub_id, type
ORDER BY type;