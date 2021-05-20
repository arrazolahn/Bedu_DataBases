/* 		Ejercicios 2
		Sesion 2
    Curso BEDU - Data Science
    Norma Arrazola Herrera
    	13 Mayo 2021
*/
    
    USE classicmodels;
    #1. Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre empiece con a.
    SELECT employeeNumber, lastName, firstName
    FROM employees
    WHERE firstName LIKE "a%";
    
	#2. Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre termina con on.
	SELECT employeeNumber, lastName, firstName
    FROM employees
    WHERE firstName LIKE "%on";
    
    #3. Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre incluye la cadena on.
	SELECT employeeNumber, lastName, firstName
    FROM employees
    WHERE firstName LIKE "%on%";
	
    #4. Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyos nombres tienen tres letras e inician con T y finalizan con m.
	SELECT employeeNumber, lastName, firstName
    FROM employees
    WHERE firstName LIKE "T_m";
    
	#5. Dentro de la tabla employees, obten el número de empleado, apellido y nombre de todos los empleados cuyo nombre no inicia con B.
	SELECT employeeNumber, lastName, firstName
    FROM employees
    WHERE firstName LIKE "B%";
    
	#6. Dentro de la tabla products, obten el código de producto y nombre de los productos cuyo código incluye la cadena _20.
    SELECT productCode, productName
    FROM products
    WHERE productCode LIKE "%/_20%" ESCAPE "/";
    
    
	#7. Dentro de la tabla orderdetails, obten el total de cada orden.
    SELECT ordernumber, SUM(quantityOrdered * priceEach) AS total
    FROM orderdetails
    GROUP BY orderNumber;
    
	#8. Dentro de la tabla orders obten el número de órdenes por año.
    SELECT YEAR(orderDate), COUNT(orderNumber) AS cantidad
    FROM orders
    GROUP BY YEAR(orderDate); 
    
	#9. Obten el apellido y nombre de los empleados cuya oficina está ubicada en USA.
    SELECT LastName, firstName,
		(SELECT country
		FROM offices
        WHERE employees.officeCode = offices.OfficeCode) AS country
	FROM employees
	WHERE
		(SELECT country
        FROM offices
        WHERE employees.officeCode = offices.OfficeCode) = 'USA';
            
	#10. Obten el número de cliente, número de cheque y cantidad del cliente que ha realizado el pago más alto.
    SELECT customerNumber, checkNumber, amount 
	FROM payments
    ORDER BY amount DESC
    LIMIT 1;
    
	#11. Obten el número de cliente, número de cheque y cantidad de aquellos clientes cuyo pago es más alto que el promedio.
    SELECT customerNumber, checkNumber, amount 
	FROM payments
    WHERE amount > (SELECT AVG(amount) FROM payments);
    
	#12. Obten el nombre de aquellos clientes que no han hecho ninguna orden.
    SELECT customerName
    FROM customers 
    WHERE customerNumber NOT IN (SELECT customerNumber FROM orders);
    
	#13. Obten el máximo, mínimo y promedio del número de productos en las órdenes de venta.
    SELECT max(quantityOrdered), min(quantityOrdered), avg(quantityOrdered)
    FROM orderdetails;
    
	#14.Dentro de la tabla orders, obten el número de órdenes que hay por cada estado.
    SELECT count(orderNumber) AS ordenes, 
		(SELECT state 
		FROM customers 
		WHERE orders.customerNumber = customers.customerNumber) AS state
    FROM orders
    GROUP BY state;


/* 		Retos 2
		Sesion 2
    Curso BEDU - Data Science
    Norma Arrazola Herrera
    	13 Mayo 2021
*/

/**********		RETO 1 		**********/
/*Reto 1: Búsqueda de patrones mediante LIKE

1. Objetivos 🎯
Escribir consultas que permitan responder a algunas preguntas.
2. Requisitos 📋
MySQL Workbench instalado.
3. Desarrollo 🚀
Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
*/

USE tienda;
#¿Qué artículos incluyen la palabra Pasta en su nombre?
SELECT * 
FROM articulo
WHERE nombre LIKE "%Pasta%";

