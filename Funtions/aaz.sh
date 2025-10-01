#!/bin/bash

# Version: 1.0.2
# Update: 2025-09-30 22:23 (UTC -06-00)
# aaz.sh - Compresor GuerreroAzul (AAZ = Archivo Azul)
# Uso:
#   aaz c <archivos...|carpetas...> [salida.aaz]   -> Comprimir
#   aaz x <archivo.aaz> [destino]                  -> Descomprimir

cmd="$1"
shift

case "$cmd" in
  c|compress)
    if [ $# -lt 1 ]; then
      echo "ERROR: Debes especificar al menos un archivo o carpeta para comprimir."
      exit 1
    fi

    # Si el último argumento termina en .aaz, lo usamos como salida
    last_arg="${@: -1}"
    if [[ "$last_arg" == *.aaz ]]; then
      output="$last_arg"
      set -- "${@:1:$(($#-1))}"  # quitamos el último (nombre de salida)
    else
      output="archivos.aaz"
    fi

    tar -cf - "$@" | zstd -19 -o "$output"
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
    echo "  $0 c <archivos...|carpetas...> [salida.aaz]"
    echo "  $0 x <archivo.aaz> [destino]"
    exit 1
    ;;
esac
