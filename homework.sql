-- Week 5 - Wednesday Questions

-- 1. List all customers who live in Texas (use JOINs)

-- Jennifer Davis, Kim Cruz, Richard Mccrary, Bryan Hardison, Ian Still

SELECT first_name::TEXT ||' '|| last_name::TEXT AS full_name, district
FROM customer
JOIN "address" 
ON customer.address_id = "address".address_id
WHERE district = 'Texas'

-- 2. Get all payments above $6.99 with the Customer's Full Name

-- 1406 records

SELECT amount, first_name::TEXT ||' '|| last_name::TEXT AS full_name
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
ORDER BY amount;

-- 3. Show all customers names who have made payments over $175(use subqueries)

-- Tommy Collazo, Eleanor Hunt, Rhonda Kennedy, Karl Seal, Clara Shaw, Marion Snyder

SELECT first_name::TEXT ||' '|| last_name::TEXT AS full_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING sum(amount) > 175
)
ORDER BY last_name;

-- 4. List all customers that live in Nepal (use the city table)

-- Kevin Schuler

SELECT first_name::TEXT ||' '|| last_name::TEXT AS full_name
FROM customer
JOIN "address"
ON customer.address_id = "address".address_id
JOIN city
ON city.city_id = "address".city_id
JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

-- 5. Which staff member had the most transactions?

-- Jon Stephens

SELECT first_name::TEXT ||' '|| last_name::TEXT AS staff_name
FROM staff
WHERE staff_id IN (
    SELECT staff_id
    FROM payment
    GROUP BY staff_id
    ORDER BY count(payment_id) DESC
    LIMIT 1
);
    
-- 6. How many movies of each rating are there?

-- G 178
-- PG 194
-- PG-13 223
-- R 195
-- NC-17 210

SELECT rating, count(film_id)
FROM film
GROUP BY rating
ORDER BY rating;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

-- 130 customers

SELECT first_name::TEXT ||' '|| last_name::TEXT AS full_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE amount > 6.99
    GROUP BY customer_id
    HAVING count(customer_id) = 1
)
ORDER BY full_name;

-- 8. How many free rentals did our stores give away?

-- 24 total
-- Store 1 has 15
-- Store 2 has 9

SELECT count(amount)
FROM payment
WHERE amount = 0;

SELECT store_id, count(payment_id)
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
WHERE amount = 0
GROUP BY store_id;