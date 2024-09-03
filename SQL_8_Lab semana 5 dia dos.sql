use sakila;
-- Clasificar películas por duración (filtrar las filas con valores nulos o cero en la columna de duración). Seleccionar solo las columnas título, duración y clasificación en la salida:
SELECT title, length, RANK() OVER (ORDER BY length) AS ranking
FROM film
WHERE length IS NOT NULL AND length > 0;

-- Clasificar películas por duración dentro de la categoría de clasificación (filtrar las filas con valores nulos o cero en la columna de duración).
-- En tu salida, seleccionar solo las columnas título, duración, clasificación y clasificación
SELECT title, length, rating, 
	RANK() OVER(PARTITION BY rating ORDER BY length) AS Ranking
FROM film
WHERE length IS NOT NULL AND length > 0;

-- ¿Cuántas películas hay para cada una de las categorías en la tabla de categorías? Sugerencia: Utiliza unir apropiadamente las tablas "categoría" y "categoría de película":
SELECT c.name AS category, COUNT(fc.film_id) AS num_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

-- ¿Qué actor ha aparecido en la mayoría de las películas? Sugerencia: Puedes crear unir entre las tablas "actor" y "actor de película" y contar el número de veces que aparece un actor:
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS num_films_appeared
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY num_films_appeared DESC
LIMIT 1;

-- ¿Quién es el cliente más activo (el cliente que ha alquilado la mayoría de las películas)? Sugerencia: Utiliza una unión adecuada entre las tablas "cliente" y "alquiler" y cuenta el rental_id para cada cliente:
SELECT c.first_name, c.last_name, COUNT(r.rental_id) AS num_rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY num_rentals DESC
LIMIT 1;


-- Bonus: ¿Cuál es la película más alquilada? (La respuesta es "Hermandad de cubo").
-- Esta consulta podría requerir el uso de más de una declaración de unión. Inténtalo. Hablaremos sobre consultas con múltiples declaraciones de unión más adelante en las lecciones.
-- Sugerencia: Puedes usar uniones entre tres tablas - "Película", "Inventario" y "Alquiler" y contar los ids de alquiler para cada película
SELECT f.title AS most_rented_film, COUNT(*) AS num_rentals
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY num_rentals DESC
LIMIT 1;



