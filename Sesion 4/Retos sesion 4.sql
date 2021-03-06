/* 		Retos 4
		Sesion 4
    Curso BEDU - Data Science
    Norma Arrazola Herrera
    	20 Mayo 2021
*/

/**********		RETO 1 		**********/
/*Reto 1: Realizando operaciones con tablas
1. Objetivos 馃幆
Realizar operaciones SQL para administrar tablas
Crear tablas acorde a los datos
2. Requisitos 馃搵
Servidor MySQL instalado
3. Desarrollo 馃殌
*/

#1. Definir los campos y tipos de datos para la tabla movies haciendo uso de los archivos movies.dat y README.
#2. Crear la tabla movies (recuerda usar el mismo nombre del archivo sin la extensi贸n para vincular nombres de tablas con archivos).
CREATE TABLE IF NOT EXISTS movies (
   peliculaId INT PRIMARY KEY, 
   pelicula VARCHAR(30), 
   genero VARCHAR(20)
);

#Definir los campos y tipos de datos para la tabla ratings haciendo uso de los archivos ratings.dat y README.
#Crear la tabla ratings (recuerda usar el mismo nombre del archivo sin la extensi贸n para vincular nombres de tablas con archivos)
CREATE TABLE IF NOT EXISTS ratings (
   id INT , 
   peliculaId int,
   ratings int,
   fecha BIGINT,
   FOREIGN KEY (peliculaId) REFERENCES movies(peliculaId),
   FOREIGN KEY (id) REFERENCES users(id)
);

DROP TABLE ratings;



#Nota: Observa que la tabla ratings requiere llaves for谩neas. Revisa esta referencia o pregunta a tu experta(o): https://www.w3schools.com/sql/sql_foreignkey.asp
#Parte de tu formaci贸n como Data Scientist consiste en que aprendas a consultar documentaci贸n. :nerd: Google es tu amigo. 鉂わ笍

/**********		RETO 2 		**********/
/*
Reto 2: Importando datos a una tabla en formato CSV
1. Objetivos 馃幆
Aplicar el procedimiento para importaci贸n de datos a una tabla
Validar que la correcta importaci贸n de los datos
2. Requisitos 馃搵
Servidor MySQL instalado
3. Desarrollo 馃殌

/*Usando como base el archivo movies.dat, limpiarlo e importar los datos en la tabla movies creada en el Reto 1.
Importante: Este archivo presenta un problema muy com煤n de encoding, es decir, la codificaci贸n con la que fue definido, no es reconocida por MySQL. 
Para solucionar este problema, elige una codificaci贸n diferente al momento de cargar los datos.*/
SELECT *
FROM movies
ORDER BY peliculaId DESC
LIMIT 1;
INSERT INTO movies (peliculaId,pelicula,edad,genero) VALUES (3953,'Signals','Sci-Fi|Horror');   


/*Usando como base el archivo ratings.dat, limpiarlo e importar los datos en la tabla ratings creada en el Reto 2.
Importante: Como podr谩s notar, este archivo tiene demasiados registros, de manera que es normal que la carga sea muy lenta. 
Esto es algo muy com煤n cuando nos enfrentamos a la carga de archivos. Si ya lleva mucho tiempo y no finaliza, no te preocupes, puedes cancelar la carga.
Finalmente, a帽ade un registro en cada tabla usando INSERT INTO.*/
SELECT *
FROM ratings
LIMIT 10;

INSERT INTO ratings (id,peliculaId,ratings,fecha) VALUES (1233,3953,5,978300764);   
