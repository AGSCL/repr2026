# Ejercicio: ¿corre en el computador de otra persona?

Trabaje con alguien que tenga la misma base que usted. Cada uno prepara su proyecto de forma independiente antes de intercambiarlo.

1. Cree un proyecto en RStudio, copie `00estructura_proyecto.R` a la raíz y edite su sección 1. En `paquetes` agregue los que vaya a usar (por ejemplo, `"dplyr"` y `"readr"`) y ejecute el script completo.
2. Copie su base en `_data/` y cree `analisis.R` en la raíz del proyecto, junto al archivo `.Rproj`. En ese script calcule los 4 porcentajes de su base (tabla abajo).
3. En la misma sesión donde ejecutó el script completo, vuelva a correr la sección 6 de `00estructura_proyecto.R` para actualizar el árbol del README. Comprima la carpeta del proyecto en un .zip y envíesela a un compañer@.
4. Con el proyecto de su compañer@: descomprímalo, abra el `.Rproj`, corra `renv::restore()` y luego `source("analisis.R", encoding = "UTF-8")`.
   **Cuente cuántas líneas tuvo que cambiar para que corriera. Lo ideal es 0.**
5. Envíe por correo:
   - una captura del data.tree de su compañer@ (está en su `README.md`);
   - cuántas líneas cambió y cuáles;
   - una reflexión con al menos dos fortalezas, dos debilidades y dos amenazas a la reproducibilidad del proyecto de su compañer@.

**Sobre Google Colab:** el cuaderno `ejemplo_google_colab.ipynb` es otro ejemplo de compendio y genera su árbol en la sección 7. Este enunciado sigue `00estructura_proyecto.R`, cuya sección correspondiente es la 6.

| Base | Indicador 1 | Indicador 2 | Indicador 3 | Indicador 4 |
|---|---|---|---|---|
| **1** | % Estado civil (p7): Casado(a) | % Última vez que consumió alcohol (i_5_p26): Durante los últimos 30 días | % Depende económicamente de su pareja (p93): Sí, completamente | % Papanicolaou en los últimos tres años (p21b): Sí, durante el último año |
| **2** | % Salud en general (p10): Buena o Muy buena | % Síntomas PHQ-4 (phq4_cat): Moderados o Severos | % Última vez que consumió marihuana (i_2_p26): Durante los últimos 30 días | % Antígeno prostático en los últimos tres años (p21c): Sí, durante el último año |
| **3** | % La homosexualidad es tan válida como cualquier otra (i_4_p28): De acuerdo o Muy de acuerdo | % En su familia se conversaban temas sexuales (p34): No se conversaban | % Ha probado marihuana alguna vez (i_2_p25): Sí | % Papanicolaou alguna vez (p20b): Sí |
| **4** | % Mamografía alguna vez (p20a): Sí | % Es necesario usar preservativo aun con pareja estable (i_3_p33): De acuerdo o Muy de acuerdo | % Diagnosticado con COVID-19 (p19): Sí | % Calidad de vida (p8): Buena o Muy buena |
