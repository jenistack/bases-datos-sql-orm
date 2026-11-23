from setup import session, Usuario
from sqlalchemy import func

# Leer usuarios
try:
    usuarios = session.query(Usuario).filter(Usuario.edad > 25, Usuario.edad < 33).all()
    for usuario in usuarios:
        print(f"Nombre: {usuario.nombre}, Edad: {usuario.edad}")
except Exception as e:
    print(f"Error al leer usuarios: {e}")

try:
    usuarios=session.query(Usuario).filter(func.length(Usuario.nombre) < 6).all()
    for usuario in usuarios:
        print(f"Nombre: {usuario.nombre}, Edad: {usuario.edad}")
except Exception as e:
    print(f"Error al leer usuarios: {e}")


# Generar informe con el total de usuarios y el promedio de edades
try:
    total_usuarios = session.query(Usuario).count()
    promedio_edades = session.query(Usuario.edad).all()
    promedio_edades=sum(edad[0] for edad in promedio_edades)/total_usuarios
    print(f"Total de usuarios: {total_usuarios}, Promedio de edades: {promedio_edades:.2f}")
except Exception as e:
    print(f"Error al generar informe: {e}")