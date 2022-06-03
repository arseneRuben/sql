use pubs;
/*SELECT title_id, title, price, advance FROM titles WHERE advance = 5000;
SELECT title_id, title, price, advance FROM titles WHERE advance > 5000;
SELECT title_id, title, price, advance FROM titles WHERE advance BETWEEN 5000 AND  7000;
SELECT title_id, title, price, advance FROM titles WHERE advance NOT BETWEEN 5000 AND  7000;
SELECT * FROM authors WHERE state IN ('MD', 'TN', 'KS', 'UT');
SELECT * FROM authors WHERE state NOT IN ('MD', 'TN', 'KS', 'UT');
SELECT CONCAT(au_lname," ",au_fname) AS "Nom et Prenom" , CONCAT(address," ",city," ",state) AS "Adresse" from authors;
SELECT CONCAT(au_lname," ",au_fname) AS "Nom et Prenom" , CONCAT(address," ",city," ",state) AS "Adresse" from authors WHERE state = 'CA';
SELECT CONCAT(au_lname," ",au_fname) AS "Nom et Prenom" , CONCAT(address," ",city," ",state) AS "Adresse" from authors WHERE state != 'CA';*/
--SELECT title, price FROM titles  WHERE title_id RLIKE "Computer"; -- LIKE %computer%
--SELECT title, price FROM titles WHERE title_id "computer[^s]" --SELECT title, price FROM titles  WHERE (title LIKE "%Computer%" AND title_id NOT IN ( SELECT title_id FROM titles  WHERE title LIKE "%Computers%"));

--SELECT title, price FROM titles  WHERE title  RLIKE "^[SB]U" ;  
-- WHERE title_id RLIKE "^[TU][BU]"
--SELECT title, price FROM titles  WHERE title  NOT RLIKE "^[SB]U" ;
--SELECT title, price FROM titles  WHERE title RLIKE "^[^SB]o" ;
--SELECT title, price FROM titles  WHERE title_id NOT IN ( SELECT title_id FROM titles  WHERE title LIKE "^S" OR title RLIKE "^B") AND title RLIKE "_o%";
--1
--SELECT title_id ,title, price FROM titles WHERE title_id RLIKE "^[BMC]";
--2
--SELECT title_id ,title, price FROM titles WHERE title_id RLIKE "^[BMC]" AND pub_id = 1389;
--3
--SELECT title_id ,title, price FROM titles WHERE title_id RLIKE "^[BMC]" AND royalty BETWEEN 10 AND 15;
--4
--SELECT au_lname, au_fname, state, phone FROM authors WHERE state='CA' AND phone RLIKE "^[4][1][5]";
--5
--SELECT au_lname, au_fname, state, phone FROM authors WHERE state='CA' AND phone NOT RLIKE "^[4][1][5]";

--SELECT au_lname, au_fname, state, phone FROM authors WHERE state!='CA' AND phone RLIKE "^[^235]";
--7
--SELECT * FROM publishers WHERE country = "USA";
--8
--SELECT * FROM publishers WHERE country = "USA" OR country = "France" ;
SELECT title, title_id from titles GROUP BY title,title_id;



