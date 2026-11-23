# Ejercicio Integrado: Sistema de Gestión de Usuarios
# El objetivo de este ejercicio es implementar un sistema  de gestión de usuarios 
# que permita realizar operaciones CRUD (Crear (CREATE), Leer (READ), Actualizar (UPDATE), Eliminar (DELETE))

# 1. CREAR USUARIOS: Permitir agregar uno o más con validaciones básicas (por ejemplo, nombre de usuario único, edad).
# 2. LISTAR USUARIOS: Mostrar todos los usuarios o filtrar por criterios específicos (por ejemplo, por nombre, edad).
# 3. ACTUALIZAR USUARIOS: Permitir modificar la información de un usuario existente.
# 4. ELIMINAR USUARIOS: Permitir eliminar un usuario específico o según criterios.
# 5. VALIDACIONES: Asegurarse de que los datos sean válidos antes de guardarlos en la base de datos.
# 6. REPORTES: Generar un informe con el total de usuarios y el promedio de edades.


from sqlalchemy import create_engine,Column,Integer,String
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import os
from dotenv import load_dotenv


load_dotenv()


# URL de la base de datos
DATABASE_PASSWORD = os.getenv("DB_PASSWORD")
DATABASE_URL = f"mysql+pymysql://root:{DATABASE_PASSWORD}@localhost:3306/gestion_usuarios"

# Crear el motor de la base de datos
engine = create_engine(DATABASE_URL, echo=True)

# Clase base para definir los modelos
Base = declarative_base()

# Configuración de inicio de la sesión
Session = sessionmaker(bind=engine)

# Abrir la sesión
session = Session()

# Definición de un modelo
class Usuario(Base):
    __tablename__ = 'usuarios'

    id = Column(Integer, primary_key=True)
    nombre = Column(String(100))
    edad = Column(Integer)

# Crear tabla
try:
    Base.metadata.create_all(engine)
    print("Tabla 'usuarios' creada exitosamente.")
except Exception as e:
    print(f"Error al crear la tabla: {e}")