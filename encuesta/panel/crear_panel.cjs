const CLAVES_PANEL = [
  'NA', '6', 'Para añadir capas al gráfico', 'Marca la carpeta de trabajo del proyecto',
  'Esa carpeta solo existe en el computador de Ana', 'Las versiones de los paquetes usados',
  'Mínimo, cuartiles, media y máximo'
];
const CURSOS_PANEL = [
  'Fundamentos de Data Science', 'Exploración de Datos', 'Manipulación de Datos', 'Visualización de Datos'
];
const TEMAS_PANEL = [
  'Organizar proyectos y carpetas', 'Control de versiones (Git y GitHub)', 'Versiones de paquetes (renv)',
  'Informes reproducibles (Quarto o R Markdown)', 'Trabajar en la nube (Posit Cloud o Google Colab)'
];

// Vocabulario temático público. Agrupa flexiones, descarta muletillas, nombres y contactos.
const PALABRAS_PANEL = {
  'R': 'r', 'RStudio': 'rstudio', 'Python': 'python', 'SQL': 'sql', 'Excel': 'excel',
  'Git': 'git', 'GitHub': 'github', 'Quarto': 'quarto', 'Markdown': 'markdown', 'renv': 'renv',
  'tidyverse': 'tidyverse', 'dplyr': 'dplyr', 'ggplot2': 'ggplot2 ggplot', 'código': 'codigo codigos',
  'programación': 'programacion programar programando', 'sintaxis': 'sintaxis',
  'funciones': 'funcion funciones', 'comandos': 'comando comandos', 'paquetes': 'paquete paquetes',
  'objetos': 'objeto objetos', 'scripts': 'script scripts', 'instalación': 'instalacion instalar configuracion configurar',
  'errores': 'error errores', 'depuración': 'depurar depuracion debug debugging',
  'datos': 'dato datos dataset datasets', 'bases': 'base bases', 'tablas': 'tabla tablas',
  'limpieza': 'limpieza limpiar', 'manipulación': 'manipular manipulacion transformar transformacion',
  'análisis': 'analisis analizar analitica', 'exploración': 'exploracion explorar exploratorio exploratoria',
  'estadística': 'estadistica estadisticas estadistico estadisticos', 'matemáticas': 'matematica matematicas',
  'modelos': 'modelo modelos modelar modelamiento modelado', 'visualización': 'visualizar visualizacion visualizaciones',
  'gráficos': 'grafico graficos graficar graficas', 'interpretación': 'interpretacion interpretar',
  'indicadores': 'indicador indicadores', 'resultados': 'resultado resultados',
  'reproducibilidad': 'reproducibilidad reproducible reproducibles reproducir replicar',
  'proyectos': 'proyecto proyectos', 'organización': 'organizar organizacion orden ordenar',
  'carpetas': 'carpeta carpetas directorio directorios', 'rutas': 'ruta rutas',
  'archivos': 'archivo archivos fichero ficheros', 'versiones': 'version versiones versionado',
  'repositorios': 'repositorio repositorios', 'documentación': 'documentacion documentar',
  'informes': 'informe informes reporte reportes reportar', 'automatización': 'automatizar automatizacion',
  'colaboración': 'colaborar colaboracion colaborativo equipo equipos', 'nube': 'nube cloud colab',
  'comunicación': 'comunicar comunicacion presentar presentacion', 'investigación': 'investigacion investigar',
  'aplicación': 'aplicar aplicacion aplicaciones', 'trabajo': 'trabajo laboral profesional',
  'práctica': 'practica practicas practicar', 'ejercicios': 'ejercicio ejercicios ejercitar',
  'ejemplos': 'ejemplo ejemplos', 'teoría': 'teoria teorico teorica', 'conceptos': 'concepto conceptos conceptual',
  'experiencia': 'experiencia inexperiencia', 'conocimientos previos': 'previos previas prerrequisitos',
  'tiempo': 'tiempo tiempos', 'ritmo': 'ritmo rapido acelerado velocidad',
  'carga': 'carga sobrecarga', 'contenidos': 'contenido contenidos materia temario',
  'instrucciones': 'instruccion instrucciones enunciado enunciados', 'explicaciones': 'explicar explicacion explicaciones',
  'metodología': 'metodologia metodologias', 'materiales': 'material materiales recursos',
  'acompañamiento': 'acompanamiento apoyo ayuda', 'retroalimentación': 'retroalimentacion feedback',
  'evaluaciones': 'evaluacion evaluaciones prueba pruebas', 'autonomía': 'autonomia independiente',
  'confianza': 'confianza seguridad', 'inglés': 'ingles idioma', 'conexión': 'conexion conectividad internet'
};

