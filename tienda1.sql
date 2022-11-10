-- 1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre FROM producto;
-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre , precio FROM producto;
-- 3. Lista todas las columnas de la tabla producto.
SELECT * FROM producto;
-- 4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
select nombre, round(precio) from producto; 
-- 5. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT codigo_fabricante FROM producto;
-- 6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrarlos repetidos.
SELECT DISTINCT codigo_fabricante FROM producto;
-- 7. Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre FROM fabricante ORDER BY nombre ASC;
-- 8. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT nombre , precio FROM producto ORDER BY nombre ASC;
SELECT precio , nombre FROM producto ORDER BY precio DESC;
-- 9. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM fabricante LIMIT 5;
-- 10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre , precio FROM producto ORDER BY precio ASC LIMIT 1;
-- Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre , precio FROM producto ORDER BY precio DESC LIMIT 1;
-- 12. Lista el nombre de los productos que tienen un precio menor o igual a $120.
SELECT nombre , precio FROM producto WHERE precio <= 120;
-- 13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
SELECT * FROM producto WHERE precio BETWEEN 60 AND 200;
-- 14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT * FROM producto WHERE codigo_fabricante IN(1,3,5);
-- 15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
SELECT * FROM producto WHERE nombre LIKE "%Portatil%";
-- Consultas Multitabla
-- 1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
SELECT producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre FROM producto INNER JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo;
-- 2 Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
SELECT producto.nombre, producto.precio, fabricante.nombre AS 'nombre fabricante' FROM producto JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo ORDER BY fabricante.nombre ASC ;
-- 3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT producto.nombre, producto.precio, fabricante.nombre AS 'nombre fabricante' FROM producto JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo ORDER BY producto.precio ASC LIMIT 1;
-- 4. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT * , fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE fabricante.nombre LIKE "%Lenovo%";
-- 5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
SELECT * , fabricante.nombre AS "nombre fabrcante" FROM producto JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE producto.precio > 200;
-- 6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard. Utilizando el operador IN.
SELECT * FROM producto JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE fabricante.nombre IN('Asus','Hewlett-Packard');
-- 7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos
-- los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer
-- lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden
-- ascendente)
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE producto.precio>=180 ORDER BY producto.precio DESC ,producto.nombre ASC;
-- Consultas Multitabla
-- 1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los
-- productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos
-- fabricantes que no tienen productos asociados.
SELECT * FROM producto AS p RIGHT JOIN fabricante AS f ON p.codigo_fabricante=f.codigo;
-- 2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT * FROM fabricante AS f LEFT JOIN producto AS p ON p.codigo_fabricante=f.codigo WHERE p.nombre IS NULL;
-- Subconsultas (En la cláusula WHERE)
-- 1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');
-- 2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante=(SELECT codigo FROM fabricante WHERE nombre='Lenovo'));
INSERT INTO producto VALUES(90,'tablet china',559,2);
DELETE FROM producto WHERE codigo=90;
-- 3. Lista el nombre del producto más caro del fabricante Lenovo.
SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante =(SELECT codigo FROM fabricante WHERE codigo = 2));
-- 4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT precio, round(AVG(precio)) AS 'promedio' FROM producto WHERE codigo_fabricante = 1 ;
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus') AND precio > 224;
-- Subconsultas con IN y NOT IN
-- 1. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre FROM fabricante WHERE codigo IN (SELECT codigo_fabricante FROM producto);
-- 2. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre FROM fabricante WHERE codigo NOT IN (SELECT codigo_fabricante FROM producto);
-- Subconsultas (En la cláusula HAVING)
-- 1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.
SELECT fabricante.nombre, COUNT(producto.codigo)
FROM fabricante INNER JOIN producto
ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.codigo
HAVING COUNT(producto.codigo) >= (
    SELECT COUNT(producto.codigo)
    FROM fabricante INNER JOIN producto
    ON fabricante.codigo = producto.codigo_fabricante
    WHERE fabricante.nombre = 'Lenovo');

