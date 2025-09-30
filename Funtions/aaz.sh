#!/bin/bash
# aaz.sh - Compresor GuerreroAzul (AAZ = Archivo Azul)
# Uso:
#   aaz c <carpeta|archivo>        -> Comprimir
#   aaz x <archivo.aaz> [destino]  -> Descomprimir

cmd="$1"
shift

case "$cmd" in
  c|compress)
    if [ -z "$1" ]; then
      echo "ERROR: Debes especificar un archivo o carpeta para comprimir."
      exit 1
    fi
    input="$1"
    output="${input%/}.aaz"
    tar -cf - "$input" | zstd -19 -o "$output"
    echo "✔ Comprimido en: $output"
    ;;
  x|extract)
    if [ -z "$1" ]; then
      echo "ERROR: Debes especificar un archivo .aaz para descomprimir."
      exit 1
    fi
    input="$1"
    dest="${2:-.}"  # si no se indica, usa el directorio actual
    mkdir -p "$dest"
    zstd -d -c "$input" | tar -xf - -C "$dest"
    echo "✔ Extraído en: $dest"
    ;;
  *)
    echo "Uso:"
    echo "  $0 c <archivo/carpeta>"
    echo "  $0 x <archivo.aaz> [destino]"
    exit 1
    ;;
esac
