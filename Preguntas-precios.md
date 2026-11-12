# 01 Reproducir una tabla de precios

Precios - Repaso opcional de R

¿Cuánto costaba un kilo en las ferias libres del sector Coquimbo? En este repaso opcional reconstruirás una tabla con precios al consumidor de ODEPA. El extracto de 2025 tiene 36 registros semanales de cuatro productos de primera calidad, entre julio y agosto. Cada precio promedio está en pesos chilenos por kilo.

## Pregunta 1 · Comando en R

Abre el archivo desde la raíz de TallerUDP con precios <- read.csv("_data/precios.csv", fileEncoding = "UTF-8"). La ruta relativa permitirá abrirlo aunque tu compañera descomprima el proyecto en otra carpeta.

<details>
<summary>Ver solución y pista</summary>

```r
precios <- read.csv("_data/precios.csv", fileEncoding = "UTF-8")
```

**Resultado (primeras ocho filas)**

```text
  anio mes semana             region   sector tipo_comercio      grupo
1 2025   7     27 Región de Coquimbo Coquimbo   Feria libre     Frutas
2 2025   7     27 Región de Coquimbo Coquimbo   Feria libre     Frutas
3 2025   7     27 Región de Coquimbo Coquimbo   Feria libre Hortalizas
4 2025   7     27 Región de Coquimbo Coquimbo   Feria libre Hortalizas
5 2025   7     28 Región de Coquimbo Coquimbo   Feria libre     Frutas
6 2025   7     28 Región de Coquimbo Coquimbo   Feria libre     Frutas
7 2025   7     28 Región de Coquimbo Coquimbo   Feria libre Hortalizas
8 2025   7     28 Región de Coquimbo Coquimbo   Feria libre Hortalizas
                           producto unidad precio_promedio
1              Kiwi|Hayward|Primera $/kilo        1533.333
2      Manzana|Granny Smith|Primera $/kilo        1333.333
3              Papa|Asterix|Primera $/kilo         575.000
4 Zanahoria|Sin especificar|Primera $/kilo         512.500
5              Kiwi|Hayward|Primera $/kilo        1533.333
6      Manzana|Granny Smith|Primera $/kilo        1362.500
7              Papa|Asterix|Primera $/kilo         575.000
8 Zanahoria|Sin especificar|Primera $/kilo         600.000
```

**Otras expresiones aceptadas**

```r
precios <- read.csv("_data/precios.csv")
```

**Pista**

La carpeta _data y el archivo TallerUDP.Rproj están al mismo nivel. Escribe precios <- read.csv("_data/precios.csv", fileEncoding = "UTF-8").

</details>

## Pregunta 2 · Comando en R

El extracto corresponde a 2025. Comprueba qué años aparecen realmente en la columna anio con unique().

<details>
<summary>Ver solución y pista</summary>

```r
unique(precios$anio)
```

**Resultado**

```text
[1] 2025
```

**Otras expresiones aceptadas**

```r
sort(unique(precios$anio))
```

**Pista**

Usa unique(precios$anio). Esto inspecciona todos los valores de la columna, aunque haya muchas filas del mismo año.

</details>

## Pregunta 3 · Comando en R

Antes de promediar, construye una tabla de frecuencias de grupo por mes. Usa table() con la columna grupo en las filas y mes en las columnas. Los números que verás cuentan registros de precios.

<details>
<summary>Ver solución y pista</summary>

```r
table(precios$grupo, precios$mes)
```

**Resultado**

```text

              7  8
  Frutas     10  8
  Hortalizas 10  8
```

**Otras expresiones aceptadas**

```r
with(precios, table(grupo, mes))
```

**Pista**

Escribe table(precios$grupo, precios$mes). Lee una celda como el número de filas disponibles para ese grupo durante ese mes.

</details>

## Pregunta 4 · Alternativas