const campos = ['nombre', 'experiencia', 'interes', 'dificil', 'facil', 'por_que', 'expectativas',
                ...CLAVES_PANEL.map((_, i) => 'k' + (i + 1))];
const literal = s => '"' + String(s).replace(/"/g, '""') + '"';
const columna = textos => 'VSTACK(' + textos.map(literal).join(',') + ')';
const fila = textos => 'HSTACK(' + textos.map(literal).join(',') + ')';

// Solo la prueba en memoria usa filas simuladas. Escribe un único booleano de control.
function fixture() {
  const encabezado = ['cohorte', 'es_prueba', ...campos];
  const ejemplo = (nombre, experiencia, notas, resto = {}) => {
    const r = {cohorte: '2026', nombre, experiencia, ...resto};
    notas.forEach((v, i) => {r['k' + (i + 1)] = v;});
    return fila(encabezado.map(k => r[k] || ''));
  };
  const no = CLAVES_PANEL.map(() => 'No sé');
  const datos = [ejemplo('id-A', 'Más de 2 años', no, {expectativas:'git'}),
    ejemplo('id-A','Entre 6 meses y 2 años',CLAVES_PANEL,{expectativas:'Proyectos, proyectos reproducibles', por_que:'Tiempo tiempo', dificil:CURSOS_PANEL[1]}),
    ejemplo('','Nunca lo he usado',no,{expectativas:'proyectos reproducibles',por_que:'Ritmo',facil:CURSOS_PANEL[0]}),
    ejemplo('','Menos de 6 meses',CLAVES_PANEL.map((v,i) => i < 4 ? v : 'No sé')),
    ejemplo('','Menos de 6 meses',CLAVES_PANEL.map((v,i) => i < 5 ? v : 'No sé')),
    ejemplo('','Más de 2 años',CLAVES_PANEL,{cohorte:'2025'}),
    ejemplo('','Más de 2 años',CLAVES_PANEL,{es_prueba:'true'}),
    ejemplo('','Más de 2 años',CLAVES_PANEL,{expectativas:'PRUEBA-UDP-2026-ficticia'})];
  return 'muestra,VSTACK(' + datos.join(',') + '),obtener,LAMBDA(campo,CHOOSECOLS(muestra,MATCH(campo,' + fila(encabezado) + ',0)))';
}

function formula(hoja, locale = 'en_US', prueba = false, sep) {
  if (!hoja || !locale) throw new Error('Faltan el nombre de la pestaña o la configuración regional.');
  const separador = sep || (new Intl.NumberFormat(locale.replace(/_/g,'-')).format(1.5).includes(',') ? ';' : ',');
  if (![',',';'].includes(separador)) throw new Error('Separador de argumentos no válido.');
  const origen = "'" + hoja.replace(/'/g,"''") + "'!";
  // Resuelve cada columna por su encabezado y lee desde la fila 2 hasta el final.
  const fuente = prueba ? fixture() : 'obtener,LAMBDA(campo,LET(letra,REGEXREPLACE(ADDRESS(1,MATCH(campo,' +
    origen + '1:1,0),4),"1$",""),INDIRECT(' + literal(origen) + '&letra&"2:"&letra)))';
  const catalogo = columna(Object.keys(PALABRAS_PANEL));
  const patrones = columna(Object.values(PALABRAS_PANEL).map(v => '(^|[^a-z0-9])(' + v.replace(/ /g,'|') + ')([^a-z0-9]|$)'));
  let limpio = 'REGEXREPLACE(LOWER(textos&""),"https?://\\S+|www[.]\\S+|\\S+@\\S+"," ")';
  for (const [de,a] of Object.entries({á:'a',é:'e',í:'i',ó:'o',ú:'u',ü:'u',ñ:'n'})) {
    limpio = 'SUBSTITUTE(' + limpio + ',' + literal(de) + ',' + literal(a) + ')';
  }
  const completo = `=ARRAYFORMULA(LET(
    ${fuente},
    bruto,HSTACK(${campos.map(k=>'obtener('+literal(k)+')').join(',')}),
    cohorte,obtener("cohorte")&"",
    valido,(cohorte="2026")*(REGEXMATCH(LOWER(TRIM(IFNA(obtener("es_prueba"),"")&"")),"^(true|1|verdadero)$")=FALSE)*
           (REGEXMATCH(TRIM(CHOOSECOLS(bruto,1)&""),"^PRUEBA-UDP-")=FALSE)*
           (REGEXMATCH(TRIM(CHOOSECOLS(bruto,7)&""),"^PRUEBA-UDP-2026-[A-Za-z0-9][A-Za-z0-9_-]*$")=FALSE),
    candidatos,IFNA(FILTER(bruto,valido),${fila(campos.map(()=>''))}),
    nombres,LOWER(TRIM(CHOOSECOLS(candidatos,1)&"")),
    orden,SEQUENCE(ROWS(candidatos)),
    ids,IF(nombres="","anon:"&orden,"nombre:"&nombres),
    datos,FILTER(candidatos,MAP(ids,LAMBDA(id,XMATCH(id,ids,0,-1)))=orden),
    total,IF(SUM(valido),ROWS(datos),0),
    meses,CHOOSECOLS(datos,2),
    expnum,SUM((meses="Entre 6 meses y 2 años")+(meses="Más de 2 años")),
    notas,BYROW(CHOOSECOLS(datos,8,9,10,11,12,13,14),LAMBDA(resp,IF(SUM(--(resp<>""))=7,
      LET(p,SUM(--((resp&"")=${fila(CLAVES_PANEL)}))/7,IF(p<=3/5,1+5*p,4+15/2*(p-3/5))),""))),
    cerradas,LAMBDA(grupo,etiquetas,colnum,HSTACK(IF(etiquetas<>"",grupo,""),etiquetas,
      MAP(etiquetas,LAMBDA(opcion,SUM(--(CHOOSECOLS(datos,colnum)=opcion)))))),
    palabras,${catalogo}, patrones,${patrones},
    nube,LAMBDA(grupo,colnum,LET(textos,CHOOSECOLS(datos,colnum),limpios,${limpio},
      veces,MAP(patrones,LAMBDA(patron,SUM(--REGEXMATCH(limpios,patron)))),
      IFNA(ARRAY_CONSTRAIN(SORT(FILTER(HSTACK(IF(palabras<>"",grupo,""),palabras,veces),veces>=2),3,FALSE,2,TRUE),30,3),HSTACK("","","")))),
    cursos,${columna(CURSOS_PANEL)},
    tabla,VSTACK(HSTACK("grupo","etiqueta","valor"),HSTACK("meta","total",total),
      HSTACK("experiencia","6_meses_o_mas",expnum),HSTACK("nota","promedio",IFERROR(AVERAGE(notas),"")),
      cerradas("interes",${columna(TEMAS_PANEL)},3),cerradas("dificil",cursos,4),cerradas("facil",cursos,5),
      nube("por_que",6),nube("expectativas",7)),
    salida,FILTER(tabla,CHOOSECOLS(tabla,1)<>""),
    ${prueba ? 'AND(INDEX(salida,2,3)=4,INDEX(salida,3,3)=1,ABS(INDEX(salida,4,3)-117/28)<1/1000000,ROWS(salida)=19,SUM((CHOOSECOLS(salida,1)="expectativas")*(CHOOSECOLS(salida,2)="proyectos")*(CHOOSECOLS(salida,3)=2))=1,SUM(--(CHOOSECOLS(salida,1)="por_que"))=0)' : 'salida'}
  ))`.replace(/\s*\n\s*/g,'');
  // Cambia solo separadores entre argumentos, nunca comas de etiquetas o nombres.
  return separador === ',' ? completo : completo.replace(/"(?:[^"]|"")*"|'(?:[^']|'')*'|,/g, x=>x===','?';':x);
}

function solicitud(hoja, sheetId, locale = 'en_US', conPrueba = false, separador) {
  if (!Number.isInteger(sheetId) || sheetId < 0) throw new Error('sheetId no válido.');
  function celda(col, esPrueba) {
    return {updateCells:{start:{sheetId,rowIndex:0,columnIndex:col},fields:'userEnteredValue',
      rows:[{values:[{userEnteredValue:{formulaValue:formula(hoja,locale,esPrueba,separador)}}]}]}};
  }
  return {requests: conPrueba ? [celda(0,false), celda(3,true)] : [celda(0,false)]};
}

module.exports = {formula, solicitud};
if (require.main === module) {
  const [hoja, sheetId, locale = 'en_US', prueba = 'no', sep] = process.argv.slice(2);
  console.log(JSON.stringify(solicitud(hoja,Number(sheetId),locale,prueba==='qa',sep)));
}
