# Desde el proyecto del taller: Rscript ../revisar_leccion.R ruta/lesson.yaml [salida.md]
# Verifica la lección de datos de precios y genera su guía en Markdown.
args <- commandArgs(trailingOnly = TRUE)
if (!length(args) || length(args) > 2L)
  stop("Uso: Rscript ../revisar_leccion.R ruta/lesson.yaml [salida.md]", call. = FALSE)
archivo <- normalizePath(args[1], mustWork = TRUE)
salida <- if (length(args) == 2L) args[2] else "Preguntas-precios.md"
salida <- file.path(normalizePath(dirname(salida), mustWork = TRUE), basename(salida))
if (!l10n_info()[["UTF-8"]]) {
  utf8 <- if (.Platform$OS.type == "windows") ".UTF-8" else "C.UTF-8"
  if (!nzchar(Sys.setlocale("LC_CTYPE", utf8))) stop("Ejecuta R con una configuracion regional UTF-8.")
}
leccion <- yaml::yaml.load(paste(readLines(archivo, encoding = "UTF-8"), collapse = "\n"), eval.expr = FALSE)
stopifnot(file.exists("_data/precios.csv"))
# Los comandos del estudiante crean un CSV. Ejecutarlos en una copia protege sus resultados.
trabajo <- tempfile("taller-precios-")
dir.create(trabajo)
material <- c("_lit", "_data", "_lib", "_figures", "_doc", "_hist", "TallerUDP.Rproj", "README.md",
              "iniciar.R", "analisis.R", "renv.lock")
stopifnot(all(file.copy(material[file.exists(material)], trabajo, recursive = TRUE)))
dir.create(file.path(trabajo, "_outputs"))
setwd(trabajo)
datos <- new.env(parent = globalenv())
inicio <- file.path(dirname(archivo), "initLesson.R")
if (file.exists(inicio)) source(inicio, local = datos, encoding = "UTF-8")
stopifnot(identical(leccion[[1]]$Class, "meta"), file.exists("_data/precios.csv"))
invisible(getFromNamespace("loadCustomTests", "swirl")(dirname(archivo)))
evaluar <- getFromNamespace("testMe", "swirl")
estado <- new.env()
estado$les <- structure(list(), course_name = leccion[[1]]$Course)

lineas <- c(paste("#", leccion[[1]]$Lesson), "", leccion[[1]]$Course, "")
numero <- 0L
for (item in leccion[-1L]) {
  stopifnot(is.character(item$Output), nzchar(item$Output))
  if (identical(item$Class, "text")) {
    lineas <- c(lineas, item$Output, "")
    next
  }
  numero <- numero + 1L
  alternativa <- identical(item$Class, "mult_question")
  if (!alternativa && !identical(item$Class, "cmd_question"))
    stop("Tipo de pregunta desconocido: ", item$Class)
  clave <- item$CorrectAnswer
  stopifnot(is.character(clave), nzchar(clave), is.character(item$Hint), nzchar(item$Hint))
  test <- str2lang(item$AnswerTests)
  estado$snapshot <- as.list(datos)
  tipo <- if (alternativa) "Alternativas" else "Comando en R"
  lineas <- c(lineas, sprintf("## Pregunta %d \u00b7 %s", numero, tipo), "", item$Output, "")

  if (alternativa) {
    opciones <- trimws(strsplit(item$AnswerChoices, ";", fixed = TRUE)[[1L]])
    stopifnot(length(opciones) > 1L, all(nzchar(opciones)), !anyDuplicated(opciones),
              sum(opciones == clave) == 1L)
    for (opcion in opciones) {
      estado$val <- opcion
      stopifnot(identical(isTRUE(evaluar(item$AnswerTests, estado)), opcion == clave))
    }
    lineas <- c(lineas, paste("-", opciones), "")
    solucion <- clave
  } else {
    expresion <- str2lang(clave)
    respuestas <- if (identical(test[[1L]], as.name("omnitest")) && !is.null(test$correctExpr)) {
      test$correctExpr
    } else if (as.character(test[[1L]]) %in% c("expr_identical_to", "any_of_exprs")) {
      unlist(as.list(test)[-1L], use.names = FALSE)
    } else clave
    valor <- eval(expresion, datos)
    for (r in respuestas) {
      estado$expr <- str2lang(r)
      invisible(capture.output(estado$val <- eval(estado$expr, new.env(parent = datos))))
      stopifnot(isTRUE(evaluar(item$AnswerTests, estado)))
    }
    estado$expr <- expresion
    estado$val <- valor
    stopifnot(isTRUE(evaluar(item$AnswerTests, estado)))
    parcial <- is.data.frame(valor) && nrow(valor) > 8L
    subtitulo <- if (parcial) "**Resultado (primeras ocho filas)**" else "**Resultado**"
    solucion <- c("```r", clave, "```")
    if (!is.null(valor)) {
      vista <- if (parcial) head(valor, 8L) else valor
      if (inherits(vista, "tbl_df")) vista <- as.data.frame(vista)
      solucion <- c(solucion, "", subtitulo, "", "```text", capture.output(print(vista)), "```")
    }
    otras <- respuestas[!vapply(respuestas, function(r) identical(str2lang(r), expresion), TRUE)]
    if (length(otras))
      solucion <- c(solucion, "", "**Otras expresiones aceptadas**", "", "```r", otras, "```")
  }
  lineas <- c(lineas, "<details>", "<summary>Ver soluci\u00f3n y pista</summary>", "",
              solucion, "", "**Pista**", "", item$Hint, "", "</details>", "")
}
precios <- utils::read.csv("_data/precios.csv", fileEncoding = "UTF-8")
stopifnot(numero > 0L, nrow(precios) > 0L,
          all(c("grupo", "mes", "precio_promedio") %in% names(precios)),
          is.numeric(precios$precio_promedio), is.data.frame(datos$tabla))
medias <- aggregate(precio_promedio ~ grupo + mes, precios, mean)
conteos <- aggregate(precio_promedio ~ grupo + mes, precios, length)
revision <- merge(medias, as.data.frame(datos$tabla), by = c("grupo", "mes"), all = TRUE)
revision <- merge(revision, conteos, by = c("grupo", "mes"), all = TRUE, suffixes = c("", "_n"))
stopifnot(nrow(revision) == nrow(datos$tabla), nrow(revision) == nrow(medias),
          isTRUE(all.equal(revision$precio_promedio, revision$precio_medio)),
          identical(as.integer(revision$precio_promedio_n), as.integer(revision$n_registros)))
guardada <- utils::read.csv("_outputs/precios_por_grupo_y_mes.csv", fileEncoding = "UTF-8")
stopifnot(isTRUE(all.equal(guardada, as.data.frame(datos$tabla), check.attributes = FALSE)))
texto <- paste(vapply(leccion[-1L], "[[", "", "Output"), collapse = "\n")
if (grepl("/kg en ", texto, fixed = TRUE)) {
  julio <- medias[medias$mes == 7L, ]
  for (i in seq_len(nrow(julio))) {
    cifra <- formatC(julio$precio_promedio[i], format = "f", digits = 2L, big.mark = ".", decimal.mark = ",")
    stopifnot(grepl(paste0("$", cifra, "/kg en ", julio$grupo[i]), texto, fixed = TRUE))
  }
}
lineas <- trimws(lineas, which = "right")
writeLines(enc2utf8(lineas[seq_len(max(which(nzchar(lineas))))]), salida, useBytes = TRUE)
message(numero, " preguntas verificadas: ", normalizePath(salida, winslash = "/"))
