# Clase 1 · Reproducir una tabla de precios

¿Puede otra persona obtener tu misma tabla en su computador? Trabajarás con un extracto de precios al consumidor de ODEPA. En R vas a leerlo con una ruta relativa, calcular el promedio del precio promedio por grupo y mes y guardar la tabla para que alguien más la compruebe. [Ejercicio de la clase 1, diapositiva 13](https://docs.google.com/presentation/d/1rQCkLHke91vUo9a99WBRiS3fRVPOVZzFDUgHRcoQIYo/edit#slide=id.g31920441b5c_0_122)

## Empezar

1. Descomprime **TallerUDP.zip**. Abre **TallerUDP.Rproj** en RStudio. La versión de referencia es R 4.4.1.
2. En la consola ejecuta la primera línea. La primera vez necesitas internet para instalar los paquetes de `renv.lock`.

   ```r
   source("iniciar.R", encoding = "UTF-8")
   ```

3. Cuando termine y vuelvas a ver `>`, escribe este segundo comando directamente en la consola.

   ```r
   swirl()
   ```

4. Elige un alias sin puntuación. Selecciona **Reproducibilidad UDP 2026** y **01 Reproducir una tabla de precios**. Cuando aparezca `...`, pulsa Enter. En una lista escribe el número de tu alternativa. En `>` escribe código R.

El CSV, su procedencia y la lección están incluidos. Tras la instalación inicial puedes trabajar sin conexión. Desde el indicador de R, `bye()` guarda tu avance. Para continuar, abre la misma carpeta y repite los dos comandos con el mismo alias.

Por ejemplo, cuando la lección pida comprobar el año de los datos, escribe `unique(precios$anio)` en la consola. R mostrará el año y swirl comprobará la respuesta. Si te equivocas, lee la pista y vuelve a intentarlo. El CSV original está en `_data/`; al guardar la tabla del ejercicio aparecerá un archivo nuevo en `_outputs/`.

## Intercambiar el trabajo

Al terminar tendrás una tabla en `_outputs/precios_por_grupo_y_mes.csv`. Toma una captura del árbol del proyecto. Prepara el ZIP para tu pareja con los datos, código, resultados, instrucciones y versiones. Deja fuera `.progreso/` y `renv/library/`, que pertenecen a tu sesión y equipo.

Al recibir el ZIP de otra persona, conserva una copia de su tabla. Abre el proyecto, restaura las versiones con `renv::restore()` y ejecuta la solución de referencia con `source("analisis.R")`. Compara las cuatro combinaciones de grupo y mes de la tabla regenerada con la que recibiste. Adjunta tu captura y anota **dos fortalezas, dos debilidades y dos amenazas** al reproducir o replicar el trabajo. Vincula cada observación a algo que viste o intentaste, por ejemplo una ruta que tuviste que corregir o una decisión sobre qué observaciones entran en el promedio.

## Cambiar una pregunta como docente

Abre [lesson.yaml](cursos/Reproducibilidad_UDP_2026/01_Reproducir_una_tabla_de_precios/lesson.yaml). Cada bloque es un paso. En una pregunta de alternativas, `Output` es el enunciado, `AnswerChoices` contiene las opciones separadas por punto y coma, `CorrectAnswer` contiene el texto exacto de la correcta y `Hint` es la pista. `AnswerTests` decide si swirl acepta lo que escribió el estudiante. Si cambias la respuesta, actualiza también esa comprobación.

En la copia del repositorio, abre una terminal en `TallerUDP/` y regenera la [guía docente](https://github.com/AGSCL/repr2026/blob/main/Preguntas-clase1.md) con:

```sh
Rscript ../revisar_leccion.R cursos/Reproducibilidad_UDP_2026/01_Reproducir_una_tabla_de_precios/lesson.yaml ../Preguntas-clase1.md
```

Prueba el cambio en swirl con un alias nuevo. Intenta primero una respuesta equivocada y luego una correcta. Una vez guardados los cambios en Git, puedes reconstruir la descarga desde la raíz del repositorio con `git archive --format=zip --prefix=TallerUDP/ -o TallerUDP.zip HEAD:TallerUDP`.
