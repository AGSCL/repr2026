# 1. Datos del proyecto. Editar solo esta sección.
titulo   <- "Reproducibilidad y Comunicación de Resultados · UDP 2026"
nombre   <- "Andrés"
apellido <- "González Santa Cruz"
correo   <- "37744754+AGSCL@users.noreply.github.com"
fecha    <- "2026-10-03"
encuesta <- "https://01a10334-b601-4f38-05a8-061a7664f1d3.share.connect.posit.cloud/"
paquetes <- c("renv", "data.tree", "here")
carpetas <- c("_data", "_doc", "_figures", "_hist", "_lib", "_lit", "_outputs")

# 2. Comprobar el proyecto antes de escribir archivos o instalar paquetes.
rproj <- list.files(pattern = "[.]Rproj$", all.files = TRUE)
if (length(rproj) != 1L || dir.exists(rproj)) {
  stop("Abre la raíz de un proyecto de R. Para crear uno: File > New Project > New Directory.")
}
proyecto <- sub("[.]Rproj$", "", rproj)
if (!grepl("^[A-Za-z]([A-Za-z0-9.]*[A-Za-z0-9])?$", proyecto, perl = TRUE)) {
  stop("Nombre de proyecto inválido: usa letras ASCII, números y puntos. ",
       "Comienza con una letra y termina con una letra o un número.")
}

# 3. Carpetas y autoría.
for (carpeta in carpetas) {
  if (!dir.exists(carpeta) && !dir.create(carpeta)) stop("No se pudo crear ", carpeta)
  marca <- file.path(carpeta, ".gitkeep")
  if (!file.exists(marca)) stopifnot(file.create(marca))
}
autor <- as.call(list(as.name("person"), nombre, apellido, email = correo,
                      role = quote(c("aut", "cre"))))
ficha <- c(Package = proyecto, Type = "Project", Title = titulo, Version = "0.1.0",
           "Authors@R" = paste(deparse(autor), collapse = " "), Encoding = "UTF-8",
           Imports = paste(paquetes, collapse = ", "))
if (file.exists("DESCRIPTION")) {
  anterior <- read.dcf("DESCRIPTION")[1, ]
  if (identical(unname(anterior["Encoding"]), "UTF-8")) Encoding(anterior) <- "UTF-8"
  ficha <- c(ficha, anterior[setdiff(names(anterior), names(ficha))])
}
ficha[] <- enc2utf8(ficha)
write.dcf(as.data.frame(as.list(ficha), check.names = FALSE), "DESCRIPTION", useBytes = TRUE)

# 4. Instalar desde la fecha de la clase o restaurar las versiones ya registradas.
repos <- c(CRAN = paste0("https://packagemanager.posit.co/cran/", fecha))
options(repos = repos, renv.consent = TRUE)
if (!file.exists("renv/activate.R")) {
  biblioteca <- tempfile("renv-")
  dir.create(biblioteca)
  utils::install.packages("renv", lib = biblioteca, repos = repos)
  .libPaths(c(biblioteca, .libPaths()))
  renv::init(bare = TRUE, restart = FALSE, repos = repos,
             settings = list(snapshot.type = "explicit", use.cache = FALSE))
} else {
  source("renv/activate.R")
}
options(repos = repos)
lock <- if (file.exists("renv.lock")) renv::lockfile_read("renv.lock")
if (is.null(lock)) {
  renv::install(packages = paquetes, repos = repos, prompt = FALSE)
} else if (identical(lock$R$Repositories$CRAN, unname(repos)) &&
           all(paquetes %in% names(lock$Packages))) {
  renv::restore(prompt = FALSE)
} else {
  renv::checkout(repos = repos, packages = paquetes, restart = FALSE)
}
lock <- renv::snapshot(type = "explicit", repos = repos, lockfile = NULL, prompt = FALSE)
# Algunos binarios de Posit declaran «latest» aun cuando se bajaron de la fecha fijada.
for (p in names(lock$Packages)) {
  if (identical(lock$Packages[[p]]$Source, "Repository")) lock$Packages[[p]]$Repository <- "CRAN"
}
renv::lockfile_write(lock, file = "renv.lock")
renv::isolate()

