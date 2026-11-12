rutas_del_taller <- function() {
  carpetas <- c("_data", "_doc", "_figures", "_hist", "_lib", "_lit", "_outputs")
  archivos <- c("TallerUDP.Rproj", "README.md", "iniciar.R", "analisis.R", "renv.lock")
  rutas <- c(carpetas, list.files(carpetas, full.names = TRUE), archivos)
  data.frame(pathString = file.path("TallerUDP", sort(unique(rutas[file.exists(rutas)]))))
}
