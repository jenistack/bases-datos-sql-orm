from setup import session, Usuario

# Crear usuarios
usuario1 = Usuario(nombre="Alice", edad=30)

# Agregar usuarios a la sesión
session.add(usuario1)

# Confirmar los cambios
session.commit()

# Verificar que los usuarios se hayan agregado correctamente
usuarios = session.query(Usuario).all()
for usuario in usuarios:
    print(f"Nombre: {usuario.nombre}, Edad: {usuario.edad}")

# Agregar múltiples usuarios 
usuarios_multiples = [
    Usuario(nombre="Bob", edad=25),
    Usuario(nombre="Charlie", edad=35),
    Usuario(nombre="Diana", edad=28)
]

session.add_all(usuarios_multiples)
session.commit()

# Verificar que los usuarios se hayan agregado correctamente
usuarios = session.query(Usuario).all()
for usuario in usuarios:
    print(f"Nombre: {usuario.nombre}, Edad: {usuario.edad}")