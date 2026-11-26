# revisar_taller.R: herramienta docente. Revisa el ZIP de una entrega del taller sin abrir el proyecto.
# Uso: source("_lib/revisar_taller.R"); revisar_taller("C:/ruta/entrega.zip")
revisar_taller <- function(zip) {
  lista <- utils::unzip(zip, list = TRUE)                       # contenido del ZIP, sin extraer
  paquetes <- grepl("renv/library/", lista$Name, fixed = TRUE)  # paquetes instalados que no debian venir
  destino <- tempfile("entrega-")
  utils::unzip(zip, files = lista$Name[!paquetes], exdir = destino)
  qmd_ruta <- list.files(destino, "^informe[.]qmd$", recursive = TRUE, full.names = TRUE)[1]
  if (is.na(qmd_ruta)) stop("El ZIP no trae informe.qmd")
  raiz <- dirname(qmd_ruta)                                     # sirve aunque el ZIP traiga una carpeta adentro
  esta <- function(...) all(file.exists(file.path(raiz, c(...))))
  fecha <- function(nombre) max(lista$Date[basename(lista$Name) == nombre], as.POSIXct(NA), na.rm = TRUE)
  qmd <- readLines(qmd_ruta, encoding = "UTF-8", warn = FALSE)
  base <- file.path(raiz, "_data/elsoc_long.RData")
  revision <- c(
    "La base esta en _data y es la original"      = file.exists(base) &&
      identical(unname(tools::md5sum(base)), "780cc68dbbd75336d7600015c166f565"),
    "Estan los nombres de la pareja"              = !any(grepl("Nombre Apellido", qmd, fixed = TRUE)),
    "Los tres textos estan escritos"              = !any(grepl("ESCRIBA AQU", qmd, fixed = TRUE)),
    "No quedan espacios ______ en informe.qmd"    = !any(grepl("______", qmd, fixed = TRUE)),
    "informe.html no es anterior a informe.qmd"   = esta("informe.html") && fecha("informe.html") >= fecha("informe.qmd"),
    "La tabla y el grafico estan guardados"       = esta("_outputs/tabla.csv", "_figures/grafico.png"),
    "El entorno esta documentado"                 = esta("00estructura_taller.R", "renv.lock", "DESCRIPTION", "README.md",
                                                         "_doc/entorno.txt", "renv/activate.R"),
    "No viene la carpeta renv/library"            = !any(paquetes)
  )
  print(data.frame(listo = ifelse(revision, "SI", "NO")))
  cat(sprintf("ZIP de %.1f MB con %d archivos. Extraido en %s\n", file.size(zip) / 1e6, nrow(lista), raiz))
  if (esta("_outputs/tabla.csv"))                               # para comparar con la pauta
    print(read.csv(file.path(raiz, "_outputs/tabla.csv"), check.names = FALSE))
  invisible(raiz)                                               # carpeta lista para renv::restore() y Render
}
