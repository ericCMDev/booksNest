# BooksNestApp

Proyecto final de carrera. Aplicación para guardar tu biblioteca personal y realizar seguimiento de tus lecturas.
Hecho en Swift i SwiftUI junto con Firebase como backend.

- Partes implementadas y operativas:
  - Login con usuario y contraseña, login con Facebook y vinculación de ambas cuentas para unificarlas.
    - Hecho con Firebase Auth
  - Añadir libros manualmente (introduciendo información manualmente)
  - Añadir libro escaneándo el código de barras (ISBN) y devolviendo la información mediante API de Google Books.
  - Cambiar estado y ubicación de los libros (pendiente, leído, leyendo, prestado) / (en mi biblioteca / wishlist)
    - Los datos se alojan en Firebase Firestore Database
   - Editar y eliminar libros
  
  TODO:
  - Buscador de libro en internet para añadirlo
  - Mapa integrado para ver librerías cercanas a nuestra ubicación
  
  
