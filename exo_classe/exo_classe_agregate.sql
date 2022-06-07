-- Etat contenant plus d'nu auteur
SELECT state, COUNT(*) AS "Nombre auteurs" FROM authors  GROUP BY(state) HAVING COUNT(*)>1;
-- 
SELECT FORMAT(AVG(advance),2 ) as "Avance moy", SUM(ytd_sales) as "Somme des ventes", COUNT(*) as "Nombre"  FROM titles GROUP BY(type);

SELECT FORMAT(AVG(advance),2), SUM(ytd_sales) as "Somme des ventes", COUNT(*) as "Nombre"  FROM titles GROUP BY(type)  HAVING COUNT(*)>2;

SELECT type, FORMAT(AVG(royalty),2) AS "Redevance Moyenne" FROM titles GROUP BY(type)  HAVING AVG(royalty) BETWEEN 10 AND 13;