-- ============================================================================
-- Archivo: 02-consultas-y-ejercicios-base.sql
-- Tema: Consultas fundamentales, filtros, agrupaciones y uniones
-- Descripción: Extracción de información mediante SELECT, WHERE, ORDER BY, 
--              funciones de agregación (GROUP BY, HAVING) y consultas multitabla (JOIN).
-- Motor: MySQL
-- ============================================================================



USE lectura;

# Contar el número de libros registrados en la base de datos.
SELECT * FROM book;
SELECT COUNT(book_id) FROM book;

# Contar cuántos libros aún no han sido devueltos (es decir, libros que no tienen fecha de devolución).
SELECT return_date FROM book_loan;
SELECT COUNT(loan_id) FROM book_loan WHERE return_date IS NULL;

# Para cada género, muestre el nombre del género y el número de libros de ese género.
SELECT genre,COUNT(genre) AS total FROM book GROUP BY genre;

# Para cada país, muestre su nombre y el número de autores asociados a él.
SELECT country, COUNT(author_name) AS total_autores FROM author GROUP BY country;

# Para cada género, muestre cuatro columnas: el nombre del género, el número mínimo y máximo de páginas de los libros de ese género, 
# y el difference entre el mayor y el menor número de páginas de cada libro.
SELECT 
	genre AS genero, 
	MIN(pages) AS minimo_paginas, 
	MAX(pages) AS maximo, 
    MAX(pages)-MIN(pages) AS diferencia
FROM book 
GROUP BY genre;

# Para cada género, muestre el número medio de páginas de todos los libros de ese género. Sólo muestre los géneros en los que el 
# libro medio tiene más de 250 páginas. Nombre la columna de páginas promedio avg_pages.
SELECT
	genre,
    AVG(pages) AS avg_pages
FROM book
GROUP BY genre
HAVING AVG(pages)>250;

# Muestre el año medio de publicación para cada género de libros. Redondee el año a un número entero. 
# Muestre sólo los géneros cuyo año medio de publicación sea posterior a 1940.
SELECT
	genre,
    ROUND(AVG(publication_year)) AS año_medio
FROM book 
GROUP BY genre
HAVING ROUND(AVG(publication_year))>1940;

# Para los libros que han sido escritos por más de un autor, muestre el título de cada libro y el número de autores.
SELECT 
title,
COUNT(author_id) AS 'numero autores'
FROM book b
JOIN book_author ba
ON b.book_id=ba.book_id
GROUP BY b.book_id
HAVING COUNT(author_id)>1;

# Para cada libro, muestre su title y la fecha más reciente en que fue prestado. Nombre la segunda columna last_loaned. 
# Muestre NULL en la segunda columna para todos los libros que nunca han sido prestados.
SELECT * FROM book_loan;
SELECT 
book.title,
MAX(book_loan.loan_date) AS last_loaned
FROM book 
LEFT JOIN book_loan 
ON book.book_id=book_loan.book_id
GROUP BY 
book.book_id,
book.title;

# Muestre cuántos préstamos de libros se emitieron cada mes de cada año. Muestre tres columnas:
# La parte del año y del mes de loan_date como números en las dos primeras columnas. Nómbralas loan_year y loan_month
# Una columna contando cuántos libros se prestaron ese mes.
# Ordena el resultado por el año y luego por el mes, mostrando primero las fechas más antiguas.
SELECT
  EXTRACT(YEAR FROM loan_date) AS loan_year,
  EXTRACT(MONTH FROM loan_date) AS loan_month,
  COUNT(loan_id) AS cantidad
FROM book_loan
GROUP BY
  EXTRACT(MONTH FROM loan_date),
  EXTRACT(YEAR FROM loan_date)
ORDER BY
  loan_year,
  loan_month;
  
