from setup import session, Usuario

try:
    usuarios = session.query(Usuario).filter(Usuario.nombre == "Bob").all()
    for usuario in usuarios:
        session.delete(usuario)
    session.commit()
    print("Usuarios eliminados correctamente.")
except Exception as e:
    print(f"Error al eliminar usuarios: {e}")

# Verificar la eliminación
usuarios = session.query(Usuario).all()
for usuario in usuarios:
    print(f"Nombre: {usuario.nombre}, Edad: {usuario.edad}")