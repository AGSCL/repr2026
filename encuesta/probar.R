# Al ejecutar este archivo se prueba en memoria el contenido que se enviaria.
source("app.R", encoding = "UTF-8")
marca <- paste0("PRUEBA-UDP-", cohorte, "-", format(Sys.time(), "%Y%m%d-%H%M%S"))

ficticio <- "Simulaci\u00f3n Ficticia"
fila <- data.frame(fecha = "2026-01-01 12:00", nombre = ficticio, expectativas = marca)
json <- json_respuesta(fila)
salida <- jsonlite::fromJSON(json)
stopifnot(!grepl(ficticio, json, fixed = TRUE),
          grepl("^hmac256:[a-f0-9]{64}$", salida$nombre),
          salida$nombre == hash_nombre("  SIMULACIO\u0301N\u00a0 FICTICIA  "),
          salida$nombre != hash_nombre("Otra simulaci\u00f3n"),
          isTRUE(salida$es_prueba), identical(tail(names(salida), 2), c("cohorte", "es_prueba")))
fila$nombre <- " "
fila$expectativas <- "Aprender a organizar un proyecto"
anonima <- jsonlite::fromJSON(json_respuesta(fila))
stopifnot(identical(anonima$nombre, ""), identical(anonima$es_prueba, FALSE))

# Para una prueba de punta a punta, use este marcador en expectativas, no en nombre.
message("Marcador para expectativas: ", marca)
confirmar_prueba <- function(marcador) {
  d <- read.csv(csv, fileEncoding = "UTF-8", colClasses = "character", na.strings = character())
  fila <- which(d$expectativas == marcador & d$cohorte == cohorte &
                tolower(d$es_prueba) %in% c("true", "1", "verdadero"))
  stopifnot(length(fila) == 1L, nzchar(d$fecha[fila]),
            d$nombre[fila] == "" || grepl("^hmac256:[0-9a-f]{64}$", d$nombre[fila]))
  message("Prueba confirmada en Google Sheets, fila ", fila + 1L, ".")
}