# 5. Guardar el entorno que realmente usó R.
here::i_am(rproj)
raiz <- here::here()
sincronizado <- renv::status()$synchronized
stopifnot(identical(normalizePath(raiz), normalizePath(getwd())), isTRUE(sincronizado))
entorno <- data.frame(
  dato = c("Proyecto", "Fecha del repositorio", "R", "Plataforma",
           "Codificación UTF-8", "renv.lock al día"),
  valor = c(raiz, fecha, R.version.string, R.version$platform,
            l10n_info()[["UTF-8"]], sincronizado)
)
pk <- sort(unique(c(loadedNamespaces(), names(lock$Packages))))
detalle <- data.frame(
  paquete = pk,
  version = vapply(pk, function(p) as.character(utils::packageVersion(p)), ""),
  origen = vapply(pk, function(p) {
    d <- utils::packageDescription(p)
    c(d$Repository, d$Priority, d$RemoteType, "local")[1L]
  }, ""),
  libreria = vapply(pk, function(p) dirname(find.package(p)), "")
)
en_proyecto <- startsWith(detalle$libreria, paste0(raiz, "/"))
detalle$libreria[en_proyecto] <- substring(detalle$libreria[en_proyecto], nchar(raiz) + 2L)
tabla <- function(x) c(paste(names(x), collapse = "\t"), do.call(paste, c(x, sep = "\t")))
informe <- c(tabla(entorno), "", tabla(detalle))
writeLines(enc2utf8(informe), "_doc/entorno.txt", useBytes = TRUE)

