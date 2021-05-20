/* 		Ejercicios 3
		Sesion 3
    Curso BEDU - Data Science
    Norma Arrazola Herrera
    	18 Mayo 2021
*/

/*Ejercicios Sesión 3
1. Objetivos 🎯
Aplicar los conceptos adquiridos durante la sesión.
2. Requisitos 📋
MySQL Workbench instalado.
3. Desarrollo 🚀
Todos los ejercicios debes hacerlos usando la base classicmodels.
Todas las consultas que realices deberás mantenerlas dentro del editor de textos de MySQL Workbench. 
Al finalizar, guarda este archivo, llendo al menú File > Save script. 
Recuerda añadir a todos los nombres te tus vistas el sufijo con tu identificador.*/

USE classicmodels;
/**** Para estas consultas usa INNER JOIN ****/

#1. Obtén la cantidad de productos de cada orden.
SELECT o.orderNumber, d.quantityOrdered
FROM orders o
INNER JOIN orderdetails d
  ON o.orderNumber = d.orderNumber;

#2. Obtén el número de orden, estado y costo total de cada orden.
SELECT o.orderNumber, o.status, p.amount
FROM orders o
INNER JOIN payments p 
	ON o.customerNumber = p.customerNumber;

#3. Obtén el número de orden, fecha de orden, línea de orden, nombre del producto, cantidad ordenada y precio de cada pieza.
SELECT o.orderNumber, o.orderDate, p.productLine, p.productName, d.quantityOrdered, d.priceEach
FROM orders o
INNER JOIN orderdetails d
	ON o.orderNumber = d.orderNumber
    INNER JOIN products p
		ON d.productCode = p.productCode;

#4. Obtén el número de orden, nombre del producto, el precio sugerido de fábrica (msrp) y precio de cada pieza.
SELECT o.orderNumber, o.priceEach, p.productName, p.buyPrice, p.MSRP
FROM orderdetails o
INNER JOIN products p
	ON o.productCode = p.productCode;

/**** Para estas consultas usa LEFT JOIN ****/
#5. Obtén el número de cliente, nombre de cliente, número de orden y estado de cada orden hecha por cada cliente. 
	-- ¿De qué nos sirve hacer LEFT JOIN en lugar de JOIN?
SELECT c.customerNumber, c.customerName, o.orderNumber, o.status
FROM customers c
LEFT JOIN orders o
	ON c.customerNumber = o.customerNumber;
    /*El Left Join nos trae todos los registros de la tabla izquierda "customers" y lo que no encuentra en la tabla orders
    lo rellena con NULLS, mientras que el JOIN los registros que no aparecen en ambas tablas no se presentan en la nueva tabla.
    Trayendo asi solo lo que existe y coincide en ambas tablas dado nuestra llave usada*/

#6. Obtén los clientes que no tienen una orden asociada.
SELECT c.customerNumber, c.customerName, o.orderNumber, o.status
FROM customers c
LEFT JOIN orders o
	ON c.customerNumber = o.customerNumber
WHERE o.orderNumber IS NULL; 

#7. Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir,
# los clientes asociados a cada empleado.
SELECT e.employeeNumber, e.lastName, e.firstName, c.customerName, p.checkNumber, p.amount
FROM employees e
LEFT JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
    LEFT JOIN payments p
		ON c.customerNumber = p.customerNumber;

#Para estas consultas usa RIGHT JOIN
#9. Repite los ejercicios 5 a 7 usando RIGHT JOIN. ¿Representan lo mismo? Explica las diferencias en un comentario. Para poner comentarios usa --.*/
#9.5. Obtén el número de cliente, nombre de cliente, número de orden y estado de cada orden hecha por cada cliente. 
SELECT c.customerNumber, c.customerName, o.orderNumber, o.status
FROM customers c
RIGHT JOIN orders o
	ON c.customerNumber = o.customerNumber;
-- En este caso la tabla derecha "orders" es traida y los valores faltantes en customers se rellenarian con NULL
-- Sin embargo al hacer el ejercico 6 con un right join nos damos cuenta que no haz ordenes vacias ya que 
-- La tabla dominante es la de ordenes asi que los registros sin una orden no seran traidos.

#6. Obtén los clientes que no tienen una orden asociada.
SELECT c.customerNumber, c.customerName, o.orderNumber, o.status
FROM customers c
RIGHT JOIN orders o
	ON c.customerNumber = o.customerNumber
WHERE o.orderNumber IS NULL; 

#7. Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir,
# los clientes asociados a cada empleado.
SELECT e.employeeNumber, e.lastName, e.firstName, c.customerName, p.checkNumber, p.amount
FROM employees e
RIGHT JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
    RIGHT JOIN payments p
		ON c.customerNumber = p.customerNumber;
-- En este caso la tabla con el LEFT JOIN trae 283 registros ya que aunque algun empleado no haya vendido nada existira en la tabla.
-- Sin embargo la tabla del RIGHT JOIN trae 273 registros ya que solo existiran los registors de empleados en los cuales haya un cliente asociado.        

