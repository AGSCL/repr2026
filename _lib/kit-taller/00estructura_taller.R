# 00estructura_taller.R: prepara el compendio del taller (paso 2). Complete las dos INSTRUCCIONES.
# 1. PAQUETES, fecha que fija sus versiones y CARPETAS
# INSTRUCCION 1 = El informe usa dplyr y ggplot2. Complete el vector con esos dos paquetes.
paquetes <- c("renv", "______", "______", "knitr", "rmarkdown")
fecha    <- "2026-10-03"                       # la misma fecha de la clase 1
# INSTRUCCION 2 = Lea el README de la seccion 7. Que cuatro carpetas debe crear?
carpetas <- c("______", "______", "______", "______")
# 2. COMPROBAR antes de escribir archivos o instalar paquetes
if (!file.exists("TallerELSOC.Rproj")) stop("Abra el proyecto con doble clic en TallerELSOC.Rproj y ejecute de nuevo.")
if (any(grepl("___", c(paquetes, carpetas)))) stop("Complete las dos INSTRUCCIONES de la seccion 1.")
# 3. CARPETAS del compendio
for (carpeta in carpetas) dir.create(carpeta, showWarnings = FALSE)
# 4. DESCRIPTION: que es el proyecto y que paquetes usa (sin datos personales)
writeLines(c("Package: TallerELSOC", "Type: Project", "Version: 0.1.0", "Encoding: UTF-8",
             "Title: Taller evaluado ELSOC, curso Reproducibilidad (UDP 2026)",
             paste("Imports:", paste(paquetes, collapse = ", "))), "DESCRIPTION")
# 5. RENV: biblioteca propia del proyecto, con los paquetes de la fecha fijada (como en la clase 1)
repos <- c(CRAN = paste0("https://packagemanager.posit.co/cran/", fecha))
options(repos = repos, renv.consent = TRUE)    # renv no pregunta la primera vez
if (!file.exists("renv/activate.R")) {         # primera vez: instala renv y crea la biblioteca
  biblioteca <- tempfile("renv-")
  dir.create(biblioteca)
  utils::install.packages("renv", lib = biblioteca, repos = repos)
  .libPaths(c(biblioteca, .libPaths()))
  renv::init(bare = TRUE, restart = FALSE, repos = repos, settings = list(snapshot.type = "explicit", use.cache = FALSE))
} else source("renv/activate.R")               # ya existia: solo la activa
options(repos = repos)
lock <- if (file.exists("renv.lock")) renv::lockfile_read("renv.lock")
if (!is.null(lock) && all(paquetes %in% names(lock$Packages))) {
  renv::restore(prompt = FALSE)                # con renv.lock: instala exactamente lo registrado
} else renv::install(packages = paquetes, repos = repos, prompt = FALSE)   # sin renv.lock: los de la fecha
lock <- renv::snapshot(type = "explicit", repos = repos, lockfile = NULL, prompt = FALSE)
for (p in names(lock$Packages)) {              # algunos binarios de Posit declaran "latest"
  if (identical(lock$Packages[[p]]$Source, "Repository")) lock$Packages[[p]]$Repository <- "CRAN"
}
renv::lockfile_write(lock, file = "renv.lock") # versiones de R y de cada paquete
# 6. ENTORNO: sistema operativo, version de R e idioma del computador
writeLines(capture.output(sessionInfo()), "_doc/entorno.txt")
# 7. README: como instalar las dependencias y ejecutar el proyecto
writeLines(c("# Taller evaluado ELSOC", "",
  "Compendio reproducible del curso Reproducibilidad y Comunicacion de Resultados (UDP 2026).", "",
  "## Como reproducir este informe", "",
  paste0("1. Instale R (este proyecto se hizo con R ", lock$R$Version, ") y RStudio."),
  "2. Descomprima el ZIP y abra `TallerELSOC.Rproj`.",
  "3. En la consola, ejecute `renv::restore()`: instala los paquetes con las versiones de `renv.lock`.",
  "4. Abra `informe.qmd` y presione **Render**.", "",
  "## Datos", "",
  "`_data/elsoc_long.RData`: ELSOC (COES), olas 2016 a 2019, formato largo.",
  "Se bajo de <https://github.com/elsoc-coes/elsoc_ggplot/tree/master/1_input/data>.", "",
  "## Estructura", "",
  "- `informe.qmd` e `informe.html`: el informe y su version renderizada.",
  "- `_data/`: la base de datos, tal como se bajo.",
  "- `_outputs/`: la tabla del informe, `tabla.csv`.",
  "- `_figures/`: el grafico del informe, `grafico.png`.",
  "- `_doc/`: `entorno.txt`, con el sistema operativo, la version de R y el idioma.",
  "- `DESCRIPTION`, `renv.lock`, `renv/` y `.Rprofile`: paquetes, versiones y su activacion."), "README.md")
# 8. COMPROBAR que todo quedo
stopifnot(file.exists("DESCRIPTION", "renv.lock", "README.md", "_doc/entorno.txt"), paquetes %in% rownames(installed.packages()))
message("Listo. Siga con el paso 3: baje la base y guardela en la carpeta de datos.")
