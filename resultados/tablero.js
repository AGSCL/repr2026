"use strict";

const fuente = document.querySelector('meta[name="csv-url"]').content;
const elemento = (id) => document.getElementById(id);
const numero = (n, decimales = 0) => n.toLocaleString("es-CL", {
  minimumFractionDigits: decimales, maximumFractionDigits: decimales
});
let ultimaLectura = null;
let consultando = false;

function leerCSV(texto) {
  const lineas = texto.replace(/^\uFEFF/, "").trimEnd().split(/\r?\n/);
  // El feed tiene tres campos por fila. Sus etiquetas son categorías o términos individuales.
  const campo = '("(?:[^"]|"")*"|[^",]*)';
  const formato = new RegExp("^" + [campo, campo, campo].join(",") + "$");
  const filas = lineas.map(linea => {
    const coincidencia = formato.exec(linea);
    if (!coincidencia) throw new Error("Fila CSV inválida");
    return coincidencia.slice(1).map(s => s.startsWith('"') ? s.slice(1, -1).replace(/""/g, '"') : s);
  });
  if (filas.shift().join(",") !== "grupo,etiqueta,valor") throw new Error("CSV inesperado");
  const grupos = new Map();
  const series = ["interes", "dificil", "facil", "por_que", "expectativas"];
  const resumen = new Map([["meta", "total"], ["experiencia", "6_meses_o_mas"], ["nota", "promedio"]]);
  for (const [grupo, etiqueta, bruto] of filas) {
    if (!grupo && !etiqueta && !bruto.trim()) continue;
    if (!etiqueta.trim() || (!series.includes(grupo) && resumen.get(grupo) !== etiqueta)) {
      throw new Error("Serie inesperada");
    }
    const cifra = bruto.trim();
    if (cifra && !/^\d+(?:[.,]\d+)?(?:e[+-]?\d+)?$/i.test(cifra)) throw new Error("Valor inválido");
    const valor = cifra === "" ? null : Number(cifra.replace(",", "."));
    if (valor !== null && (!Number.isFinite(valor) || valor < 0)) throw new Error("Valor inválido");
    if (!grupos.has(grupo)) grupos.set(grupo, new Map());
    const serie = grupos.get(grupo);
    if (serie.has(etiqueta)) throw new Error("Etiqueta repetida");
    serie.set(etiqueta, valor);
  }
  const total = grupos.get("meta")?.get("total");
  const conExperiencia = grupos.get("experiencia")?.get("6_meses_o_mas");
  const nota = grupos.get("nota")?.get("promedio");
  if (!Number.isSafeInteger(total) || !Number.isSafeInteger(conExperiencia) ||
      conExperiencia > total || (nota !== null && !(total > 0 && nota >= 1 && nota <= 7))) {
    throw new Error("Resumen incompleto");
  }
  for (const id of series) {
    const nube = id === "por_que" || id === "expectativas";
    let suma = 0;
    for (const valor of grupos.get(id)?.values() ?? []) {
      if (!Number.isSafeInteger(valor) || valor > total || (nube && valor < 2)) throw new Error("Recuento inválido");
      suma += valor;
    }
    if (!nube && suma > total) throw new Error("Recuento incompatible con el total");
  }
  return { grupos, total, conExperiencia, nota };
}

function nodo(tipo, clase, texto) {
  const el = document.createElement(tipo);
  if (clase) el.className = clase;
  if (texto !== undefined) el.textContent = texto;
  return el;
}

function barras(id, serie, maximo) {
  const filas = serie.map(([etiqueta, n]) => {
    const fila = nodo("li");
    const pista = nodo("span", "pista");
    const tinta = nodo("i");
    tinta.style.width = (100 * n / Math.max(1, maximo)) + "%";
    pista.setAttribute("aria-hidden", "true");
    pista.append(tinta);
    fila.append(nodo("span", "", etiqueta), nodo("span", "valor", numero(n)), pista);
    return fila;
  });
  elemento(id).replaceChildren(...filas);
}