# Para cada libro, muestre su title, el número de veces que ha sido prestado y el número de usuarios diferentes que 
# han tomado prestado el libro. Nombra las dos últimas columnas times_loaned y different_patrons.
SELECT 
title,
COUNT(loan_id) AS times_loaned,
COUNT(DISTINCT patron_id) AS different_patrons
FROM book b
LEFT JOIN book_loan bl
ON b.book_id=bl.book_id
GROUP BY 
b.title,
b.book_id;

# Para cada cliente, muestre su nombre y la cantidad de libros que tiene (tenían) atrasados 
# (es decir, con fecha de devolución posterior a la fecha de vencimiento).
SELECT * FROM book_loan;
SELECT * FROM patron;
SELECT 
patron_name,
COUNT(book_id) AS 'cantidad atrasados'
FROM patron p
LEFT JOIN book_loan bl
ON p.patron_id=bl.patron_id AND return_date>due_date
GROUP BY 
p.patron_id,
patron_name;

# Para cada género, muestre su nombre y el número medio de autores que tienen los libros de ese género. 
# Nombra la segunda columna average_authors_per_book
SELECT * FROM book_author;
SELECT * FROM book;
SELECT
  genre,
  AVG(author_count) AS average_authors_per_book
FROM (
  SELECT
    book_id,
    COUNT(author_id) AS author_count
  FROM book_author
  GROUP BY book_id) AS na
  JOIN book b
    ON na.book_id = b.book_id
  GROUP BY genre;

# Para cada cliente, muestre su nombre y el número total de páginas que ha leído 
# (es decir, el número de páginas de todos los libros que ha tomado prestados). 
# Suponemos que han leído todos los libros. Incluya todos los libros, incluso los que aún no han devuelto.
# Mostrar sólo los resultados de los usuarios que hayan leído más de 1.000 páginas.
SELECT
  patron_name,
  SUM(pages) AS total_pages_read
FROM book b
JOIN book_loan bl
  ON b.book_id = bl.book_id
JOIN patron p
  ON p.patron_id = bl.patron_id
GROUP BY
  p.patron_id,
  p.patron_name
HAVING SUM(pages) > 300;

# Mostrar el número total de usuarios que nunca han tomado libros prestados.
SELECT COUNT(p.patron_id) AS cantidad
FROM patron p
WHERE NOT EXISTS (
  SELECT * FROM book_loan
  WHERE patron_id = p.patron_id
);

# Para cada autor, muestre cuántos usuarios diferentes han tomado prestado su libro.
SELECT 
author_name,
COUNT(DISTINCT patron_id) AS cantidad_usuarios
FROM book_author ba
JOIN book_loan bl
ON ba.book_id = bl.book_id
JOIN author a
ON ba.author_id=a.author_id
GROUP BY author_name;

# Encuentre el libro o libros más antiguos de la base de datos (es decir, el libro o libros con el publication_year más antiguo). 
# Muestre sólo dos columnas: title y publication_year. Recuerde que puede haber más de un libro con el año de publicación más antiguo.
SELECT
  title,
  publication_year
FROM book
WHERE publication_year = (
  SELECT MIN(publication_year)
  FROM book
);

# Encuentre los nombres de todos los usuarios que han tomado prestados un número de libros superior a la media. 
# Indique el número de libros prestados junto con su nombre.
SELECT
  patron_name,
  COUNT(*) AS loan_count
FROM patron
JOIN book_loan
  ON patron.patron_id = book_loan.patron_id
GROUP BY patron_name
HAVING COUNT(*) > (
  SELECT COUNT(*)
  FROM book_loan
) / (
  SELECT COUNT(*)
  FROM patron
);

# Encontrar el autor que escribió más libros.
WITH authors_books_count AS (
  SELECT
    author_id,
    COUNT(*) AS book_count
  FROM book_author
  GROUP BY author_id
)
SELECT
  author_name,
  book_count
FROM author
JOIN authors_books_count abc
  ON author.author_id = abc.author_id
WHERE book_count = (
  SELECT MAX(book_count)
  FROM authors_books_count
);