La consigna pide el promedio del precio promedio por grupo y mes. La muestra no trae cantidades vendidas ni el número de cotizaciones detrás de cada fila. ¿Qué cálculo puedes defender con estos datos?

- La media aritmética de los precios promedio registrados para cada combinación de grupo y mes
- El promedio de todas las transacciones del grupo ponderadas por la cantidad que se compró en ese mes
- La variación mensual del costo de una canasta usando participaciones de gasto de los hogares

<details>
<summary>Ver solución y pista</summary>

La media aritmética de los precios promedio registrados para cada combinación de grupo y mes

**Pista**

La unidad observada es un registro con un precio promedio. En este ejercicio cada registro del grupo y mes tiene el mismo peso.

</details>

## Pregunta 5 · Comando en R

Prepara el cálculo con dplyr, del tidyverse. Agrupa precios por las dos claves grupo y mes y guarda el resultado en agrupados. El mismo mes de dos grupos distintos debe quedar separado.

<details>
<summary>Ver solución y pista</summary>

```r
agrupados <- dplyr::group_by(precios, grupo, mes)
```

**Resultado (primeras ocho filas)**

```text
  anio mes semana             region   sector tipo_comercio      grupo
1 2025   7     27 Región de Coquimbo Coquimbo   Feria libre     Frutas
2 2025   7     27 Región de Coquimbo Coquimbo   Feria libre     Frutas
3 2025   7     27 Región de Coquimbo Coquimbo   Feria libre Hortalizas
4 2025   7     27 Región de Coquimbo Coquimbo   Feria libre Hortalizas
5 2025   7     28 Región de Coquimbo Coquimbo   Feria libre     Frutas
6 2025   7     28 Región de Coquimbo Coquimbo   Feria libre     Frutas
7 2025   7     28 Región de Coquimbo Coquimbo   Feria libre Hortalizas
8 2025   7     28 Región de Coquimbo Coquimbo   Feria libre Hortalizas
                           producto unidad precio_promedio
1              Kiwi|Hayward|Primera $/kilo        1533.333
2      Manzana|Granny Smith|Primera $/kilo        1333.333
3              Papa|Asterix|Primera $/kilo         575.000
4 Zanahoria|Sin especificar|Primera $/kilo         512.500
5              Kiwi|Hayward|Primera $/kilo        1533.333
6      Manzana|Granny Smith|Primera $/kilo        1362.500
7              Papa|Asterix|Primera $/kilo         575.000
8 Zanahoria|Sin especificar|Primera $/kilo         600.000
```

**Pista**

Escribe agrupados <- dplyr::group_by(precios, grupo, mes). El operador |> también permite empezar con precios y luego agrupar.

</details>

## Pregunta 6 · Comando en R

Ahora construye tu tabla con dplyr::summarise() sobre agrupados. Guárdala en tabla con una fila por grupo y mes, una columna precio_medio con la media de precio_promedio y otra n_registros con el número de filas que aportan a la media. Conserva todos los decimales en el cálculo. Puedes usar mean() y dplyr::n().

<details>
<summary>Ver solución y pista</summary>

```r
tabla <- dplyr::summarise(agrupados, precio_medio = mean(precio_promedio), n_registros = dplyr::n(), .groups = "drop")
```

**Resultado**

```text
       grupo mes precio_medio n_registros
1     Frutas   7    1677.5000          10
2     Frutas   8    2052.6042           8
3 Hortalizas   7     565.0000          10
4 Hortalizas   8     669.7917           8
```

**Pista**

Prueba tabla <- dplyr::summarise(agrupados, precio_medio = mean(precio_promedio), n_registros = dplyr::n(), .groups = "drop"). Si obtienes una sola fila, revisa las dos claves de agrupación.

</details>

## Pregunta 7 · Comando en R

Inspecciona las medias en pesos por kilo con as.data.frame(tabla) para ver sus decimales. Elige una celda de la tabla de frecuencias anterior y comprueba si coincide con n_registros para ese grupo y mes.

