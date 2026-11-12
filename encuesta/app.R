#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:
# ENCUESTA DE TAMIZAJE (app Shiny)
# Perfil, expectativas y conocimiento previo de R de cada estudiante
# Corre en RStudio, Posit Cloud y shinyapps.io (Windows, Mac y Linux)
# Usa stringi y openssl para proteger el nombre antes de enviarlo a Google Sheets.
# Archivo 100% ASCII (evita mojibake en cualquier editor o sistema):
# tildes y signos se escriben como \u00e1 = a con tilde, \u00bf = signo de pregunta inicial, etc.
#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:
library(shiny)
#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:
# 1. CONFIGURACION (editar solo aqui)
if (file.exists(".Renviron")) readRenviron(".Renviron")   # IDs locales (en Posit Cloud: variables secretas)
cohorte <- "2026"
titulo  <- paste("Tamizaje inicial: Reproducibilidad en R - UDP", cohorte)
apps_script_id <- Sys.getenv("apps_script_id")  # ID de implementacion del Apps Script: variable secreta en Posit Cloud
script  <- if (apps_script_id == "" || startsWith(apps_script_id, "http")) apps_script_id else
  sprintf("https://script.google.com/macros/s/%s/exec", apps_script_id)   # guardar en la Sheet (ver hoja.gs)
sheet_id <- Sys.getenv("sheet_id")  # ID de la Sheet: variable secreta en Posit Cloud (en tu PC: archivo .Renviron)
csv     <- if (sheet_id == "") "" else
  sprintf("https://docs.google.com/spreadsheets/d/%s/export?format=csv", sheet_id)  # leer la Sheet
cursos_previos <- c("Fundamentos de Data Science", "Exploraci\u00f3n de Datos",   # cursos previos
                    "Manipulaci\u00f3n de Datos", "Visualizaci\u00f3n de Datos")      # del diplomado
nose    <- "No s\u00e9"            # opcion para no adivinar en las preguntas de conocimiento
#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:
# 2. ESTILO DE LAS CLASES (Lato, rojo #DD3333, texto #333333)
tema <- bslib::bs_theme(
  bg = "#FFFFFF", fg = "#333333", primary = "#DD3333",           # fondo, texto, botones
  base_font = bslib::font_google("Lato", local = FALSE),         # fuente (sin internet usa la del sistema)
  "headings-color" = "#DD3333",                                  # titulos en rojo
  "code-color" = "#DD3333"                                       # codigo en linea en rojo
)
#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:
# 3. PREGUNTAS (una por bloque: agregar, quitar o editar aqui)
# tipo: "texto" (abierta), "una" (una opcion), "varias" (marcar varias)
# correcta: solo en preguntas de conocimiento; se usa para el puntaje
seccion  <- function(texto) list(tipo = "seccion", texto = texto)
pregunta <- function(id, texto, tipo, opciones = NULL, correcta = NA,
                     obligatoria = TRUE)
  list(id = id, texto = texto, tipo = tipo, opciones = opciones,
       correcta = correcta, obligatoria = obligatoria)

