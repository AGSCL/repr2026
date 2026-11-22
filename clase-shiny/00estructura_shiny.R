# 00estructura_shiny.R: ordena el repositorio de su app como un compendio (paso 2)
# 1. PAQUETES QUE USA LA APP (los del paso 1; no hay que editar nada)
paquetes <- c("shiny", "rsconnect")
# 2. COMPROBAR antes de escribir archivos
if (nzchar(Sys.getenv("RENV_PROJECT")))      # hay un proyecto con renv abierto
  stop("Cierre el proyecto: File > Close Project")
if (!dir.exists(".git"))                     # .git marca la carpeta del repositorio
  stop("Session > Set Working Directory > To Source File Location")
faltan <- setdiff(paquetes, rownames(installed.packages()))   # paquetes sin instalar
if (length(faltan) > 0) stop("Primero instale (paso 1): ", paste(faltan, collapse = ", "))
# 3. CARPETAS
dir.create("app", showWarnings = FALSE)      # la app vive sola aqui: es lo que se publica
dir.create("_doc", showWarnings = FALSE)     # documentacion del entorno
# 4. DESCRIPTION: autoria y paquetes (repositorio publico: sin datos personales)
writeLines(c(
  "Type: Project",
  "Title: App Shiny del curso Reproducibilidad (UDP 2026)",
  'Authors@R: person("SU-USUARIO", role = c("aut", "cre"))',   # marcador: no identifica a nadie
  paste("Imports:", paste(paquetes, collapse = ", "))
), "DESCRIPTION")
# 5. renv.lock: versiones de R y de cada paquete, como en la clase 1
options(renv.consent = TRUE)                 # renv no pregunta la primera vez
renv::snapshot(type = "explicit",            # registra lo que dice Imports en DESCRIPTION
               library = .libPaths(),        # lee los paquetes ya instalados: no activa renv
               prompt = FALSE)
# 6. ENTORNO: sistema operativo, version de R e idioma del computador
writeLines(capture.output(sessionInfo()), "_doc/entorno.txt")
# 7. README: solo si sigue como lo creo GitHub Desktop (no borra lo que usted escribio)
if (!file.exists("README.md") || length(readLines("README.md")) < 3) {
  writeLines(c(
    paste("#", basename(getwd())), "",            # nombre del repositorio
    "App Shiny del curso Reproducibilidad (UDP 2026).", "",
    "| Archivo | Que contiene |",
    "| --- | --- |",
    "| `app/app.R` | La app |",
    "| `app/manifest.json` | Version de R y paquetes para Connect Cloud (paso 10) |",
    "| `renv.lock` | Version de R y paquetes del computador donde se creo |",
    "| `DESCRIPTION` | Autoria y paquetes |",
    "| `_doc/entorno.txt` | Sistema operativo e idioma |"
  ), "README.md")
}
# 8. COMPROBAR que todo quedo
stopifnot(dir.exists("app"), file.exists("DESCRIPTION", "renv.lock", "README.md", "_doc/entorno.txt"))
message("Listo. Siga con el paso 3: guarde app.R dentro de la carpeta app.")
