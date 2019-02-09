use sakila;

-- 1a
Select first_name 'First Name', last_name 'Last Name'
From actor;

-- 1b
Select concat(upper(first_name), ' ', upper(last_name)) 'Actor Name'
From actor;

-- 2a
Select actor_id, first_name, last_name
from actor
where first_name = 'Joe';

-- 2b
Select first_name ' First Name', last_name 'Last Name'
from actor
where last_name like '%GEN%';

-- 2c
Select last_name 'Last Name', first_name 'First Name'
from actor
where last_name like '%LI%';

-- 2d
Select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a
ALTER TABLE actor
ADD COLUMN description mediumblob;

-- 3b
ALTER TABLE actor
DROP COLUMN description;

-- 4a
Select last_name 'Last Name', count(last_name) 'Total Count'
from actor
group by last_name;

-- 4b
Select last_name 'Last Name', count(last_name) ' Total Count'
from actor
group by last_name
having count(last_name) > 1;

-- 4c
UPDATE actor 
SET first_name= 'HARPO'
WHERE first_name='GROUCHO' AND last_name='WILLIAMS';

-- 4d
UPDATE actor 
SET first_name= 'GROUCHO'
WHERE first_name='HARPO' AND last_name='WILLIAMS';

-- 5a
SHOW CREATE TABLE address;

-- 6a
SELECT s.first_name, s.last_name, a.address
FROM staff s
INNER JOIN address a ON
s.address_id=a.address_id;

-- 6b
SELECT s.first_name 'First Name', s.last_name 'Last Name', sum(p.amount) 'Total'
FROM staff s
INNER JOIN payment p 
ON s.staff_id=p.staff_id
group by s.first_name, s.last_name;

-- 6c
SELECT f.title, COUNT(fa.actor_id) AS 'Total'
FROM film f 
INNER JOIN film_actor  fa 
ON f.film_id = fa.film_id
GROUP BY f.title;

-- 6d
Select title, film_id
from film
where title = 'Hunchback Impossible';

Select * 
From inventory
where film_id = 439;   -- Answer is 6 Copies

-- 6e
SELECT c.first_name 'First Name', c.last_name 'Last Name', SUM(p.amount) AS 'Total Amount Paid'
FROM customer c 
INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY c.last_name;

-- 7a
SELECT title
FROM film
WHERE (title LIKE 'K%' OR title LIKE 'Q%') 
AND language_id=(SELECT language_id FROM language where name='English');

-- 7b
SELECT first_name 'First Name', last_name 'Last Name'
FROM actor
WHERE actor_id
	IN (SELECT actor_id FROM film_actor WHERE film_id 
		IN (SELECT film_id from film where title='ALONE TRIP'));

-- 7c
SELECT first_name 'First Name', last_name 'Last Name', email 'E-Mail' 
FROM customer c
JOIN address a ON (c.address_id = a.address_id)
JOIN city ci ON (a.city_id=ci.city_id)
JOIN country co ON (ci.country_id=co.country_id)
where co.country = 'Canada';

-- 7d
SELECT title 
FROM film f
JOIN film_category fcat on (f.film_id=fcat.film_id)
JOIN category c on (fcat.category_id=c.category_id)
WHERE c.name = 'family';

-- 7e
SELECT title, COUNT(f.film_id) AS 'Times_Rented'
FROM  film f
JOIN inventory i ON (f.film_id= i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
GROUP BY title 
ORDER BY Times_Rented DESC;

-- 7f
SELECT s.store_id, SUM(p.amount) 'Revenue' 
FROM payment p
JOIN staff s ON (p.staff_id=s.staff_id)
GROUP BY s.store_id;

-- 7g
SELECT store_id, city, country 
FROM store s
JOIN address a ON (s.address_id=a.address_id)
JOIN city c ON (a.city_id=c.city_id)
JOIN country cntry ON (c.country_id=cntry.country_id);

-- 7h
SELECT c.name AS 'Top Five Genres', SUM(p.amount) AS 'Revenue' 
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name 
ORDER BY Revenue DESC limit 5;

-- 8a
Create View Top_Five_Genres AS
	SELECT c.name AS 'Top Five Genres', SUM(p.amount) AS 'Revenue' 
	FROM category c
	JOIN film_category fc ON (c.category_id=fc.category_id)
	JOIN inventory i ON (fc.film_id=i.film_id)
	JOIN rental r ON (i.inventory_id=r.inventory_id)
	JOIN payment p ON (r.rental_id=p.rental_id)
	GROUP BY c.name 
	ORDER BY Revenue DESC limit 5;

-- 8b
Select * from Top_Five_Genres;

-- 8c
Drop View Top_Five_Genres;

































