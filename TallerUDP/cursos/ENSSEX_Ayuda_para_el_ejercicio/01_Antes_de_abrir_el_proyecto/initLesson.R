consultas_enssex <- function() {
  mostrar <- function(texto) {
    cat("\n", paste(strwrap(texto, width = min(78L, getOption("width"))),
                     collapse = "\n"), "\n", sep = "")
  }

  temas <- c("¿Qué pongo en el ZIP que voy a compartir?",
             "El script no encuentra la base. ¿Por dónde empiezo?",
             "¿Cómo comparo los cuatro porcentajes con los de mi pareja?",
             "¿Cómo registro mis cambios y preparo la reflexión?",
             "¿Dónde compruebo qué significa una variable de ENSSEX?")
  pistas <- c(
    "Piensa en quien recibe tu carpeta. ¿Dónde abrirá el proyecto y dónde encontrará los archivos que tu análisis usa? Mira tu árbol del README antes de comprimir.",
    "Lee el nombre del archivo que R dice que no encuentra. Con el proyecto recibido abierto, mira en el panel Files si ese archivo está dentro de la carpeta que esperaba el script.",
    "Confirma que abriste la base que venía en el proyecto de tu pareja. ¿Qué porcentaje obtuvo tu pareja con esa base y cuál te da a ti al ejecutar su código? Empareja los cuatro indicadores por su nombre.",
    "El correo pide tres cosas: la captura del árbol del README de tu pareja, cuántas líneas cambiaste y cuáles, y tu reflexión. Describe qué línea editaste para que corriera el proyecto recibido y por qué. Si corrió tal como llegó, son 0 líneas. Puedes escribir la reflexión en ese mismo correo.",
    "En la página del Ministerio de Salud, ubica ENSSEX y elige «Manual de uso de base de datos y libro de códigos». Ten a mano el nombre exacto de la variable en el diccionario de tu base."
  )

  repeat {
    tema <- utils::menu(c(temas, "Salir de las consultas"), graphics = FALSE,
                        title = "ENSSEX · ¿En qué paso tienes una duda?")
    if (tema == 0L || tema > length(temas)) return(invisible(NULL))

    mostrar(pistas[tema])
    if (tema == 4L) {
      mostrar("Completa dos puntos de cada tipo con lo que observaste en el proyecto recibido:")
      mostrar("Fortalezas 1 y 2: «Observé ___ y eso facilitó ___».")
      mostrar("Debilidades 1 y 2: «Encontré ___ y eso dificultó ___».")
      mostrar("Amenazas 1 y 2: «Si cambia ___, podría ocurrir ___».")
      mostrar("Con esos tres elementos queda completa la entrega por correo.")
    }
    if (tema == 5L) {
      cat("https://www.minsal.cl/salud-sexual-y-reproductiva-material-para-descarga/\n")
    }
    paso <- utils::menu(c("Volver al menú de consultas", "Sigo con dudas"),
                        graphics = FALSE, title = "¿Cómo quieres seguir?")
    if (paso != 2L) next

    switch(tema,
      {
        mostrar("Comprime la carpeta del proyecto que trabajaste. Dentro deberían viajar juntos el .Rproj, la base asignada en _data/, _lib/analisis.R, el README con el árbol actualizado y los archivos de renv que permiten restaurar los paquetes.")
        mostrar("Vuelve a ejecutar la sección que actualiza el árbol del README. El enunciado la llama sección 7. En 00estructura_proyecto.R del repositorio es la sección 6.")
        mostrar("Una comprobación rápida es abrir el ZIP y localizar el .Rproj y esas rutas dentro de la misma carpeta.")
      },
      {
        mostrar("Descomprime la carpeta y abre el .Rproj que te enviaron. En su consola, getwd() muestra desde dónde está leyendo R. list.files(\"_data\") muestra los nombres de archivos que llegaron.")
        mostrar("Compara el nombre y la extensión con la línea de _lib/analisis.R que lee la base. Por ejemplo, read.csv(\"_data/nombre_real.csv\") busca ese archivo desde el proyecto abierto. Sustituye nombre_real.csv por el nombre que viste. En tu script conserva la función y sus opciones originales y ajusta solo la ruta. Si falta el archivo en el ZIP, pídeselo a tu pareja.")
      },
      {
        mostrar("Abre el .Rproj recibido, ejecuta renv::restore() y luego _lib/analisis.R, como indica el enunciado. Para cada indicador puedes anotar tres cosas: su nombre, el porcentaje de tu pareja y el que obtuviste tú al correr su proyecto.")
        mostrar("Compara porcentajes expresados en la misma escala y con los mismos decimales. Si las cifras difieren, revisen juntos qué archivo cargó cada uno y qué observaciones entraron al denominador antes de interpretar la diferencia.")
      },
      {
        mostrar("Moví la carpeta a otra ubicación y el script siguió encontrando el CSV. Es una fortaleza porque la lectura usa una ruta relativa.")
      },
      {
        mostrar("Puedes abrir el PDF del manual directamente en el Portal de Datos Abiertos:")
        cat("https://datos.gob.cl/dataset/c6983439-49f6-4e71-85fe-e8de6e73dae0/resource/e155a68f-13f4-48e0-81e0-123f5c23433f/download/minsal_enssex_2022_2023_manual_de_uso_y_libro_de_codigos.pdf\n")
        mostrar("Si usas un buscador, escribe «MINSAL ENSSEX 2022 2023 manual de uso libro de códigos». En la sección 4 del PDF, busca el nombre exacto con Ctrl+F (Cmd+F en Mac). Lee en la misma fila la etiqueta de la variable, los valores y sus etiquetas.")
      }
    )
  }
}
