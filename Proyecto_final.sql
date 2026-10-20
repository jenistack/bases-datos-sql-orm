CREATE DATABASE biblioteca;
USE biblioteca;
CREATE TABLE libros (
	libro_id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    autor VARCHAR(100) NOT NULL,  
    año_publicacion INT,
    disponible BOOLEAN default TRUE 
    );
    
CREATE TABLE usuarios (
	usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
    );
    
CREATE TABLE prestamos (
	prestamo_id INT AUTO_INCREMENT PRIMARY KEY,
    libro_id INT,
    usuario_id INT,
    fecha_prestamo DATE DEFAULT (CURRENT_DATE),
    fecha_devolucion DATE,
    CONSTRAINT fk_prestamos_libros FOREIGN KEY (libro_id) REFERENCES libros(libro_id),
    CONSTRAINT fk_prestamos_usuarios FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id)
    );
    
INSERT INTO libros(
	titulo,autor,año_publicacion
    ) VALUES
    ('Don Quijote de la Mancha', 'Miguel de Cervantes', 1605),
    ('Cien años de soledad', 'Gabriel García Márquez', 1967),
	('El Señor de los Anillos', ' J.R.R. Tolkien', 1954),
	('Harry Potter y la piedra filosofal', 'J.K. Rowling', 1997),
	('Hamlet', 'William Shakespeare', 1601);
    
INSERT INTO usuarios(
	nombre,email
    ) VALUES
    ('Carlos Gómez', 'carlos@gmail.com'),
	('María López', 'maria@gmail.com'),
	('Juan Pérez', 'juan@gmail.com');

INSERT INTO prestamos(
	libro_id,usuario_id
    ) VALUES
    (2,2),
	(5,3);
    
UPDATE libros SET disponible=FALSE WHERE libro_id IN (2,5);
SELECT * FROM libros;
SELECT * FROM usuarios;

# Libros disponibles (solo los no prestados)
SELECT titulo,autor,año_publicacion FROM libros WHERE disponible=TRUE;

# Préstamos activos (mostrar libro + usuario + fecha).
SELECT 
	l.titulo AS libro,
    u.nombre AS usuario,
    p.fecha_prestamo AS fecha,
    DATEDIFF(CURRENT_DATE,p.fecha_prestamo) AS 'dias prestados'
FROM prestamos p
JOIN libros l ON p.libro_id=l.libro_id
JOIN usuarios u ON p.usuario_id=u.usuario_id
WHERE p.fecha_devolucion IS NULL;

# Crear indice para búsqueda por título
CREATE INDEX idx_titulos ON libros(titulo);
# Consulta optimizada de la búsqueda por título
SELECT * FROM libros WHERE titulo='Hamlet';

# Crear indice para búsqueda por usuario
CREATE INDEX idx_prestamos ON prestamos(usuario_id);
# Consulta optimizada de la búsqueda por usuario
SELECT * FROM usuarios WHERE usuario_id IN (SELECT usuario_id FROM prestamos);

