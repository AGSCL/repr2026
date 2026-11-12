# Clase 1 · Preguntas y pistas del SWIRL

## ENSSEX · Primera visita

«Tu compañero va a abrir el proyecto que tú preparaste y a ejecutar tu código con la misma base que usaste. Queremos averiguar dos cosas: cuántas líneas tuvo que cambiar para que corriera y si obtuvo tus mismos cuatro porcentajes».

**Imagina que abrió tu proyecto, ejecutó el análisis y no tuvo que editar ninguna línea. ¿Qué falta comprobar?**

- **A.** Que ambos obtuvieron los mismos cuatro porcentajes al mostrarlos con la misma cantidad de decimales.
- **B.** Que obtendría esos mismos porcentajes con la otra base que le tocó trabajar.
- **C.** Nada más: si el código terminó sin errores, los resultados ya están comprobados.

<details>
<summary>Ver respuesta y pista</summary>

**A.** Cero líneas modificadas responde la primera pregunta. Para responder la segunda, necesitan comparar los cuatro porcentajes de ese mismo proyecto.

Tras B o C, SWIRL pregunta «Ya sabes que el código corrió en otro computador. ¿Qué tendrían que mirar juntos para saber si reprodujeron el resultado?».

</details>

## ENSSEX · Qué se puede consultar después

| Duda del estudiante | Qué propone la ayuda |
|---|---|
| ¿Qué pongo en el ZIP? | Mirar el árbol del README desde el punto de vista de quien recibe el proyecto. Si hace falta, ubicar el `.Rproj`, la base asignada, el análisis y los archivos de `renv` dentro del ZIP. |
| ¿Por qué R no encuentra el CSV? | Leer qué archivo menciona el error y buscarlo en el proyecto recibido. Si pide más ayuda, comprobar desde dónde lee R, listar `_data` y corregir la ruta usando el nombre real del archivo. |
| ¿Qué comparo con mi compañero? | Emparejar por nombre los cuatro indicadores del proyecto recibido y usar la misma base y los mismos decimales. Ante una diferencia, revisar el archivo leído y qué registros entraron en el denominador. |
| ¿Qué escribo en la reflexión? | Registrar las líneas cambiadas y usar una plantilla para describir dos fortalezas, dos debilidades y dos amenazas. Hay un único ejemplo opcional. Cada estudiante fundamenta sus observaciones en el proyecto que revisó. |
| ¿Qué significa esta variable? | Buscarla en el libro de códigos del MINSAL y contrastar la etiqueta y los valores con el diccionario de la base asignada. La ayuda ampliada lleva a la sección 4 del manual. |

Para recorrer estas consultas como las verá un estudiante, abre el proyecto del taller, ejecuta `source("iniciar.R", encoding = "UTF-8")` y después `consultas_enssex()`. El ejercicio y los cuatro indicadores asignados a cada base se pueden consultar en el [enunciado original](Enunciado-ENSSEX.md).

## Precios · Repaso opcional de R

El repaso de consola plantea cuatro tareas. Las preguntas de alternativas dan una pista y permiten volver a intentar.

| Tarea | Respuesta esperada |
|---|---|
| Guardar un cálculo para que una pareja lo vuelva a ejecutar. | Guardar y compartir un script `.R`. |
| Calcular el costo de dos kilos a 1.200 pesos por kilo. | `1200 * 2` o `2 * 1200`. |
| Interpretar `[1] 2400`. | El resultado es 2.400 pesos. El `[1]` indica la posición del primer valor que R imprime en esa línea. |
| Explicar una fila de precios de manzanas de ODEPA. | Es el precio medio por kilo de esas manzanas en el sector y tipo de comercio monitoreados esa semana. |

El archivo del [repaso de consola](TallerUDP/cursos/Precios_-_Repaso_opcional_de_R/00_Repaso_de_la_consola_de_RStudio/lesson.yaml) muestra las alternativas y pistas literales. La [guía de la práctica con el CSV de precios](Preguntas-precios.md) incluye las preguntas, los comandos aceptados y las salidas que se obtienen con los datos del taller.
