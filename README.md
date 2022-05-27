# M3_Sprint
## Sprint final módulo 3
### Integrantes
* [Miguel Lucero](https://github.com/miguellucero123)
* [Pamela Correa](https://github.com/Pame-b182)
* [Nelson Medel](https://github.com/chinomedel)
* [Sebastián Muñoz](https://github.com/SebMunz)



---------------

### Modelo relacional
<img src="https://user-images.githubusercontent.com/104586558/170759408-5714983f-e07f-4a5f-a999-56f44b70c88e.jpeg" width="90%"></img> 

<strong>Explicación Modelo Entidad Relación</strong>

Para este modelo se consideraron 3 entidades fuertes, 1 débil y 2 compuestas
Fuertes: Proveedor, Producto y Cliente
Débil: contacto_proveedor
Compuestas: proveedor_producto y compra_venta

En el proceso de normalización de la entidad proveedor nos dimos cuentas que podía tener mas de un teléfono de contacto, por esta razón se decidió crear un tabla (contacto_proveedor) que almacenara los teléfonos de cada proveedor, asociándolas por el Rut del mismo.

En relación con la entidad producto y con la idea de que un proveedor podía, en el futuro, tener más de una categoría y el producto tener más de un proveedor, se decidió crear una tabla intermedia (compuesta) que relacionara los productos con los proveedores.

Respecto de la entidad cliente y su relación con los productos, se hizo necesaria una tabla intermedia que almacenará todas las compras de los clientes con sus respectivos productos.

<strong>Transformación</strong>

Se realiza el diagrama relación-entidad con las siguientes categorías:

Primera tabla:

•	contacto_proveedor

id_contacto (llave primaria), RUT, telefono, recepcionista, 
Relacionamos la primera tabla (contacto_proveedor) con la segunda tabla (proveedor) mediante el RUT 

Segunda tabla:

•	proveedor

RUT (llave primaria), nombre_corporativo, representante_legal, categoria_producto, Email
Relacionamos la segunda tabla (proveedor) con la tercera tabla (proveedor_producto) mediante el RUT 

Tercera tabla:

•	Proveedor_producto

Id_prpv (llave primaria), RUT, SKU
Relacionamos la tercera tabla (proveedor_producto) con la cuarta tabla (producto) mediante el SKU

Cuarta tabla:

•	Producto

SKU (llave primaria), nombre, precio, categoría
Relacionamos la cuarta tabla (producto) con la quinta tabla (compra_venta) mediante el SKU

Quinta tabla:

•	Compra_venta

Id_venta (llave primaria), SKU, id_cliente
Relacionamos la quinta tabla (compra_venta) con la sexta tabla (Cliente) mediante el SKU
Sexta tabla:
Cliente
id_cliente (llave primaria), Nombre, Apellido, dirección

