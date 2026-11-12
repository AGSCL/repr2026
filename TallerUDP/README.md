# Clase 1 · Ayuda en RStudio

El ejercicio de la clase consiste en intercambiar proyectos y comprobar si otra persona puede obtener tus mismos cuatro porcentajes de ENSSEX. Este taller es opcional. Puedes abrirlo aunque aún no tengas tu base. Trabaja los indicadores en el proyecto que vas a intercambiar.

## Abrir SWIRL por primera vez

SWIRL es un tutor que conversa contigo en la pestaña **Console** de RStudio. Te muestra una pregunta, espera tu respuesta y ofrece una pista si quieres intentarlo de nuevo.

1. Descomprime **TallerUDP.zip** y abre **TallerUDP.Rproj** en RStudio. La versión de referencia es R 4.4.1.
2. En **Console**, escribe el siguiente comando y pulsa Enter. La primera instalación necesita internet para restaurar los paquetes de `renv.lock`.

   ```r
   source("iniciar.R", encoding = "UTF-8")
   ```

3. Espera hasta que aparezca de nuevo `>`. Entonces escribe este otro comando y pulsa Enter.

   ```r
   swirl()
   ```

4. Escribe un alias. Si SWIRL te ofrece una introducción a sus controles, puedes seguirla o saltarla. En el menú elige el número del curso que quieres abrir.

### ENSSEX · Ayuda para el ejercicio

Elige **ENSSEX Ayuda para el ejercicio** y su primera lección. Tras una pregunta sobre el intercambio se abrirá el menú cuando escribas `consultas_enssex()`. Puedes ir directo a lo que necesitas en ese momento.

- Preparar el ZIP que recibirá tu compañero.
- Detectar por qué el script no encuentra la base.
- Comparar los cuatro porcentajes que ambos obtuvieron con la base del proyecto recibido.
- Registrar los cambios y redactar tu reflexión a partir de lo que observaste.
- Buscar una variable y sus categorías en el libro de códigos oficial de ENSSEX.

Cada consulta te da una pista. **Sigo con dudas** amplía la ayuda y después puedes elegir otro tema. El manual del MINSAL se consulta en línea.

**Si vuelves otro día**, abre el mismo `.Rproj`, ejecuta la línea con `source(...)` del paso 2 y, cuando aparezca `>`, escribe `consultas_enssex()`. Volverás directamente al menú.

### Precios · Repaso opcional de R

Elige **Precios - Repaso opcional de R**. **00 Repaso de la consola de RStudio** sirve para practicar cómo escribir una instrucción, leer la respuesta de R y guardarla en un script. Si ya manejas la consola, elige **01 Reproducir una tabla de precios**. Leerás un CSV de ODEPA y calcularás una tabla de precios medios por grupo y mes. Cuando terminas una lección, SWIRL vuelve al selector de cursos. Elige **Precios** otra vez para abrir la otra lección.

Los datos de precios vienen en [`_data/precios.csv`](_data/precios.csv). El script [`analisis.R`](analisis.R) permite repetir el cálculo y crea `_outputs/precios_por_grupo_y_mes.csv`. En el ejercicio ENSSEX, tu script va en `_lib/analisis.R` de **tu propio proyecto**, junto con la base asignada en `_data/`.

### Controles de la consola

Cuando veas `...`, pulsa Enter. En los menús, escribe el número de la opción. Para la primera pregunta de ENSSEX escribe la letra solicitada. Si aparece `>`, R espera un comando. Durante una lección de SWIRL, `bye()` guarda tu avance para retomarlo con el mismo alias en esa carpeta. Si ya empezaste la edición anterior de precios, termina esa sesión en tu copia anterior y descomprime esta edición en otra carpeta.

## Para quien dicta el taller

La [guía docente de la clase](https://github.com/AGSCL/repr2026/blob/main/Preguntas-clase1.md) reúne las preguntas y las pistas. Cada lección tiene un `lesson.yaml` en [cursos](cursos). El menú ENSSEX está en `initLesson.R`, junto al archivo de su lección.

Si editas la práctica de datos de precios, abre una terminal en `TallerUDP/` de la copia del repositorio y regenera su guía. El script prueba las respuestas y contrasta la tabla con el CSV incluido.

```sh
Rscript ../revisar_leccion.R cursos/Precios_-_Repaso_opcional_de_R/01_Reproducir_una_tabla_de_precios/lesson.yaml ../Preguntas-precios.md
```

Para probar una edición, abre el taller con un alias nuevo e intenta una respuesta equivocada y una correcta. Con la fuente guardada en un commit, puedes reconstruir la descarga desde la raíz con `git archive --format=zip --prefix=TallerUDP/ -o TallerUDP.zip HEAD:TallerUDP`.
