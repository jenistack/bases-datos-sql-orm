-- ============================================================================
-- Archivo: 01-ddl-creacion-y-carga-datos.sql
-- Tema: Lenguaje de Definición de Datos (DDL) y carga inicial (DML)
-- Descripción: Creación de bases de datos, tablas, tipos de datos, claves 
--              primarias/foráneas (PRIMARY/FOREIGN KEY) e inserción de registros.
-- Motor: MySQL
-- ============================================================================



CREATE DATABASE lectura;
USE lectura;
CREATE TABLE book (
	book_id INT PRIMARY KEY,
    title VARCHAR(200),
    publication_year INT NULL,
    genre VARCHAR(200) NULL,
    pages INT 
    );

CREATE TABLE author (
	author_id INT PRIMARY KEY,
    author_name VARCHAR(100),
    country VARCHAR(100) NULL
    );

CREATE TABLE patron (
	patron_id INT PRIMARY KEY,
    patron_name VARCHAR(100),
    registration_date DATE 
    );

CREATE TABLE book_author (
	book_author_id INT PRIMARY KEY,
    author_id INT,
    book_id INT, 
    FOREIGN KEY (author_id) REFERENCES author(author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
    );

CREATE TABLE book_loan (
    loan_id INT PRIMARY KEY NOT NULL,
    book_id INT NOT NULL,
    patron_id INT NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    CONSTRAINT fk_loan_book FOREIGN KEY (book_id) REFERENCES book(book_id),
    CONSTRAINT fk_loan_patron FOREIGN KEY (patron_id) REFERENCES patron(patron_id)
);

INSERT IGNORE INTO book (
book_id,title,publication_year,genre,pages
) VALUES 
(1,'1984',1949,'Political Fiction',328),
(2,'Animal Farm',1945,'Political Fiction',112),
(3,'The Hobbit',1937,'Fantasy',310),
(4,'The Fellowship of the Ring',1954,'Fantasy',423);

SELECT * FROM book;

INSERT IGNORE INTO author (
author_id, author_name, country
) VALUES 
(1,'George Orwell','United Kingdom'),
(2,'J.R.R. Tolkien','United Kingdom'),
(3,'Isaac Asimov','United States'),
(4,'Agatha Christie','United Kingdom');

SELECT * FROM author;

INSERT IGNORE INTO book_author (
book_author_id, author_id, book_id
) VALUES 
(1,1,1),
(2,1,2),
(3,2,3),
(4,2,4);

SELECT * FROM book_author;

INSERT IGNORE INTO patron (
patron_id, patron_name, registration_date
) VALUES 
(1,'Alice Johnson','2024-01-15'),
(2,'Bob Smith','2024-03-22'),
(3,'Charlie Brown','2024-05-10'),
(4,'David Wilson','2024-06-01');

SELECT * FROM patron;

INSERT IGNORE INTO book_loan (
loan_id,book_id,patron_id,loan_date,due_date,return_date
) VALUES 
(1,1,1,'2024-01-20','2024-02-20','2024-02-15'),
(2,2,1,'2024-02-01','2024-03-01','2024-02-28'),
(3,3,2,'2024-02-10','2024-03-10','2024-03-05'),
(4,4,3,'2024-03-15','2024-04-10','2024-04-15');

SELECT * FROM book_loan;