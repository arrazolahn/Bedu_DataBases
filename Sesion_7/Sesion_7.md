
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

[{
    $match: {
        property_type: "House",
        bedrooms: {
            $gte: 1
        }
    }
}, {
    $addFields: {
        costo_recamara: {
            $divide: ["$price", "$bedrooms"]
        }
    }
}, {
    $group: {
        _id: "$address.country",
        recamaras: {
            $sum: 1
        },
        total: {
            $sum: "$costo_recamara"
        }
    }
}, {
    $addFields: {
        costo_promedio: {
            $divide: ["$total", "$recamaras"]
        }
    }
}]
```
	
![S7_R1_1](https://user-images.githubusercontent.com/35963381/120674118-11eed200-c494-11eb-9bf2-e3899099ba21.PNG)
	
## Reto 2: Asociación de colecciones

<div style="text-align: justify;">

### 1. Objetivos :dart: 

- Proyectar columnas sobre distintos documentos para repasar algunos conceptos.

### 2. Requisitos :clipboard:

1. MongoDB Compass instalado.

### 3. Desarrollo :rocket:

Usando las colecciones `comments` y `users`, se requiere conocer el correo y contraseña de cada persona que realizó un comentario. Construye un pipeline que genere como resultado estos datos.

```json
[{
    $lookup: {
        from: 'users',
        localField: 'name',
        foreignField: 'name',
        as: 'userData'
    }
}, {
    $addFields: {
        userData: {
            $arrayElemAt: ["$userData", 0]
        }
    }
}, {
    $addFields: {
        userEmail: "$userData.email",
        userPassword: "$userData.password"

    }
}, {
    $project: {
        _id: 0,
        userEmail: 1,
        userPassword: 1,
    }
}]
	
```

	![S7_R2_1](https://user-images.githubusercontent.com/35963381/120699176-5b4d1a80-c4b0-11eb-852b-e5720248baac.PNG)

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
