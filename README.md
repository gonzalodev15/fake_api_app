# fake_api_app
App for testing api's in Flutter

# Modelos de Datos
Product: Representa un producto con id, title, description, price, category, image y rating.

ProductRating: Representa el rating de cada producto. Contiene el rate y count.

Category: Representa una categoría con name.

User: Representa un usuario con id, username y email.

# Solicitudes a la API
fetchProduct(int id): Solicita los datos de un Producto en específico por el id que se pasa como parámetro, devolviendo un objeto de tipo Product.

fetchProducts: Solicita los datos de productos y los transforma en una lista de objetos Product.

fetchCategories: Solicita los datos de categorías y los transforma en una lista de objetos Category.

fetchUsers: Solicita los datos de usuarios y los transforma en una lista de objetos User.

# Control de Errores
Se utiliza Either para manejar errores en las solicitudes a la API. En caso de éxito, devuelve un Right con los datos, y en caso de error, devuelve un Left con un mensaje de error.