preguntas <- list(
  seccion("1. Su experiencia"),
  pregunta("nombre", "Nombre y apellido (opcional). Si lo indica, guardaremos solo un c\u00f3digo para reconocer env\u00edos repetidos. Evite escribir nombres en las respuestas abiertas.", "texto", obligatoria = FALSE),
  pregunta("experiencia", "\u00bfCu\u00e1nto tiempo lleva usando R?", "una",
           c("Nunca lo he usado", "Menos de 6 meses",
             "Entre 6 meses y 2 a\u00f1os", "M\u00e1s de 2 a\u00f1os")),
  pregunta("frecuencia", "En el \u00faltimo mes, \u00bfcon qu\u00e9 frecuencia us\u00f3 R?", "una",
           c("Nunca", "1 o 2 veces", "Todas las semanas", "Casi a diario")),
  pregunta("confianza", "Del 1 (nada) al 5 (mucho), \u00bfcu\u00e1nta confianza tiene para analizar sus propios datos en R?",
           "una", as.character(1:5)),
  pregunta("software", "\u00bfQu\u00e9 otros programas usa para analizar datos? (puede marcar varios)", "varias",
           c("Excel", "SPSS", "Stata", "Python", "Ninguno")),
  pregunta("aprendio", "\u00bfC\u00f3mo ha aprendido R? (puede marcar varios)", "varias",
           c("Cursos del diplomado", "Otros cursos", "Tutoriales o videos",
             "Por mi cuenta con ayuda de IA", "Por mi cuenta sin IA")),

  seccion("2. El diplomado"),
  pregunta("dificil", "\u00bfQu\u00e9 curso previo del diplomado le cost\u00f3 m\u00e1s?", "una", cursos_previos),
  pregunta("facil", "\u00bfCu\u00e1l le result\u00f3 m\u00e1s f\u00e1cil?", "una", cursos_previos),
  pregunta("por_que", "\u00bfQu\u00e9 le hizo dif\u00edcil ese curso? (opcional)", "texto", obligatoria = FALSE),

  seccion("3. Expectativas"),
  pregunta("expectativas", "\u00bfQu\u00e9 espera poder hacer al terminar este curso?", "texto"),
  pregunta("interes", "\u00bfQu\u00e9 tema le interesa m\u00e1s?", "una",
           c("Organizar proyectos y carpetas", "Control de versiones (Git y GitHub)",
             "Versiones de paquetes (renv)", "Informes reproducibles (Quarto o R Markdown)",
             "Trabajar en la nube (Posit Cloud o Google Colab)")),
  pregunta("plataforma", "\u00bfD\u00f3nde trabajar\u00e1 durante el curso?", "una",
           c("RStudio en Windows", "RStudio en Mac", "RStudio en Linux",
             "Posit Cloud", "Google Colab", "A\u00fan no lo s\u00e9")),

  seccion("4. Conocimientos (no es una evaluaci\u00f3n: si no sabe, marque \u00abNo s\u00e9\u00bb)"),
  pregunta("k1", "\u00bfQu\u00e9 devuelve <code>mean(c(2, 4, NA))</code>?", "una",
           c("3", "NA", "Un error", nose), correcta = "NA"),
  pregunta("k2", "\u00bfQu\u00e9 devuelve <code>c(1, 4, 9) |&gt; sqrt() |&gt; sum()</code>?", "una",
           c("6", "14", "Un error", nose), correcta = "6"),
  pregunta("k3", "En ggplot2, \u00bfpara qu\u00e9 sirve el signo <code>+</code>?", "una",
           c("Para sumar variables", "Para a\u00f1adir capas al gr\u00e1fico",
             "Para unir bases de datos", nose), correcta = "Para a\u00f1adir capas al gr\u00e1fico"),
  pregunta("k4", "\u00bfPara qu\u00e9 sirve el archivo <code>.Rproj</code>?", "una",
           c("Guarda las bases de datos y objetos", "Marca la carpeta de trabajo del proyecto",
             "Instala los paquetes necesarios", nose), correcta = "Marca la carpeta de trabajo del proyecto"),
  pregunta("k5", "Un script compartido parte con <code>setwd(\"C:/Users/ana/Desktop\")</code>. \u00bfQu\u00e9 problema tiene?", "una",
           c("Ninguno", "Esa carpeta solo existe en el computador de Ana",
             "setwd() ya no existe en R", nose), correcta = "Esa carpeta solo existe en el computador de Ana"),
  pregunta("k6", "\u00bfQu\u00e9 guarda el archivo <code>renv.lock</code>?", "una",
           c("Los datos del proyecto", "Las versiones de los paquetes usados",
             "Una contrase\u00f1a del proyecto", nose), correcta = "Las versiones de los paquetes usados"),
  pregunta("k7", "\u00bfQu\u00e9 entrega <code>summary(x)</code> si <code>x</code> es un vector num\u00e9rico?", "una",
           c("M\u00ednimo, cuartiles, media y m\u00e1ximo", "Solo la media y la desviaci\u00f3n est\u00e1ndar",
             "Un gr\u00e1fico de la distribuci\u00f3n", nose), correcta = "M\u00ednimo, cuartiles, media y m\u00e1ximo")
)

preg <- Filter(function(x) x$tipo != "seccion", preguntas)   # solo preguntas, sin titulos
names(preg) <- vapply(preg, `[[`, "", "id")                  # acceso por id: preg$experiencia
stopifnot(!anyDuplicated(names(preg)),                       # ids unicos
          all(vapply(preg, function(x) is.na(x$correcta) || x$correcta %in% x$opciones, TRUE)))  # clave existe