<details>
<summary>Ver solución y pista</summary>

```r
as.data.frame(tabla)
```

**Resultado**

```text
       grupo mes precio_medio n_registros
1     Frutas   7    1677.5000          10
2     Frutas   8    2052.6042           8
3 Hortalizas   7     565.0000          10
4 Hortalizas   8     669.7917           8
```

**Otras expresiones aceptadas**

```r
print(as.data.frame(tabla))
```

**Pista**

Escribe as.data.frame(tabla). Al leer una media, anota el grupo y el mes de su fila.

</details>

## Pregunta 8 · Alternativas

En julio obtuviste dos medias, $1.677,50/kg en Frutas y $565,00/kg en Hortalizas. Si agrupas solo por mes y vuelves a ejecutar el código, ¿qué cambia en la tabla?

- Quedan dos filas y la media de julio mezcla los registros de frutas y hortalizas
- Quedan cuatro filas y cambia únicamente el orden en que aparecen los productos
- Quedan dos filas y cada una conserva la media anual de un grupo

<details>
<summary>Ver solución y pista</summary>

Quedan dos filas y la media de julio mezcla los registros de frutas y hortalizas

**Pista**

Julio y agosto definen dos claves distintas. Si quitas grupo de la agrupación, ambos tipos de productos entran juntos en el cálculo de cada mes.

</details>

## Pregunta 9 · Comando en R

Guarda la tabla con write.csv() en "_outputs/precios_por_grupo_y_mes.csv". Incluye row.names = FALSE para que el archivo compartido conserve solo las cuatro columnas del análisis.

<details>
<summary>Ver solución y pista</summary>

```r
write.csv(tabla, "_outputs/precios_por_grupo_y_mes.csv", row.names = FALSE)
```

**Otras expresiones aceptadas**

```r
utils::write.csv(tabla, "_outputs/precios_por_grupo_y_mes.csv", row.names = FALSE)
```

**Pista**

Escribe write.csv(tabla, "_outputs/precios_por_grupo_y_mes.csv", row.names = FALSE). El CSV de entrada queda disponible para otra ejecución.

</details>

## Pregunta 10 · Comando en R

Si a tu compañera le aparece otra versión de un paquete, necesitará saber con qué entorno corriste el análisis. Ejecuta sessionInfo() y busca la versión de R y la de dplyr entre los paquetes cargados.

<details>
<summary>Ver solución y pista</summary>

```r
sessionInfo()
```

**Resultado**

```text
R version 4.4.1 (2024-06-14 ucrt)
Platform: x86_64-w64-mingw32/x64
Running under: Windows 11 x64 (build 26200)

Matrix products: default


locale:
[1] LC_COLLATE=English_United States.utf8
[2] LC_CTYPE=English_United States.utf8
[3] LC_MONETARY=English_United States.utf8
[4] LC_NUMERIC=C
[5] LC_TIME=English_United States.utf8

time zone: America/Santiago
tzcode source: internal

attached base packages:
[1] stats     graphics  grDevices datasets  utils     methods   base

loaded via a namespace (and not attached):
 [1] digest_0.6.39    R6_2.6.1         tidyselect_1.2.1 swirl_2.4.5
 [5] magrittr_2.0.5   glue_1.8.1       stringr_1.6.0    tibble_3.3.1
 [9] RCurl_1.98-1.20  pkgconfig_2.0.3  generics_0.1.4   dplyr_1.2.1
[13] lifecycle_1.0.5  bitops_1.1-0     cli_3.6.6        vctrs_0.7.3
[17] renv_1.3.0       testthat_3.3.2   compiler_4.4.1   httr_1.4.9
[21] tools_4.4.1      brio_1.1.5       pillar_1.11.1    yaml_2.3.12
[25] otel_0.2.0       rlang_1.3.0      stringi_1.8.9
```

**Otras expresiones aceptadas**

```r
utils::sessionInfo()
```

**Pista**

