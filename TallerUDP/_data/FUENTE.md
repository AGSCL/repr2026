# Precios al consumidor en las ferias libres del sector Coquimbo

La Oficina de Estudios y Políticas Agrarias (ODEPA), Chile, publicó estos datos de 2025. La versión consultada el 11 de noviembre de 2026 se actualizó el 29 de abril de 2026. La ficha declara la licencia Creative Commons Atribución (CC BY). [Portal citado en la clase](https://datos.gob.cl/dataset/precios-al-consumidor) · [Ficha, licencia y diccionario de ODEPA](https://datos.odepa.gob.cl/dataset/precios-consumidor/resource/eab239c4-e338-4cde-a9e0-7c4f27826030) · [Descargar el CSV anual original](https://datos.odepa.gob.cl/dataset/d4646b7f-0d2e-4567-b6fa-932b1a6bb3f3/resource/eab239c4-e338-4cde-a9e0-7c4f27826030/download/precio_consumidor_2025.csv)

## Cómo repetir el recorte

1. Descarga el archivo anual. Su MD5 es `32a725335f9ff1f0e497957e7b5fd9f2`. En R, léelo con `read.csv(archivo, dec = ",", fileEncoding = "UTF-8-BOM", check.names = FALSE)`.
2. Selecciona `Anio = 2025`, `Mes` igual a 7 u 8, `ID region = 4`, `Sector = "Coquimbo"`, `Tipo de punto monitoreo = "Feria libre"` y `Unidad = "$/kilo"`.
3. En `Grupo = "Frutas"`, conserva `Kiwi|Hayward|Primera` y `Manzana|Granny Smith|Primera`. En `Grupo = "Hortalizas"`, conserva `Papa|Asterix|Primera` y `Zanahoria|Sin especificar|Primera`. Son los nombres exactos del campo `Producto`.
4. Conserva año, mes, semana, región, sector, tipo de comercio, grupo, producto, unidad y precio promedio. El recorte usa nombres de columnas en minúsculas sin tildes y con guion bajo. Ordena por semana, grupo y producto y exporta en UTF-8 con punto decimal.

Cada fila contiene el `Precio promedio` semanal publicado por ODEPA, en pesos chilenos por kilo. Los cuatro productos aparecen una vez en cada semana 27 a 35. Las 36 filas se distribuyen entre julio (20) y agosto (16).

Para la actividad, calcula la media simple de esas filas por `grupo` y `mes`. Cada producto y semana aporta el mismo peso dentro de su mes. El resultado describe los cuatro productos elegidos en este sector y canal de venta.
