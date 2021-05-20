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