Escribe sessionInfo(). Esta función describe la sesión actual. El proyecto también incluye renv.lock para que tu compañera pueda restaurar las versiones.

</details>

## Pregunta 11 · Comando en R

Genera el árbol del proyecto. La función rutas_del_taller() reúne las rutas de datos, resultados, bibliografía y figuras de TallerUDP. Pásala a data.tree::as.Node() y localiza allí el CSV de entrada y el de salida.

<details>
<summary>Ver solución y pista</summary>

```r
data.tree::as.Node(rutas_del_taller())
```

**Resultado**

```text
                             levelName
1  TallerUDP
2   ¦--_data
3   ¦   ¦--FUENTE.md
4   ¦   °--precios.csv
5   ¦--_doc
6   ¦--_figures
7   ¦--_hist
8   ¦--_lib
9   ¦--_lit
10  ¦--_outputs
11  ¦   °--precios_por_grupo_y_mes.csv
12  ¦--analisis.R
13  ¦--iniciar.R
14  ¦--README.md
15  ¦--renv.lock
16  °--TallerUDP.Rproj
```

**Otras expresiones aceptadas**

```r
print(data.tree::as.Node(rutas_del_taller()))
```

**Pista**

Escribe data.tree::as.Node(rutas_del_taller()). Busca precios.csv bajo _data y precios_por_grupo_y_mes.csv bajo _outputs. Guarda una captura de ese árbol.

</details>

## Pregunta 12 · Alternativas

Al intercambiar proyectos, tu compañera abre el .Rproj y ejecuta renv::restore(), pero el script que escribió su pareja intenta leer C:/Users/docente/Desktop/precios.csv. ¿Qué corrección servirá a cualquier compañero que descomprima el proyecto completo?

- Leer _data/precios.csv desde la raíz del proyecto
- Cambiar esa ruta por la ruta absoluta del equipo que recibió el ZIP
- Ejecutar renv::snapshot() en el nuevo equipo antes de volver a leer el CSV

<details>
<summary>Ver solución y pista</summary>

Leer _data/precios.csv desde la raíz del proyecto

**Pista**

renv::restore() recupera paquetes. La ubicación de los datos depende de la ruta del script. Piensa qué parte de la ruta sigue siendo igual después de descomprimir.

</details>

## Pregunta 13 · Alternativas

Tu compañera obtiene los mismos valores con tu archivo de 2025 y tu código. Después aplica el procedimiento a datos recogidos en otro año para comprobar si se mantiene un patrón entre grupos. ¿Qué pregunta responde cada paso?

- El primero comprueba la reproducibilidad de la tabla y el segundo investiga la replicabilidad del patrón con datos nuevos
- El primero comprueba la replicabilidad entre computadores y el segundo reproduce la tabla original
- Ambos reproducen la tabla original porque usan la misma función de agrupación

<details>
<summary>Ver solución y pista</summary>

El primero comprueba la reproducibilidad de la tabla y el segundo investiga la replicabilidad del patrón con datos nuevos

**Pista**

El primer paso recupera el resultado numérico original. El segundo examina si una conclusión se sostiene con observaciones nuevas. Los precios de otro año pueden cambiar.

</details>

Puedes comprobar el resultado cuando quieras. Abre TallerUDP.Rproj y ejecuta source("analisis.R") desde la raíz del proyecto. Compara las cuatro filas que genera el script con tu tabla. Las medias describen esas ferias y esos productos. Para estudiar precios nacionales haría falta otra cobertura.

Para cerrar este repaso personal, piensa en una decisión que facilitó repetir el cálculo. ¿Qué pasaría con las medias si el año siguiente algunos precios vinieran por unidad en lugar de por kilo? Para continuar con el ejercicio principal, elige «ENSSEX Ayuda para el ejercicio» en el menú de cursos. Si SWIRL te ofrece reanudar una lección, elige «No. Déjame iniciar con algo nuevo.» para ver los cursos.
