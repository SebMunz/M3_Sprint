
create schema TeLoVendo_s3; -- Se crea la base de datos "TeLoVendo_s3".

/* CREATE USER 'Admin_TLV'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON telovendo_s3 TO 'Admin_TLV'@'localhost'
FLUSH PRIVILEGES; */ -- Se crea el usuario "admin_TLV" con todos los privilegios sobre la base "TeLoVendo_s3" a través de la terminal "My SQl Command Line Client".

use Telovendo_s3; -- Se deja estipulado que se usará esta base de datos en específico.

create table proveedor (
RUT int unsigned not null primary key,
nombre_corporativo varchar(50) not null,
representante_legal varchar(50) not null,
categoria_producto varchar(50) not null,
email varchar(40) not null); -- Se crea la tabla "proveedor" con los atributos solicitados.

create table contacto_proveedor (
RUT int unsigned not null,
telefono int unsigned not null,
recepcionista varchar(50) not null,
foreign key (RUT) references proveedor(RUT)); -- Se crea la tabla "contacto_proveedor" para almacenar los teléfonos de cada proveedor, asociado a su RUT.

create table producto (
SKU varchar(12) not null primary key,
nombre varchar(25) not null,
precio int unsigned not null,
categoria varchar(40) not null,
color varchar(20) not null,
stock int unsigned not null); -- Se crea la tabla "producto" con los atributos solicitados.

create table producto_proveedor (
RUT int unsigned not null,
SKU varchar(12) not null,
foreign key (RUT) references proveedor(RUT), foreign key (SKU) references producto(SKU)); -- Se crea la tabla intermedia "producto_proveedor" que relacione los proveedores con los productos.

create table cliente (
id_cliente int unsigned not null auto_increment primary key,
nombre varchar(30) not null,
apellido varchar(30) not null,
direccion varchar(60) not null); -- Se crea la tabla "cliente" con los atributos solicitados.

create table compra_venta (
SKU varchar(12) not null,
id_cliente int unsigned not null,
foreign key (SKU) references producto(SKU), foreign key (id_cliente) references cliente(id_cliente)); -- Se crea la tabla intermedia "compra_venta" que almacene las compras de los clientes y sus respectivos productos.

insert into proveedor (RUT, nombre_corporativo, representante_legal, categoria_producto, email)
values (16408529, 'Mayer Group', 'Joela Candlin', 'Notebook', 'jcandlin0@hc360.com'),
(19664628, 'Wunsch Inc', 'Sandro Boughey', 'Videojuegos', 'sboughey1@surveymonkey.com'),
(17684370, 'Denesik Inc', 'Blondy Lukesch', 'Televisión', 'blukesch2@wikipedia.org'),
(16106672, 'Franecki, Dach and Bechtelar', 'Clevey Denial', 'Celulares', 'cdenial3@stanford.edu'),
(19341684, 'Hammes LLC', 'Burk Semiraz', 'Audio', 'bsemiraz4@slate.com'); -- Se insertan 5 registros a la tabla "proveedor".

insert into cliente (id_cliente, nombre, apellido, direccion)
values (1, 'Cristabel', 'Dillimore', '396 Moland Plaza'),
(2, 'Yves', 'Dyers', '95018 Elmside Drive'),
(3, 'Nomi', 'Leitche', '37 Hallows Street'),
(4, 'Noe', 'Pendred', '946 Alpine Alley'),
(5, 'Dolley', 'Fust', '90559 Mayer Road'); -- Se insertan 5 registros a la tabla "cliente".

insert into producto (SKU, nombre, precio, categoria, color, stock)
values ('A8751B119863', 'Celular Samsung', '94990', 'Celulares', 'Violeta', 7),
('A6739B414865', 'Disco Duro', '86990', 'Notebook', 'Verdeagua', 72),
('A5576B513911', 'Mario Car', '10990', 'Videojuegos', 'Morado', 79),
('A8060B442883', 'Mouse', '07990', 'Notebook', 'Rojo', 53),
('A0201B802979', 'Super mario', '30990', 'Videojuegos', 'Turquesa', 12),
('A2835B514698', 'Parlante', '13990', 'Audio', 'Violeta', 79),
('A1544B734556', 'Audífonos', '05990', 'Audio', 'Rojo', 67),
('A8493B237377', 'Celular Moto', '71990', 'Celulares', 'Rosado', 58),
('A3881B740193', 'Smarttv 10', '99990', 'Television', 'Fucsia', 46),
('A9058B978748', 'Celular Xiaomi', '90990', 'Celulares', 'Verde', 87); -- Se insertan 10 registros a la tabla "producto".

insert into contacto_proveedor(RUT, telefono, recepcionista)
values
('16106672','951366598','José Muñoz'),
('16408529','987878787', 'Analia Fuentes'),
('17684370','996969696', 'Rosario Castro'),
('19341684','952545663','Joaquín Diaz'),
('19664628','932659845','Raul Soto'),
('16106672','951366556','Pablo González'),
('16408529','987878798', 'Jessica Fuentes'),
('17684370','996969699', 'Marina  Castro'),
('19341684','952545664','Pablo Diaz'),
('19664628','932659875','Miguel Norambuena'); -- Se insertan 10 registros a la tabla "contacto_proveedor". 

insert into producto_proveedor (SKU, RUT)
values
('A0201B802979','19664628'),
('A1544B734556','19341684'),
('A2835B514698','19341684'),
('A3881B740193','17684370'),
('A5576B513911','19664628'),
('A6739B414865','16408529'),
('A8060B442883','16408529'),
('A8493B237377','16106672'); -- Se insertan 8 registros con la relación producto (a través de su SKU) y proovedor (a través de su RUT).

SELECT categoria, COUNT(*) AS TOP
FROM producto
GROUP BY categoria
ORDER BY TOP DESC
LIMIT 1; /* La categoría de productos que más se repite es la de "celulares". Esta se repite 3 veces. */

select nombre, stock
from producto
where stock >= (select avg(stock) from producto)
group by nombre
order by stock desc; /* Los 6 productos que tienen un mayor stock o por sobre el promedio son: Celular Xiaomi (87u), Parlante(79u),
Mario Car (79u), Disco Duro (72u), Audífonos (67u) y Celular Moto (58u). */

SELECT color, COUNT(*) AS TOP
FROM producto
GROUP BY color
ORDER BY TOP DESC
LIMIT 1; /* El color de producto que es más común en la tienda es el rojo. */

select  p1.nombre_corporativo, sum(p.stock) as stock from producto as p
	inner join proveedor_producto pp on (p.SKU = pp.SKU)
	inner join proveedor p1 on (p1.RUT = pp.RUT)
group by p1.nombre_corporativo
order by stock asc
limit 2; /* los 2 proveedores con menor stock de productos son: Denesik Inc (46u) y Franecki y Dach and Bechtelar (58u).*/

select categoria, count(categoria) as cantidad from producto
group by categoria
order by cantidad desc
limit 1; /* Se determina que la categoría de productos más popular es la de "Celulares". */

update producto
set categoria = 'Electrónica y Computación'
where SKU in ('A8493B237377','A8751B119863','A9058B978748'); /* Se cambia el nombre de la categoría más popular (Celulares) 
por "Electrónica y Computación" en la tabla "producto". */

update proveedor 
set categoria_producto = 'Electrónica y Computación'
where RUT = 16106672; /* Se cambia el nombre de la categoría más popular (Celulares) 
por "Electrónica y Computación" en la tabla "proveedor". */