# 6. Actualizar el bloque generado del README y conservar el texto agregado por el curso.
rutas <- sort(unique(c(list.files(), "README.md", "_doc/entorno.txt")))
nodo <- data.tree::as.Node(data.frame(pathString = file.path(proyecto, rutas)))
arbol <- trimws(data.tree::ToDataFrameTree(nodo)$levelName, which = "right")
arbol <- gsub("\u00a6|<U[+]00A6>", "|", arbol)
arbol <- gsub("\u00b0|<U[+]00B0>", "`", arbol)
inicio <- "<!-- inicio: 00estructura_proyecto.R -->"
fin <- "<!-- fin: 00estructura_proyecto.R -->"
bloque <- c(inicio, paste("#", titulo), "",
  "## Antes de la primera clase", "",
  paste0("[Responder la encuesta diagnóstica de R](", encuesta, ") (aprox. 5 minutos)."), "",
  "[Código de la encuesta Shiny y guardado en Google Sheets](https://github.com/AGSCL/repr2026/tree/main/encuesta).", "",
  "## Taller de la clase 1", "",
  "[Material de clase 2026 (PDF)](https://github.com/AGSCL/repr2026/blob/main/2026-1%20Reproducibilidad.pdf) · [Enunciado original del ejercicio ENSSEX](https://github.com/AGSCL/repr2026/blob/main/Enunciado-ENSSEX.md).",
  "",
  "Calcula los cuatro porcentajes de la base ENSSEX que recibiste. Intercambia el proyecto con un compañero. Al abrir el suyo, anota cuántas líneas tuviste que cambiar y compara tus cuatro resultados con los que obtuvo él usando esa misma base y los mismos decimales.",
  "",
  "**Apoyo opcional en RStudio.** [Descarga los dos recorridos SWIRL en un solo ZIP](https://github.com/AGSCL/repr2026/raw/refs/heads/main/TallerUDP.zip).",
  "",
  "Descomprime el ZIP, abre `TallerUDP.Rproj` y ejecuta `source(\"iniciar.R\", encoding = \"UTF-8\")` en la consola. Cuando vuelva a aparecer `>`, escribe `swirl()`. La primera instalación requiere internet.", "",
  "- **ENSSEX** explica el intercambio de proyectos. Después de una pregunta puedes consultar el ZIP, una ruta que falla, el libro de códigos, la comparación de porcentajes o la reflexión final. Al volver otro día, ejecuta el iniciador y escribe `consultas_enssex()` para ir directo al menú.",
  "- **Precios** es un repaso opcional de R con datos de ODEPA. Puedes comenzar por la consola o ir directamente a leer el CSV y reproducir una tabla.",
  "",
  "[Cómo usar SWIRL, paso a paso](https://github.com/AGSCL/repr2026/blob/main/TallerUDP/README.md) · [Vista docente de las preguntas, alternativas y pistas](https://github.com/AGSCL/repr2026/blob/main/Preguntas-clase1.md).",
  "",
  "## Abrir este proyecto en otro equipo", "",
  sprintf("1. Instala R %s y abre `%s` en RStudio.", lock$R$Version, rproj),
  "2. En la consola de R, ejecuta `renv::restore()`.",
  "3. Comprueba con `renv::status()` que la biblioteca coincide con `renv.lock`.", "",
  "## Crear tu propio proyecto", "",
  "1. En RStudio, usa **File > New Project > New Directory > New Project**.",
  "2. Usa un nombre que empiece con una letra ASCII. Puedes añadir letras ASCII, números y puntos. Termina con una letra o un número.",
  "3. Copia `00estructura_proyecto.R` a la raíz, junto al archivo `.Rproj`, y edita solo la sección 1.",
  '4. En la consola, ejecuta `source("00estructura_proyecto.R", encoding = "UTF-8")`.', "",
  paste0("El script inicializa la biblioteca con `renv::init()`, fija los paquetes al ",
         fecha, " y registra sus versiones con `renv::snapshot()`. ",
         "`renv::isolate()` deja una copia de los paquetes en el proyecto. ",
         "El informe de la sesión queda en [`_doc/entorno.txt`](_doc/entorno.txt)."), "",
  "## Estructura", "",
  "El PDF, el enunciado, la descarga del taller y las guías de preguntas están en la raíz. `TallerUDP/` contiene el proyecto de práctica y `encuesta/` el código de Shiny.", "",
  "- `_data/`: datos de entrada, CSV y ejemplos.",
  "- `_outputs/`: tablas, documentos y otros resultados generados.",
  "- `_figures/`: figuras como PNG y SVG.",
  "- `_lit/`: bibliografía.",
  "- `_hist/`: versiones anteriores.",
  "- `_lib/`: estilos y archivos de apoyo, como CSS o YAML.",
  "- `_doc/`: documentación del proyecto y del entorno.", "",
  "```text", arbol, "```", "",
  "## Material de clase", "",
  "- [Ejemplo en Google Colab](https://colab.research.google.com/drive/1uHuQvINVgw1l__oTZHG_O5zXJ7NR0wpY?usp=sharing)",
  "- [Proyecto en Posit Cloud](https://posit.cloud/content/13059382)",
  "- [Script explicado en Posit Connect](https://agonzalezsc-udp-00estructura-proyecto.share.connect.posit.cloud/)",
  "- [Clases de 2024 (AGSCL)](https://github.com/AGSCL/repr)",
  "- [Clases de 2025 (JoseRTM)](https://github.com/JoseRTM/Reproducibilidad-UDP/)", fin)
previo <- if (file.exists("README.md")) readLines("README.md", encoding = "UTF-8") else character()
i <- which(previo == inicio)
j <- which(previo == fin)
if (!length(i) && !length(j)) {
  nuevo <- c(bloque, if (length(previo)) "", previo)
} else {
  stopifnot(length(i) == 1L, length(j) == 1L, i < j)
  nuevo <- c(head(previo, i - 1L), bloque, tail(previo, length(previo) - j))
}
writeLines(enc2utf8(nuevo), "README.md", useBytes = TRUE)
message("Proyecto listo. Revisa README.md y _doc/entorno.txt.")
