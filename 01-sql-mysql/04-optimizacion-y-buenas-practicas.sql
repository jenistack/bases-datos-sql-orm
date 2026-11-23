-- ============================================================================
-- Archivo: 04-optimizacion-y-buenas-practicas.sql
-- Tema: Optimización de rendimiento y estándares profesionales en SQL
-- Descripción: Creación y uso de índices (INDEX), análisis de consultas y 
--              aplicación de buenas prácticas para mejorar tiempos de respuesta.
-- Motor: MySQL
-- ============================================================================



USE Sakila;
#Ejercicio 1 -> Index B-Tree -  Busquedas avanzadas de peliculas por release_year and duration (length)
#Crear indice compuesto B-Tree (release_year, length)
CREATE INDEX idx_film_year_lenght ON film(release_year,length);

#Consulta para peliculas de los 2000s con duracioncustomer > 120min
EXPLAIN ANALYZE
SELECT title, release_year, length 
FROM film 
WHERE release_year = 2006
AND length BETWEEN 120 AND 180;

#Ejercicio 2 -> Index HASH - Busqueda exacta de clientes por email (0.127 -> 0.02) 
#Crear indice 
CREATE INDEX idx_customer_email ON customer (email);

#Consulta de login (siempre usa "=")
EXPLAIN ANALYZE
SELECT * FROM customer 
WHERE email = "KATHLEEN.ADAMS@sakilacustomer.org";

#Ejercicio 3 _ Index FUll text _ Busqueda en descripcion de peliculas 

# Busqueda avanzada : peliculas sobre "drama" con "amor" pero sin "muerte"
CREATE FULLTEXT INDEX idx_film_description ON  film(description);
EXPLAIN ANALYZE
SELECT title, description
FROM film 
WHERE MATCH (description) 
AGAINST ( '+Drama +Feminist' IN BOOLEAN MODE) ;

#Ejercicio 4 - Indice compuesto - Obtener todas las ventas activas ( no devueltas) de un cliente en especifico ordenado por fecha 

CREATE INDEX  idx_rental_customer_return_date ON rental(customer_id, return_date);

EXPLAIN ANALYZE
SELECT rental_id, rental_date, inventory_id 
FROM rental 
WHERE customer_id = 45 
AND return_date IS NULL 
ORDER BY rental_date DESC;