#10. Escoge 3 consultas de los ejercicios anteriores, crea una vista y escribe una consulta para cada una.
#10.7
CREATE VIEW Ejercicios_Sesion3_10_1_151 AS 
(SELECT e.employeeNumber, e.lastName, e.firstName, c.customerName, p.checkNumber, p.amount
FROM employees e
RIGHT JOIN customers c
	ON e.employeeNumber = c.salesRepEmployeeNumber
    RIGHT JOIN payments p
		ON c.customerNumber = p.customerNumber);

-- Buscar al empleado con mas clientes
SELECT employeeNumber, lastName, firstName, count(*) AS customers
FROM Ejercicios_Sesion3_10_1_151
GROUP BY employeeNumber
ORDER BY customers DESC
LIMIT 1;

#10.3. Obtén el número de orden, fecha de orden, línea de orden, nombre del producto, cantidad ordenada y precio de cada pieza.
CREATE VIEW Ejercicios_Sesion3_10_2_151 AS 
(SELECT o.orderNumber, o.orderDate, p.productLine, p.productName, d.quantityOrdered, d.priceEach
FROM orders o
INNER JOIN orderdetails d
	ON o.orderNumber = d.orderNumber
    INNER JOIN products p
		ON d.productCode = p.productCode);

-- Conocer los max, min y promedio de cantidades ordenadas asi como los precios
SELECT max(quantityOrdered), min(quantityOrdered), avg(quantityOrdered), max(priceEach), min(priceEach)
FROM Ejercicios_Sesion3_10_2_151;

#10.2. Obtén el número de orden, estado y costo total de cada orden.
CREATE VIEW Ejercicios_Sesion3_10_3_151_ AS 
(SELECT o.orderNumber, o.status, p.amount
FROM orders o
INNER JOIN payments p 
	ON o.customerNumber = p.customerNumber);

-- Consultar cuantas ordenes hay por estatus y ordenarlas del mayor estatus al menor
SELECT status, count(*) AS ordenes
FROM Ejercicios_Sesion3_10_3_151_
GROUP BY status
ORDER BY ordenes DESC;


/* 		Retos 3
		Sesion 3
    Curso BEDU - Data Science
    Norma Arrazola Herrera
    	18 Mayo 2021
*/

/**********		RETO 1 		**********/
/*Reto 1: Agrupamientos y subconsultas
1. Objetivos 🎯
Escribir consultas que permitan responder a algunas preguntas.
2. Requisitos 📋
MySQL Workbench instalado.
3. Desarrollo 🚀
Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.*/
USE tienda;

#¿Cuál es el nombre de los empleados que realizaron cada venta?
SHOW KEYS FROM venta;
SHOW KEYS FROM empleado;
SELECT *
FROM venta AS v
LEFT JOIN empleado AS e
  ON e.id_empleado = v.id_empleado;

#¿Cuál es el nombre de los artículos que se han vendido?
SELECT *
FROM venta AS v
LEFT JOIN articulo AS a
  ON v.id_articulo = a.id_articulo;

#¿Cuál es el total de cada venta?
SELECT 
    *
FROM
    venta AS v
        LEFT JOIN
    articulo AS a ON v.id_articulo = a.id_articulo;
  

/**********		RETO 2 		**********/
/*Reto 2: Definición de vistas
1. Objetivos 🎯
Definir vistas sobre algunas consultas.
2. Requisitos 📋
MySQL Workbench instalado.
3. Desarrollo 🚀

⚠️ IMPORTANTE
Para este reto necesitarás un identificador único. Tu identificador serán los últimos tres dígitos de tu número de celular.
 Por ejemplo, si tu número es: 5512345678 tu identificador debe ser 678. ¡No lo olvides!
Te pedimos esto para que todos puedan realizar los ejemplos y retos.*/

#Usando la base de datos tienda, define las siguientes vistas que permitan obtener la siguiente información.
#AÑADE A TODOS LOS NOMBRES DE TUS VISTAS EL SUFIJO _<tu identificador>. Por ejemplo mi_vista_hermosa_123.
-
#Obtener el puesto de un empleado.
CREATE VIEW reto2_1_s3_151_ AS
(SELECT p.nombre, e.nombre AS empleado, e.apellido_paterno, e.id_puesto
FROM empleado e
JOIN puesto p
  ON e.id_puesto = p.id_puesto);
  
SELECT *
FROM reto2_1_s3_151_;

#Saber qué artículos ha vendido cada empleado.
CREATE VIEW reto2_2_s3_151_ AS
(
SELECT v.id_venta, v.id_articulo, a.nombre AS articulo, e.nombre AS empleado, e.apellido_paterno, e.id_puesto, e.id_empleado
FROM empleado e
LEFT JOIN venta v
  ON e.id_empleado = v.id_venta
LEFT JOIN articulo a
	ON v.id_articulo = a.id_articulo);

SELECT *
FROM reto2_2_s3_151_;

#Saber qué puesto ha tenido más ventas.*/
CREATE VIEW reto2_3_s3_151_ AS
(SELECT v.id_venta, e.id_puesto, e.id_empleado, p.nombre
FROM empleado e
LEFT JOIN venta v
  ON e.id_empleado = v.id_venta
LEFT JOIN puesto p
	ON p.id_puesto = e.id_puesto);
    
SELECT nombre, count(*) AS ventas
FROM reto2_3_s3_151_
GROUP BY nombre
ORDER BY ventas DESC
LIMIT 1;
