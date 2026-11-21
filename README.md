<!-- inicio: 00estructura_proyecto.R -->
# Reproducibilidad y Comunicación de Resultados · UDP 2026

## Clase 3- Apoyo de Git y GitHub

[Diapositivas y ejercicio paso a paso](https://agscl.github.io/repr2026/clase-git/) · [PDF](https://agscl.github.io/repr2026/clase-git/clase-git.pdf) · [Kit ENSSEX del ejercicio (ZIP)](https://github.com/AGSCL/repr2026/raw/refs/heads/main/clase-git/kit-enssex.zip).

[Abrir el taller en el navegador](https://agscl.github.io/repr2026/_outputs/taller-git-autocontenido/index.html) · [Descargar el taller en ZIP](https://agscl.github.io/repr2026/_outputs/taller-git-autocontenido.zip).

Complemento de la clase del jueves 19 de noviembre de 2026 (18:00–21:30). Practica una acción a la vez: abrir, cambiar, guardar una versión, sincronizar o recuperar. La simulación no ejecuta Git ni confirma trabajo en RStudio.

El ZIP contiene solo `index.html`. Descomprímelo y ábrelo con doble clic. Para publicarlo, sube ese archivo a la carpeta que uses como origen de GitHub Pages. No requiere R, Shiny, instalación ni servidor para abrirlo en tu equipo.

Las notas y los estados quedan en ese navegador. Usa **Exportar** antes de cambiar de equipo, navegador o ubicación del HTML; usa **Importar** para recuperarlos. Las vistas docentes y el registro de comprobaciones están dentro de la aplicación.

## Shiny: de una tabla a una app

[Diapositivas con editor en vivo y pasos para publicar](https://agscl.github.io/repr2026/clase-shiny/) · [PDF](https://agscl.github.io/repr2026/clase-shiny/clase-shiny.pdf) · [Código de la app](https://github.com/AGSCL/repr2026/blob/main/_lib/kit-shiny/app.R).

## Antes de la primera clase

**Encuesta diagnóstica de R cerrada.** Retiramos el enlace porque caducó el formulario inicial.

[Resultados en vivo de la cohorte](https://agscl.github.io/repr2026/resultados/) · [Código de la encuesta Shiny](https://github.com/AGSCL/repr2026/tree/main/encuesta).

## Taller de la clase 1

[Material de clase 2026 (PDF)](https://github.com/AGSCL/repr2026/blob/main/2026-1%20Reproducibilidad.pdf) · [Enunciado original del ejercicio ENSSEX](https://github.com/AGSCL/repr2026/blob/main/Enunciado-ENSSEX.md).

Calcula los cuatro porcentajes de la base ENSSEX que recibiste. Intercambia el proyecto con un compañero. Al abrir el suyo, anota cuántas líneas tuviste que cambiar y compara tus cuatro resultados con los que obtuvo él usando esa misma base y los mismos decimales.

**Tutor opcional de R (SWIRL).** `TallerUDP` es el nombre del proyecto que contiene la ayuda ENSSEX y el repaso de precios de esta clase. [Descarga ambos recorridos en un ZIP](https://github.com/AGSCL/repr2026/raw/refs/heads/main/TallerUDP.zip).

Descomprime el ZIP, abre `TallerUDP.Rproj` y ejecuta `source("iniciar.R", encoding = "UTF-8")` en la consola. Cuando vuelva a aparecer `>`, escribe `swirl()`. La primera instalación requiere internet.

- **ENSSEX** explica el intercambio de proyectos. Después de una pregunta puedes consultar el ZIP, una ruta que falla, el libro de códigos, la comparación de porcentajes o la reflexión final. Al volver otro día, ejecuta el iniciador y escribe `consultas_enssex()` para ir directo al menú.
- **Precios** es un repaso opcional de R con datos de ODEPA. Puedes comenzar por la consola o ir directamente a leer el CSV y reproducir una tabla.

[Cómo usar SWIRL, paso a paso](https://github.com/AGSCL/repr2026/blob/main/TallerUDP/README.md) · [Vista docente de las preguntas, alternativas y pistas](https://github.com/AGSCL/repr2026/blob/main/_doc/docencia/Preguntas-clase1.md).

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

Para trabajar en clase, parte del enunciado y de los datos. Las pautas y las herramientas de revisión son para quien prepara la clase.

| Carpeta | Qué contiene |
| --- | --- |
| `_data/` | Datos de entrada y diccionarios. |
| `_outputs/` | Archivos producidos para entregar: tablas, documentos y el HTML/ZIP de Git. |
| `_figures/` | Figuras exportadas, como PNG y SVG. |
| `_lit/` | Bibliografía. |
| `_doc/` | Documentación y entorno; `docencia/` contiene las pautas con respuestas. |
| `_lib/` | Archivos de apoyo y `revisar_leccion.R`, herramienta docente para probar la práctica de precios y generar su pauta. |
| `_hist/` | Versiones anteriores; el desarrollo anterior del taller Git queda archivado localmente e ignorado por Git. |
| `resultados/` | Tablero web de la encuesta publicado en GitHub Pages. Se mantiene esta ruta para conservar su enlace público. |
| `clase-git/` | Diapositivas de Git y GitHub publicadas en GitHub Pages (`index.html`), su fuente (`_clase_git.qmd`) y `kit-enssex.zip`, que reúne `_lib/kit-enssex/index.qmd` y `_data/enssex_base1.csv`. |
| `clase-shiny/` | Diapositivas de Shiny publicadas en GitHub Pages (`index.html`) y su fuente (`_clase_shiny.qmd`). La app, su variante con la ENSSEX y la receta de GitHub Actions están en `_lib/kit-shiny/`; las capturas, en `_figures/shiny/`. |
| `encuesta/` | Código de la encuesta Shiny y preparación del tablero. |
| `TallerUDP/` | Fuente del tutor SWIRL opcional para ENSSEX y precios; `TallerUDP.zip` es su descarga. |

**`resultados/` y `_outputs/` cumplen funciones distintas:** el primero es una página web publicada; el segundo guarda entregables y archivos generados.

El PDF, el enunciado y el notebook Colab permanecen en la raíz para conservar los enlaces compartidos. `.Rproj`, `.Rprofile`, `DESCRIPTION`, `renv.lock` y `renv/` también se mantienen allí: identifican y restauran el proyecto R.

<details>
<summary>Ver árbol de archivos</summary>

```text
repr2026
 |--00estructura_proyecto.R
 |--2026-1 Reproducibilidad.pdf
 |--DESCRIPTION
 |--Enunciado-ENSSEX.md
 |--README.md
 |--TallerUDP
 |--TallerUDP.zip
 |--_data
 |--_doc
 |   `--entorno.txt
 |--_figures
 |--_hist
 |--_lib
 |--_lit
 |--_outputs
 |--clase-git
 |--clase-shiny
 |--ejemplo_google_colab.ipynb
 |--encuesta
 |--renv
 |--renv.lock
 |--repr2026.Rproj
 `--resultados
```

</details>

## Material de clase

- [Ejemplo en Google Colab](https://colab.research.google.com/drive/1uHuQvINVgw1l__oTZHG_O5zXJ7NR0wpY?usp=sharing)
- [Proyecto en Posit Cloud](https://posit.cloud/content/13059382)
- [Script explicado en Posit Connect](https://agonzalezsc-udp-00estructura-proyecto.share.connect.posit.cloud/)
- [Clases de 2024 (AGSCL)](https://github.com/AGSCL/repr)
- [Clases de 2025 (JoseRTM)](https://github.com/JoseRTM/Reproducibilidad-UDP/)
<!-- fin: 00estructura_proyecto.R -->
