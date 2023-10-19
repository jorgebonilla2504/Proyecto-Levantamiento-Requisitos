const fs = require('fs');

export function modificarArchivoCSV(archivoCSV, datos) {
  const BOM = '\uFEFF';
  const contenidoCSV = datos.map((fila) => Object.values(fila).join(','));
  contenidoCSV.unshift(Object.keys(datos[0]).join(','));
  const contenidoFinal = contenidoCSV.join('\n');
  fs.writeFileSync(archivoCSV, BOM + contenidoFinal, 'utf-8');
}