#¿Qué artículos incluyen la palabra Cannelloni en su nombre?
SELECT *
FROM articulo 
WHERE nombre LIKE "%Cannelloni%";

#¿Qué nombres están separados por un guión (-) por ejemplo Puree - Kiwi?
SELECT * 
FROM articulo
WHERE nombre LIKE "%-%";

#¿Qué puestos incluyen la palabra Designer?
SELECT *
FROM puesto
WHERE nombre LIKE "%Designer%";

#¿Qué puestos incluyen la palabra Developer?
SELECT * 
FROM puesto
WHERE nombre LIKE "%Developer%";

/**********		RETO 2 		**********/
/*Reto 2: Funciones de agrupamiento
Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.*/

	#¿Cuál es el promedio de salario de los puestos?
    SELECT avg(salario)
    FROM puesto;
    
	#¿Cuántos artículos incluyen la palabra Pasta en su nombre?
    SELECT count(*)
    FROM articulo
    WHERE nombre LIKE "%Pasta%";
    
	#¿Cuál es el salario mínimo y máximo?
    SELECT min(salario)
    FROM puesto;
    
    SELECT max(salario)
    FROM puesto;
    
	#¿Cuál es la suma del salario de los últimos cinco puestos agregados?
	SELECT sum(salario)
    FROM puesto 
    ORDER BY id_puesto ASC
    LIMIT 5; 
		/*revisar porque esto no sirvio*/
    
		/*Conocer el ultimo quinto id de puesto*/
    SELECT max(id_puesto)-5
    FROM puesto;
		/*desde el 995 para arriba*/
	SELECT sum(salario)
    FROM puesto 
    WHERE id_puesto>=995; 

/**********		RETO 3 		**********/    
#Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.
	
    #• ¿Cuántos registros hay por cada uno de los puestos?
    SELECT nombre, count(*) AS registro
    FROM puesto
    GROUP BY nombre;
    
	#• ¿Cuánto dinero se paga en total por puesto?
	SELECT nombre, sum(salario) AS total
    FROM puesto
    GROUP BY nombre;
    
	#• ¿Cuál es el número total de ventas por vendedor?
    SELECT id_empleado, count(*) AS ventas
    FROM venta
    GROUP BY id_empleado;
    
	#• ¿Cuál es el número total de ventas por artículo?
    SELECT id_articulo, count(*) AS ventas
    FROM venta
    GROUP BY id_articulo;	
    
/**********		RETO 4 		**********/
/**********		SUBCONSULTAS 		*********/        
#Usando la base de datos tienda, escribe consultas que permitan responder las siguientes preguntas.

	#• ¿Cuál es el nombre de los empleados cuyo sueldo es menor a $10,000?
    SELECT nombre,
		(SELECT salario FROM puesto WHERE puesto.id_puesto = empleado.id_puesto) AS sueldo
	FROM empleado
    WHERE (SELECT salario FROM puesto WHERE puesto.id_puesto = empleado.id_puesto)<10000;
    
	#• ¿Cuál es la cantidad mínima y máxima de ventas de cada empleado?
    SELECT id_empleado, min(cantidad), max(cantidad) 
    FROM 
		(SELECT id_empleado, count(id_venta) AS cantidad
        FROM venta
        GROUP BY id_empleado) AS total
	GROUP BY id_empleado
    ORDER BY cantidad DESC;

	/*Agrupando por año*/
	SELECT empleado, MIN(ventas), MAX(ventas) 
	FROM 
	(SELECT 
		id_empleado AS empleado,
		COUNT(DISTINCT id_venta) AS ventas,
		YEAR(fecha)
		FROM
		venta
		GROUP BY id_empleado, YEAR(fecha) ) AS ventasAnual
	GROUP BY empleado
	ORDER BY MAX(ventas) DESC;

	#• ¿Cuál es el nombre del puesto de cada empleado?
	SELECT id_empleado, nombre, apellido_paterno, apellido_materno,
    (SELECT nombre
		FROM puesto AS p
        WHERE e.id_puesto = p.id_puesto) AS puesto
	FROM empleado AS e;
