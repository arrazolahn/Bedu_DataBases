 
   ```sql

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
   ```
