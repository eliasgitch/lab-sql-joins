-- LABORATORIO 3 

# 1. Listar el número de películas por categoría.

SELECT COUNT(DISTINCT f.film_id) as num_peliculas, c.name as categoria
FROM film as f
INNER JOIN film_category as fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
GROUP BY c.category_id;

# 2. Recuperar el ID de la tienda, la ciudad y el país de cada tienda.

SELECT store.store_id, city.city_id, country.country 
FROM store
INNER JOIN address
ON store.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id;

# 3. Calcula los ingresos totales generados por cada tienda en dolares.

SELECT store.store_id, SUM(payment.amount) AS total_revenue
FROM store
INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

# 4. Determina la duración media de las películas para cada categoría.

SELECT ROUND(AVG(film.length), 2) as duracion_media, category.name as categoria
FROM film
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY categoria
ORDER BY duracion_media DESC;

# 5. Identifica las categorías de películas con la mayor duración media.

SELECT ROUND(AVG(film.length), 2) as duracion_media, category.name as categoria
FROM film
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY categoria
ORDER BY duracion_media DESC
LIMIT 5; 

# 6. Muestra las 10 películas más alquiladas, ordenadas de forma descendente.

SELECT film.title, COUNT(*) as alquileres
FROM rental
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY alquileres DESC
LIMIT 5; 

# 7. Determina si "Academy Dinosaur" puede alquilarse en la Tienda 1.

SELECT film.title, store.store_id
FROM film
INNER JOIN inventory
ON film.film_id = inventory.film_id
INNER JOIN store
ON inventory.store_id = store.store_id
WHERE store.store_id = 1
AND film.title = 'Academy Dinosaur';

# 8. Proporciona una lista de todos los títulos de películas distintos, junto con su estado de disponibilidad en el inventario. 
# Incluye una columna que indique si cada título está 'Available' o 'NOT available'. 
# Ten en cuenta que hay 42 títulos que no se encuentran en el inventario, y esta información puede obtenerse usando una sentencia CASE combinada con IFNULL.

SELECT DISTINCT film.title, 
CASE 
	WHEN IFNULL(COUNT(inventory.inventory_id), 0) > 0 THEN 'Disponible'
    ELSE 'Indisponible'
END AS Disponibilidad
FROM film 
LEFT JOIN inventory 
ON film.film_id = inventory.film_id
GROUP BY film.title;

