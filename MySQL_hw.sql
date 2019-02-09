Use sakila;

#1a
SELECT actor.first_name, actor.last_name
FROM actor;

---
#1b

SELECT CONCAT(First_Name, " ", Last_Name) AS Actor_Name
	FROM actor
;

---
#2a

SELECT * FROM actor
WHERE first_name = "Joe";

---
#2b

SELECT *
FROM actor                                       
WHERE last_name LIKE '%GEN%';

---
#2c

 SELECT * 
 FROM actor 
 WHERE last_name LIKE '%LI%' 
 ORDER BY last_name, first_name;
 
 ---
#2d
 
SELECT country_id, country 
FROM country 
WHERE country IN ('Afghanistan' , 'Bangladesh', 'China');

---
# 3a

ALTER TABLE actor 
ADD COLUMN description BLOB NULL DEFAULT NULL;

---
#3b

ALTER TABLE actor 
DROP COLUMN description;

Select * From actor;

---
#4a

SELECT DISTINCT last_name, 
COUNT(last_name) AS 'name_count' 
FROM actor GROUP BY last_name;

---
#4b

SELECT DISTINCT last_name, 
COUNT(last_name) AS 'name_count' 
FROM actor GROUP BY last_name 
HAVING name_count >=2;

---
#4c
UPDATE actor 
SET first_name = 'HARPO' 
WHERE first_name = 'GROUCHO' 
AND last_name = 'WILLIAMS';

Select * From actor 
Where last_name = 'Williams';

---

#4d

UPDATE actor 
SET first_name= 'GROUCHO'
WHERE first_name='HARPO' AND last_name='WILLIAMS';

Select * From actor 
Where first_name = 'GROUCHO';

---
#5a

DESCRIBE sakila.address;

---
#6a

SELECT staff.first_name, staff.last_name, address.address
FROM staff INNER JOIN address ON staff.address_id = address.address_id;

---

#6b

SELECT staff.first_name, staff.last_name, SUM(payment.amount) AS 'TOTAL'
FROM staff INNER JOIN payment
ON staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE '2005-08%'
GROUP BY payment.staff_id;

---
#6c

SELECT title, 
COUNT(actor_id) AS number_of_actors 
FROM film INNER JOIN film_actor 
ON film.film_id = film_actor.film_id 
GROUP BY title;

---

#6d

SELECT title, 
COUNT(inventory_id) AS number_of_copies 
FROM film INNER JOIN inventory 
ON film.film_id = inventory.film_id 
WHERE title = 'Hunchback Impossible';

---
#6e

SELECT first_name, last_name,
SUM(amount) AS total_paid 
FROM payment INNER JOIN customer ON payment.customer_id = customer.customer_id 
GROUP BY payment.customer_id ORDER BY last_name ASC;

---

#7a

SELECT title FROM film
WHERE (title LIKE 'K%' OR title LIKE 'Q%') 
AND language_id IN (SELECT language_id FROM language WHERE name= "English");

---
#7b

SELECT actor.last_name, actor.first_name FROM actor 
INNER JOIN film
WHERE actor_id IN (SELECT actor_id FROM film_actor 
WHERE film_id IN (SELECT film_id FROM film 
WHERE title = "Alone Trip")
);

---
#7c

SELECT customer.last_name, customer.first_name, customer.email FROM customer 
INNER JOIN customer_list 
ON customer.customer_id = customer_list.ID 
WHERE customer_list.country = 'Canada';

---

#7d

SELECT title FROM film 
WHERE film_id IN (SELECT film_id 
FROM film_category 
WHERE category_id 
IN (SELECT category_id FROM category WHERE name = 'Family'));

---
#7e 

SELECT title, COUNT(film.film_id) AS 'Count_of_Rented_Movies'
FROM  film
INNER JOIN inventory ON (film.film_id= inventory.film_id)
INNER JOIN rental ON (inventory.inventory_id=rental.inventory_id)
GROUP BY title ORDER BY Count_of_Rented_Movies DESC;

---
#7f

SELECT staff.store_id, SUM(payment.amount) AS "Store Revenue"
FROM payment
INNER JOIN staff ON (payment.staff_id = staff.staff_id)
GROUP BY store_id;

---

#7g

SELECT store.store_id, city.city, country.country FROM store 
INNER JOIN address ON store.address_id = address.address_id 
INNER JOIN city ON address.city_id = city.city_id 
INNER JOIN country ON city.country_id = country.country_id;

---
#7h

SELECT category.name AS "Top Five", SUM(payment.amount) AS "Gross" 
FROM category
INNER JOIN film_category ON (category.category_id = film_category.category_id)
INNER JOIN inventory ON (film_category.film_id = inventory.film_id)
INNER JOIN rental ON (inventory.inventory_id=rental.inventory_id)
INNER JOIN payment ON (rental.rental_id = payment.rental_id)
GROUP BY category.name ORDER BY Gross;

---
#8a

DROP VIEW IF EXISTS top_five_genres; CREATE VIEW top_five_genres AS

SELECT category.name AS "Top Five", SUM(payment.amount) AS "Gross" 
FROM category
INNER JOIN film_category ON (category.category_id = film_category.category_id)
INNER JOIN inventory ON (film_category.film_id = inventory.film_id)
INNER JOIN rental ON (inventory.inventory_id=rental.inventory_id)
INNER JOIN payment ON (rental.rental_id = payment.rental_id)
GROUP BY category.name ORDER BY Gross DESC LIMIT 5;

---
#8B

SELECT * FROM top_five_genres;

---
#8C

 DROP VIEW top_five_genres;


