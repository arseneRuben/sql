--1
SELECT title, price 
FROM titles
    where price > (SELECT AVG(price) FROM titles);

-- 2

SELECT DISTICT TYPE
from titles

-- 5
SELECT title 
from titles
where    exist (
    select title_id from  sales 
    where sales.title_id = titles
);

-- 
select title_id, titles
from titles 
join titles on sales.title_id = titles.title_id where ord_date between '19930101' AND '19931231';

select title_id, titles
from titles 
where not exists (
    select title_id from sales 
    where (ord_date between '19930101' AND '19931231' )
    and  sales.title_id = titles.title_id
);
   