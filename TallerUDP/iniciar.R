if (!interactive()) stop("Abre TallerUDP.Rproj y ejecuta este archivo en la consola de R.")
if (!file.exists("TallerUDP.Rproj")) stop("Abre TallerUDP.Rproj desde la carpeta descomprimida.")

# La primera vez descarga los paquetes fijados; en sesiones posteriores usa la biblioteca local.
renv::restore(prompt = FALSE)
dir.create(".progreso", showWarnings = FALSE)
options(swirl_courses_dir = normalizePath("cursos"),
        swirl_data_dir = normalizePath(".progreso"),
        swirl_language = "spanish", swirl_logging = FALSE)
library(swirl)
source("cursos/ENSSEX_Ayuda_para_el_ejercicio/01_Antes_de_abrir_el_proyecto/initLesson.R", encoding = "UTF-8")
message("Primera visita: escribe swirl() en la consola. Para volver al menú ENSSEX, escribe consultas_enssex().")
