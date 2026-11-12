<!-- inicio: 00estructura_proyecto.R -->
# Reproducibilidad y Comunicación de Resultados · UDP 2026

## Antes de la primera clase

[Responder la encuesta diagnóstica de R](https://01a10334-b601-4f38-05a8-061a7664f1d3.share.connect.posit.cloud/) (aprox. 5 minutos).

## Abrir este proyecto en otro equipo

1. Instala R 4.4.1 y abre `repr2026.Rproj` en RStudio.
2. En la consola de R, ejecuta `renv::restore()`.
3. Comprueba con `renv::status()` que la biblioteca coincide con `renv.lock`.

## Crear tu propio proyecto

1. En RStudio, usa **File > New Project > New Directory > New Project**.
2. Usa un nombre que empiece con una letra ASCII. Puedes añadir letras ASCII, números y puntos. Termina con una letra o un número.
3. Copia `00estructura_proyecto.R` a la raíz, junto al archivo `.Rproj`, y edita solo la sección 1.
4. En la consola, ejecuta `source("00estructura_proyecto.R", encoding = "UTF-8")`.

El script inicializa la biblioteca con `renv::init()`, fija los paquetes al 2026-10-03 y registra sus versiones con `renv::snapshot()`. `renv::isolate()` deja una copia de los paquetes en el proyecto. El informe de la sesión queda en [`_doc/entorno.txt`](_doc/entorno.txt).

## Estructura

```text
repr2026
 |--_data
 |--_doc
 |   `--entorno.txt
 |--_figures
 |--_hist
 |--_lib
 |--_lit
 |--_outputs
 |--00estructura_proyecto.R
 |--DESCRIPTION
 |--README.md
 |--renv
 |--renv.lock
 `--repr2026.Rproj
```

## Material de clase

- [Ejemplo en Google Colab](https://colab.research.google.com/drive/1uHuQvINVgw1l__oTZHG_O5zXJ7NR0wpY?usp=sharing)
- [Proyecto en Posit Cloud](https://posit.cloud/content/13059382)
- [Script explicado en Posit Connect](https://agonzalezsc-udp-00estructura-proyecto.share.connect.posit.cloud/)
- [Clases de 2024 (AGSCL)](https://github.com/AGSCL/repr)
- [Clases de 2025 (JoseRTM)](https://github.com/JoseRTM/Reproducibilidad-UDP/)
<!-- fin: 00estructura_proyecto.R -->
