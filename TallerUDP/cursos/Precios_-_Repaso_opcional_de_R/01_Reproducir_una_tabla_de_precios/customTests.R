# swirl entrega la expresión evaluada y su valor en el entorno e.
asignacion_a <- function(expr, nombre) {
  is.call(expr) && length(expr) == 3L &&
    (identical(expr[[1L]], as.name("<-")) || identical(expr[[1L]], as.name("="))) &&
    identical(expr[[2L]], as.name(nombre))
}

grupos_correctos <- function() {
  e <- get("e", parent.frame())
  if (!asignacion_a(e$expr, "agrupados") || !inherits(e$val, "grouped_df") ||
      !setequal(dplyr::group_vars(e$val), c("grupo", "mes"))) return(FALSE)

  original <- e$snapshot$precios
  actual <- as.data.frame(e$val)
  if (!setequal(names(actual), names(original)) || nrow(actual) != nrow(original)) return(FALSE)
  actual <- actual[names(original)]
  if (!identical(vapply(actual, typeof, ""), vapply(original, typeof, ""))) return(FALSE)
  ordenar <- function(x) {
    x <- x[do.call(order, unname(as.list(x))), , drop = FALSE]
    rownames(x) <- NULL
    x
  }
  identical(ordenar(actual), ordenar(original))
}

tabla_correcta <- function() {
  e <- get("e", parent.frame())
  if (!asignacion_a(e$expr, "tabla") ||
      !any(c("summarise", "summarize") %in% all.names(e$expr)) ||
      !is.data.frame(e$val)) return(FALSE)

  columnas <- c("grupo", "mes", "precio_medio", "n_registros")
  if (anyDuplicated(names(e$val)) || !setequal(names(e$val), columnas)) return(FALSE)
  precios <- e$snapshot$precios
  ref <- stats::aggregate(precio_promedio ~ grupo + mes, precios, mean)
  ref$n_registros <- as.integer(stats::aggregate(precio_promedio ~ grupo + mes,
                                                  precios, length)$precio_promedio)
  names(ref)[3L] <- "precio_medio"
  limpiar <- function(x) {
    x <- as.data.frame(x)[order(as.character(x$grupo), x$mes), columnas]
    rownames(x) <- NULL
    x
  }
  isTRUE(all.equal(limpiar(e$val), limpiar(ref), tolerance = 1e-8,
                   check.attributes = FALSE))
}