function nube(id, serie) {
  if (!serie.length) {
    elemento(id).replaceChildren(nodo("li", "vacio", "Aún no hay términos repetidos."));
    return;
  }
  serie.sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0], "es"));
  const maximo = serie[0][1], minimo = serie[serie.length - 1][1];
  const filas = serie.map(([palabra, n]) => {
    const fila = nodo("li", "", palabra);
    const frecuencia = n === 1 ? "1 respuesta" : numero(n) + " respuestas";
    const peso = maximo > minimo ? (n - minimo) / (maximo - minimo) : 0.5;
    fila.style.fontSize = (1.1 + peso * 1.45) + "rem";
    fila.style.color = peso >= 0.5 ? "var(--udp)" : "var(--texto)";
    fila.title = frecuencia;
    fila.append(nodo("span", "lector", ", " + frecuencia));
    return fila;
  });
  elemento(id).replaceChildren(...filas);
}

function dibujar({ grupos, total, conExperiencia, nota }) {
  const serie = id => Array.from(grupos.get(id) ?? []);
  const porcentaje = total ? 100 * conExperiencia / total : 0;
  elemento("total").textContent = total === 1 ? "1 respuesta" : numero(total) + " respuestas";
  elemento("pie").toggleAttribute("data-datos", total > 0);
  elemento("pie").style.setProperty("--porcion", porcentaje + "%");
  elemento("porcentaje").textContent = total ? numero(porcentaje, Number.isInteger(porcentaje) ? 0 : 1) + " %" : "—";
  elemento("nota").textContent = nota === null ? "—" : numero(nota, 1);
  elemento("base-nota").textContent = total && nota === null
    ? "Aún no hay respuestas completas en conocimientos."
    : "Nota promedio del grupo en las 7 preguntas.";
  const interes = serie("interes").sort((a, b) => b[1] - a[1]);
  const dificil = serie("dificil"), facil = serie("facil");
  const maximo = filas => Math.max(0, ...filas.map(par => par[1]));
  const escalaCursos = Math.max(maximo(dificil), maximo(facil));
  barras("interes", interes, maximo(interes));
  barras("dificil", dificil, escalaCursos);
  barras("facil", facil, escalaCursos);
  nube("por_que", serie("por_que"));
  nube("expectativas", serie("expectativas"));
}

function informar(mensaje) {
  if (elemento("estado").textContent !== mensaje) elemento("estado").textContent = mensaje;
}

async function actualizar() {
  if (consultando) return;
  consultando = true;
  const control = new AbortController();
  const limite = setTimeout(() => control.abort(), 12000);
  let aviso = "No se pudo conectar con el CSV. Revisa la conexión y el acceso público a la hoja de resultados.";
  try {
    const r = await fetch(fuente, { credentials: "omit", cache: "no-store", signal: control.signal });
    if (r.status === 401 || r.status === 403) {
      aviso = "El CSV de resultados requiere permiso de lectura pública.";
    }
    if (!r.ok) throw new Error("Lectura fallida");
    const csv = await r.text();
    if (r.headers.get("content-type")?.includes("text/html") || /^\s*</.test(csv)) {
      aviso = "Se recibió una página web en lugar del CSV. Revisa el enlace y sus permisos de lectura pública.";
      throw new Error("No se recibió un CSV");
    }
    aviso = "El CSV de resultados tiene un formato o recuento inesperado.";
    if (csv !== ultimaLectura) {
      dibujar(leerCSV(csv));
      ultimaLectura = csv;
    }
    informar(elemento("total").textContent === "0 respuestas" ? "Aún no hay respuestas de la cohorte." : "Consulta cada 5 s");
    const ahora = new Date();
    const hora = elemento("hora");
    hora.hidden = false;
    hora.dateTime = ahora.toISOString();
    hora.textContent = "Última lectura " + ahora.toLocaleTimeString("es-CL", { hour12: false });
  } catch {
    informar(aviso + (ultimaLectura === null ? " Reintentando…" : " Se muestran los últimos datos disponibles. Reintentando…"));
  } finally {
    clearTimeout(limite);
    consultando = false;
  }
}

actualizar();
setInterval(actualizar, 5000);
