
## Reto 1: Agrupamientos

<div style="text-align: justify;">

### 1. Objetivos :dart: 

- Poner en práctica el uso de agrupamientos.

### 2. Requisitos :clipboard:

1. MongoDB Compass instalado.

### 3. Desarrollo :rocket:

Con base en el ejemplo 1, modifica el agrupamiento para que muestre el costo promedio por habitación por país de las propiedades de tipo casa.

<br/>
	
	```json
	
	[{$match: {
  property_type: "House",
  bedrooms: {$gte: 1}
}
}, {$addFields: {
   costo_recamara: {$divide: ["$price", "$bedrooms"]}
}}, {$group: {
  _id: "$address.country",
  recamaras: {
     $sum: 1
  },
  total: {
     $sum: "$costo_recamara"
  }
}
}, {$addFields: {
   costo_promedio: {
     $divide: ["$total", "$recamaras"]
   }
}}]
	```

	
## Reto 2: Asociación de colecciones

<div style="text-align: justify;">

### 1. Objetivos :dart: 

- Proyectar columnas sobre distintos documentos para repasar algunos conceptos.

### 2. Requisitos :clipboard:

1. MongoDB Compass instalado.

### 3. Desarrollo :rocket:

Usando las colecciones `comments` y `users`, se requiere conocer el correo y contraseña de cada persona que realizó un comentario. Construye un pipeline que genere como resultado estos datos.

---

:warning: **NO CIERRES ESTE *PIPELINE* PUES LO USAREMOS MÁS ADELANTE**

---

<br/>

</div>
	
## Reto 3: Generación de vistas

<div style="text-align: justify;">

### 1. Objetivos :dart: 

- Proyectar columnas sobre distintos documentos para repasar algunos conceptos.

### 2. Requisitos :clipboard:

1. MongoDB Compass instalado.

### 3. Desarrollo :rocket:

Usando el *pipeline* que generaste en el Reto 2, genera la vista correspondiente.

	
## Ejercicios Sesión 7

<div style="text-align: justify;">

### 1. Objetivos :dart: 

- Aplicar los conceptos adquiridos durante la sesión.

### 2. Requisitos :clipboard:

1. MongoDB Compass instalado.

### 3. Desarrollo :rocket:

Continuaremos trabajando con la base de datos de películas y sus comentarios.

El ejercicio consiste en obtener, por país, el número de películas que hay de cada género. Un ejemplo de salida, en formato de tabla, sería:

| pais | genero | peliculas |
| ---- | ------ | --------- |
| USA  | Short  | 10        |
| USA  | Drama  | 20        |
| ...  | ...    | ...       |

**¡¡¡MUCHA SUERTE!!!**
