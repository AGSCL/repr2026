// GUARDAR RESPUESTAS EN UNA GOOGLE SHEET (sin claves ni paquetes en R)
// Una sola vez:
// 1. Crear una Google Sheet vacia > Extensiones > Apps Script > pegar este codigo
// 2. Implementar > Nueva implementacion > Aplicacion web
//    Ejecutar como: Yo | Quien tiene acceso: Cualquier usuario > Implementar
//    Copiar la URL que termina en /exec y pegarla en 'script' (app.R)
// 3. Para el tablero publico: Compartir > Acceso general > Cualquier persona con el enlace: Lector.
//    Andres y Constanza pueden editar. El tablero consulta el CSV de la pestana Panel2026.
function doPost(e) {
  LockService.getScriptLock().waitLock(10000);                        // si envian varios a la vez, uno por uno
  const hoja = SpreadsheetApp.getActiveSpreadsheet().getSheets()[0];  // primera pestana
  const fila = JSON.parse(e.postData.contents);                       // respuesta enviada por app.R
  if (hoja.getLastRow() === 0) hoja.appendRow(Object.keys(fila));     // encabezado la primera vez
  hoja.appendRow(Object.values(fila).map(v => "'" + v));              // ' = guardar como texto (no formulas ni fechas)
  return ContentService.createTextOutput("ok");
}
