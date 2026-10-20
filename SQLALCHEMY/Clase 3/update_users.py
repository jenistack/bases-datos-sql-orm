from setup import session, Usuario

# Actualizar edad de usuarios
try:
    usuarios = session.query(Usuario).all()
    for usuario in usuarios:
        usuario.edad += 1 # Incrementar la edad en 1
    session.commit()
    print("Edades actualizadas correctamente.")
except Exception as e:
    print(f"Error al actualizar edades: {e}")

# Verificar la actualización    
usuarios = session.query(Usuario).all()
for usuario in usuarios:
    print(f"Nombre: {usuario.nombre}, Edad: {usuario.edad}")    

