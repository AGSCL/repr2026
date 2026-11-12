# Publicar los resultados de la encuesta

El [tablero público de la cohorte](https://agscl.github.io/repr2026/resultados/) consulta cada cinco segundos el CSV de la pestaña **Panel2026**. Google Sheets calcula las cifras cuando llega una respuesta. No hace falta volver a publicar la página.

## Mantener el acceso

- En **Compartir → Acceso general**, el libro tiene **Cualquier persona con el enlace → Lector**. Este permiso permite leer todas sus pestañas. Andrés y Constanza tienen acceso de escritura.
- La encuesta Shiny añade cada envío a la primera pestaña del libro. Conserva esa pestaña en primer lugar.
- La dirección de lectura de [index.html](../../resultados/index.html) selecciona únicamente las columnas A a C de **Panel2026**. La página carece de controles para escribir en la hoja.

## Cómo se calculan los gráficos

- Se usa la cohorte 2026. Se excluyen los envíos de prueba. Se conserva la última respuesta de cada identificador y cada respuesta anónima.
- En experiencia, el numerador reúne «Entre 6 meses y 2 años» y «Más de 2 años». El denominador es el total de respuestas incluidas.
- La nota se calcula para cada persona que respondió las siete preguntas. Cada acierto suma un punto y «No sé» suma cero. La escala es lineal por tramos, con 0 % = 1,0, 60 % = 4,0 y 100 % = 7,0. El tablero promedia esas notas antes de mostrar un decimal.
- Las nubes agrupan variantes de palabras con significado para el curso. Cada término cuenta una vez por respuesta. Se muestran hasta 30 términos por nube cuando aparecen en dos o más respuestas.

Si cambias las preguntas o alternativas en `encuesta/app.R`, actualiza las claves y el vocabulario en [crear_panel.cjs](crear_panel.cjs). Para regenerar la fórmula desde la raíz y pegarla en **Panel2026!A1**, usa:

```sh
node -p "require('./encuesta/panel/crear_panel.cjs').formula('Sheet1')"
```

La misma función con tercer argumento `true` genera una prueba con respuestas ficticias. Al pegar esa fórmula en una celda libre debe devolver `TRUE`.
