# Solución de referencia para reproducir la tabla después del taller.
precios <- read.csv("_data/precios.csv", fileEncoding = "UTF-8")
stopifnot(nrow(precios) > 0L, all(precios$anio == 2025), !anyNA(precios$precio_promedio),
          length(unique(precios$unidad)) == 1L)
agrupados <- dplyr::group_by(precios, grupo, mes)
tabla <- dplyr::summarise(agrupados, precio_medio = mean(precio_promedio),
                          n_registros = dplyr::n(), .groups = "drop")
write.csv(tabla, "_outputs/precios_por_grupo_y_mes.csv", row.names = FALSE)
