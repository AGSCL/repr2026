# Ejercicio: ¿corre en el computador de otra persona?

1. Cree un proyecto en RStudio y corra `estructura_proyecto.R`. En `paquetes` agregue los que vaya a usar (por ejemplo, `"dplyr"` y `"readr"`).
2. Copie su base en `_data/` y, en `_lib/analisis.R`, calcule los 4 porcentajes de su base (tabla abajo).
3. Vuelva a correr la sección 7 de `estructura_proyecto.R` (actualiza el data.tree), comprima la carpeta del proyecto en un .zip y envíesela a un compañer@.
4. Con el proyecto de su compañer@: descomprímalo, abra el `.Rproj`, corra `renv::restore()` y luego `_lib/analisis.R`.
   **Cuente cuántas líneas tuvo que cambiar para que corriera. Lo ideal es 0.**
5. Envíe por correo:
   - una captura del data.tree de su compañer@ (está en su `README.md`);
   - cuántas líneas cambió y cuáles;
   - una reflexión con al menos dos fortalezas, dos debilidades y dos amenazas a la reproducibilidad del proyecto de su compañer@.

| Base | Indicador 1 | Indicador 2 | Indicador 3 | Indicador 4 |
|---|---|---|---|---|
| **1** | % Estado civil (p7): Casado(a) | % Última vez que consumió alcohol (i_5_p26): Durante los últimos 30 días | % Depende económicamente de su pareja (p93): Sí, completamente | % Papanicolaou en los últimos tres años (p21b): Sí, durante el último año |
| **2** | % Salud en general (p10): Buena o Muy buena | % Síntomas PHQ-4 (phq4_cat): Moderados o Severos | % Última vez que consumió marihuana (i_2_p26): Durante los últimos 30 días | % Antígeno prostático en los últimos tres años (p21c): Sí, durante el último año |
| **3** | % La homosexualidad es tan válida como cualquier otra (i_4_p28): De acuerdo o Muy de acuerdo | % En su familia se conversaban temas sexuales (p34): No se conversaban | % Ha probado marihuana alguna vez (i_2_p25): Sí | % Papanicolaou alguna vez (p20b): Sí |
| **4** | % Mamografía alguna vez (p20a): Sí | % Es necesario usar preservativo aun con pareja estable (i_3_p33): De acuerdo o Muy de acuerdo | % Diagnosticado con COVID-19 (p19): Sí | % Calidad de vida (p8): Buena o Muy buena |