#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:
# 4. GUARDAR UNA RESPUESTA (una fila por persona)
hash_nombre <- function(nombre) {
  nombre <- stringi::stri_replace_all_regex(nombre, "\\p{White_Space}+", " ")
  nombre <- stringi::stri_trans_nfc(stringi::stri_trans_casefold(trimws(nombre)))
  salida <- rep("", length(nombre))
  con_nombre <- !is.na(nombre) & nzchar(nombre)
  if (any(con_nombre)) {
    clave <- openssl::base64_decode(Sys.getenv("encuesta_nombre_hmac"))
    if (length(clave) != 32L) stop("Falta configurar la clave privada de la encuesta.")
    salida[con_nombre] <- vapply(nombre[con_nombre], function(x) {
      paste0("hmac256:", openssl::sha256(charToRaw(enc2utf8(x)), key = clave))
    }, "")
  }
  salida
}

es_marca_prueba <- function(texto) {
  grepl(paste0("^PRUEBA-UDP-", cohorte, "-[A-Za-z0-9][A-Za-z0-9_-]*$"), trimws(texto))
}

json_respuesta <- function(fila) {
  fila$nombre <- hash_nombre(fila$nombre)
  # Apps Script agrega por posicion; las nuevas columnas van al final del esquema.
  fila$cohorte <- cohorte
  fila$es_prueba <- es_marca_prueba(fila$expectativas)
  jsonlite::toJSON(as.list(fila), auto_unbox = TRUE)
}

guardar <- function(fila) {
  if (!nzchar(script)) stop("Falta configurar apps_script_id.")
  json <- json_respuesta(fila)
  r <- curl::curl_fetch_memory(script, curl::new_handle(postfields = json))
  if (r$status_code != 200L || rawToChar(r$content) != "ok") stop("La hoja no confirmo el guardado.")
}
#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:
# 5. INTERFAZ
crear <- function(x) {
  if (x$tipo == "seccion") return(h3(x$texto))
  etiqueta <- HTML(paste0(match(x$id, names(preg)), ". ", x$texto))   # numero + texto (admite <code>)
  switch(x$tipo,
    texto  = textAreaInput(x$id, etiqueta, rows = 2, width = "100%"),
    una    = radioButtons(x$id, etiqueta, x$opciones, selected = character(0), width = "100%"),
    varias = checkboxGroupInput(x$id, etiqueta, x$opciones, width = "100%")
  )
}

ui <- fluidPage(
  theme = tema,
  tags$style(".container-fluid {max-width: 800px;} strong {color: #FF5252;}"),
  titlePanel(titulo),
  p("Nos sirve para conocer sus intereses y cu\u00e1nto saben de R, y as\u00ed adaptar el curso.",
    strong("Toma menos de 5 minutos"), "y no necesita tener R abierto."),
  lapply(preguntas, crear),
  actionButton("enviar", "Enviar", class = "btn-primary btn-lg"),
  br(), br()
)
#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:
# 6. SERVIDOR
server <- function(input, output, session) {
  enviado <- FALSE
  observeEvent(input$enviar, {
    if (enviado) return()
    resp <- vapply(preg, function(x) trimws(paste(input[[x$id]], collapse = "; ")), "")  # varias: "a; b"
    faltan <- which(vapply(preg, `[[`, TRUE, "obligatoria") & resp == "")
    if (length(faltan) > 0) {
      showNotification(paste("Falta responder:", paste(faltan, collapse = ", ")), type = "error")
      return()
    }
    ok <- tryCatch({guardar(data.frame(fecha = format(Sys.time(), "%Y-%m-%d %H:%M", tz = "America/Santiago"), t(resp))); TRUE},
                   error = function(e) FALSE)                # sin conexion: avisar en vez de cerrar la app
    if (!ok) return(showNotification("No se pudo guardar. Intente de nuevo en un momento.", type = "error"))
    enviado <<- TRUE
    showModal(modalDialog(title = "\u00a1Muchas gracias!",
                          "Sus respuestas nos permitir\u00e1n adaptar el curso."))
  })
}

shinyApp(ui, server)
