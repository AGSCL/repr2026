#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:
# RESUMEN RAPIDO DE LA ENCUESTA (solo R base)
# Correr linea a linea desde la carpeta de app.R
#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:#:
source("app.R", encoding = "UTF-8")   # trae las preguntas, la cohorte y la direccion de lectura

# 1. LEER LA COHORTE (las filas de prueba se excluyen antes del resumen)
stopifnot(nzchar(csv))
d <- read.csv(csv, fileEncoding = "UTF-8",
              colClasses = "character", na.strings = character(0))   # todo como texto: la respuesta "NA" no se pierde
stopifnot("cohorte" %in% names(d))
d <- d[d$cohorte %in% cohorte, , drop = FALSE]
prueba <- startsWith(d$nombre, "PRUEBA-UDP-") | es_marca_prueba(d$expectativas)
if ("es_prueba" %in% names(d))
  prueba <- prueba | tolower(trimws(d$es_prueba)) %in% c("true", "1", "verdadero")
d <- d[!prueba, , drop = FALSE]
if (!nrow(d)) stop("Aun no hay respuestas de estudiantes para esta cohorte.")
historico <- !grepl("^hmac256:[0-9a-f]{64}$", d$nombre)
d$nombre[historico] <- hash_nombre(d$nombre[historico])
d <- d[d$nombre == "" | !duplicated(d$nombre, fromLast = TRUE), , drop = FALSE]
nrow(d)                                                            # cuantas personas respondieron

# 2. PUNTAJE DE CONOCIMIENTOS (preguntas con 'correcta')
claves   <- Filter(function(x) !is.na(x$correcta), preg)
correcto <- do.call(cbind, lapply(claves, function(x) d[[x$id]] == x$correcta))
d$puntaje <- rowSums(correcto)
table(factor(d$puntaje, 0:length(claves)))                         # distribucion del puntaje
c(media = mean(d$puntaje), de = sd(d$puntaje))                     # nivel y variabilidad
round(100 * colMeans(correcto))                                     # % de acierto por pregunta (bajo = dificil)
round(100 * colMeans(d[names(claves)] == nose))                     # % que marco "No se"

# 3. CONTEO DE CADA PREGUNTA CERRADA (en el orden de las opciones)
for (x in preg) if (x$tipo != "texto") {
  r <- if (x$tipo == "varias") unlist(strsplit(d[[x$id]], "; ")) else d[[x$id]]
  cat("\n", x$id, "\n"); print(table(factor(r, x$opciones)))
}

# 4. PUNTAJE SEGUN EXPERIENCIA (colores de las clases)
exp <- factor(d$experiencia, preg$experiencia$opciones)
boxplot(d$puntaje ~ exp, col = "#DD333355", border = "#DD3333",
        xlab = "", ylab = "Puntaje", ylim = c(0, length(claves)))
stripchart(d$puntaje ~ exp, vertical = TRUE, method = "jitter",
           pch = 19, col = "#333333", add = TRUE)                   # cada punto es una persona

# 5. RESPUESTAS ABIERTAS
d[c("nombre", "puntaje", "expectativas", "por_que")]
